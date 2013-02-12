<?php

// sudo env ARCHFLAGS="-arch i386" gem install mysql -- --with-mysql-config=/Applications/XAMPP/xamppfiles/bin/mysql_config
// gem install mysql -- --with-mysql-config=/usr/local/mysql-5.1.56-osx10.6-x86/bin/mysql_config
	$db = new mysqli("localhost", "root", "", "eventify");

	if($db->connect_errno > 0){
	    die('Unable to connect to database [' . $db->connect_error . ']');
	}

	$row = 1;
	if (($handle = fopen("../data/kaggle_user_friends.csv", "r")) !== FALSE) {
	    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
	        // $num = count($data);
	        // echo "<p> $num fields in line $row: <br /></p>\n";
	        $row++;
	        $user_id = $data[0];
	        $friend_ids_text = $data[1];

			$friend_ids = preg_split("/,/", $friend_ids_text);

			foreach ($friend_ids as $friend_id) {
				$statement = $db->prepare("INSERT INTO UserFriends (user_id, friend_id) VALUES (?, ?) ");
	        	
	        	$statement->bind_param('ss', $user_id, $friend_id);
	        	$statement->execute();
			}
	        
	        echo "$user_id \n";
	        
	    }
	    fclose($handle);
	}
?>

