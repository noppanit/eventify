<?php
	$max_num = 30377221;
	$loop = $max_num / 10;
	$db = new mysqli("localhost", "root", "", "eventify");

	if($db->connect_errno > 0){
	    die('Unable to connect to database [' . $db->connect_error . ']');
	}

	echo "Starting";

	for ($i=0; $i<=$max_num; $i++) {

		$query = "SELECT uf.id, uf.friend_id, u.user_id FROM eventify.UserFriends uf LEFT JOIN eventify.Users u on uf.friend_id = u.user_id WHERE u.user_id is NULL LIMIT 1";

		$result = $db->query($query);
		$array_ids = array();
		while($row = $result->fetch_assoc()){
			array_push($array_ids, $row["id"]);
			echo "Deleting " . $row["id"] . "\n";    
		}

		$statement = $db->prepare("DELETE from eventify.UserFriends where id IN (?)");
		$statement->bind_param('s', implode(",", $array_ids));
		$statement->execute();
	}

?>

