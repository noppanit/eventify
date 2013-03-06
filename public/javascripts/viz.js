$(function() {
	$("body").css("background", "#000");

	var w = 1300, h = 700;

	var labelDistance = 0;

	var vis = d3.select("body").append("svg:svg").attr("width", w).attr("height", h);

	var nodes = [];
	var labelAnchors = [];
	var labelAnchorLinks = [];
	var links = [];

	d3.json(
		'http://127.0.0.1:9393/event_i_should_go',
		function (jsondata) {
			
			data = jsondata[9];
				
			user = data;
			
			var user_node = {
				label : "myself"
			};

			nodes.push(user_node);
			
			$.each(user.friends, function(index, friend_id) {
				var friend_node = {
					label : "friend_"+friend_id
				};

				nodes.push(friend_node);
				
				links.push({
					source : user_node,
					target : friend_node,
					weight : Math.random(),
					label : "friend_with"
				});

			});


			$.each(user.events, function(index, event_id) {
				var event_node = {
					label : "event_"+event_id
				};

				nodes.push(event_node);
				
				links.push({
					source : user_node,
					target : event_node,
					weight : Math.random(),
					label : "created"
				});

			});

			var force = d3.layout.force().size([w, h]).nodes(nodes).links(links).gravity(1).linkDistance(300).charge(-40000).linkStrength(function(x) {
					return x.weight * 10
			});

			force.start();

			var link = vis.selectAll("line.link")
				.data(links);

			link.enter().insert("svg:line")
				.attr("class", "link")
				.style("fill", "#000")
				.style("stroke-width", 2)
				.style("stroke", "#CCC");

			link.enter().insert("svg:text")
				.style("fill", "#FFF")
				.style("font-family", "Arial")
				.style("font-size", 12)
				.attr("class", "linkText")
				.attr("y", 5)
				.attr("text-anchor", "middle")
		  		.attr("dx", function(d) { return (d.source.x + d.target.x) / 2; })
				.attr("dy", function(d) { return (d.source.y + d.target.y) / 2; })
				.text(function(d) { return d.label; });


			var node = vis.selectAll("g.node").data(force.nodes()).enter().append("svg:g").attr("class", "node");
			node.append("svg:circle").attr("r", 15).style("fill", "#FF8800").style("stroke", "#FFF").style("stroke-width", 3);
			node.append("svg:text").text(function(d, i) {
				return d.label;
			}).style("fill", "#E32636").style("font-family", "Arial").style("font-size", 12).attr("y", 30);
			node.call(force.drag);

			var updateLink = function() {
				this.attr("x1", function(d) {
					return d.source.x;
				}).attr("y1", function(d) {
					return d.source.y;
				}).attr("x2", function(d) {
					return d.target.x;
				}).attr("y2", function(d) {
					return d.target.y;
				});

			}

			var updateNode = function() {
				this.attr("transform", function(d) {
					return "translate(" + d.x + "," + d.y + ")";
				});

			}


			force.on("tick", function() {
				node.call(updateNode);
			
				vis.selectAll("line.link").attr("x1", function(d) {
					return d.source.x;
				}).attr("y1", function(d) {
					return d.source.y;
				}).attr("x2", function(d) {
					return d.target.x;
				}).attr("y2", function(d) {
					return d.target.y;
				});

				vis.selectAll("text.linkText")
					.attr("dx", function(d) { return (d.source.x + d.target.x) / 2; })
					.attr("dy", function(d) { return (d.source.y + d.target.y) / 2; });

			});


		}
	);
});
