<?php

include 'mysql.conf';

$link=mysql_connect($ADDR,$USER,$PASSWORD) or die("Unable to connect to the database!");


if (mysql_select_db($DB_NAME)) {
	drop_db($DB_NAME);
}
create_db($DB_NAME);

mysql_select_db($DB_NAME) or die("Unable to connect to database ".$DB_NAME);

create_table($TABLE);
init_data($TABLE,$PHOTOS);
echo 'Done!';

mysql_close($link);

#######################
function drop_db($db){
	mysql_query("DROP DATABASE {$db}");
	echo 'Drop database...'.'<br>';
}

function create_db($db){
	$sql="CREATE DATABASE {$db}";
	mysql_query($sql) or die('Unable to create database.');
	echo 'Create database...'.'<br>';
}

function create_table($t){
	$sql="CREATE TABLE {$t} (name TEXT,votes INT)";
	mysql_query($sql);
	echo 'Create table...'.'<br>';
}

function init_data($t,$photos){
	
	foreach ($photos as $i => $value) {
		$sql="INSERT INTO {$t} VALUES ('{$value}',0)";
		mysql_query($sql);
	}

	echo 'Init data...'.'<br>';
	
}

?>