<?php

// sudo env ARCHFLAGS="-arch i386" gem install mysql -- --with-mysql-config=/Applications/XAMPP/xamppfiles/bin/mysql_config
// gem install mysql -- --with-mysql-config=/usr/local/mysql-5.1.56-osx10.6-x86/bin/mysql_config
	$db = new mysqli("localhost", "root", "", "eventify");

	if($db->connect_errno > 0){
	    die('Unable to connect to database [' . $db->connect_error . ']');
	}

	$row = 1;
	if (($handle = fopen("../data/users.csv", "r")) !== FALSE) {
	    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
	        // $num = count($data);
	        // echo "<p> $num fields in line $row: <br /></p>\n";
	        $row++;
	        $statement = $db->prepare("INSERT INTO Users (user_id) VALUES (?) ");
	        // echo $statement;
	        $statement->bind_param('s', $data[0]);
	        $statement->execute();
	        echo "$data[0] \n";
	        
	    }
	    fclose($handle);
	}
?>

