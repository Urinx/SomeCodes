<?php
$channel = new SaeChannel();
$name = 'user'.time().'-'.rand(0,10000);
$duration = 3600;
$url = $channel->createChannel($name,$duration);

$mysql=new SaeMysql();
$sql="SELECT name FROM online LIMIT 1";
$sqlback=$mysql->getData($sql);
if ($sqlback[0]['name']) {
	$to=$sqlback[0]['name'];
	$mysql->runSql("delete from online where name='{$to}'");
}
else{
	$mysql->runSql("insert into online(name) values('{$name}')");
}
?>