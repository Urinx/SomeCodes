<?php

include 'mysql.conf';

$link=mysql_connect($ADDR,$USER,$PASSWORD) or die("Unable to connect to the database!");
mysql_select_db($DB_NAME) or die("Unable to connect to database ".$DB_NAME);


$ip=$_SERVER["REMOTE_ADDR"];
$T2='ip';
$IP_ADDR='ip_addr';
$IP_R=mysql_query("SELECT * FROM {$T2} WHERE {$IP_ADDR}='{$ip}'");

if (mysql_fetch_row($IP_R)) {
	echo "<script>alert('你已经投过票了！')</script>";
}
else{
	if ($_POST) {
		foreach ($_POST as $name => $value) {
			$sql_addVotes="UPDATE {$TABLE} SET votes=votes+1 WHERE name='{$name}'";
			mysql_query($sql_addVotes);
			mysql_query("INSERT INTO {$T2} VALUES ('{$ip}')");
		}
	}
}


$sql_getResult="SELECT * FROM basketball ORDER BY votes";
$result=mysql_query($sql_getResult);
if (!$result) {
    echo 'Could not run query: '.mysql_error();
    exit;
}


$B=array();
$G=array();
$ALL=array();
while($row=mysql_fetch_row($result)){
	if ($row[0][0]=='b') {
		$tmp=str_replace('b', '', $row[0]);
		$B[]=array($tmp,$row[1]);
	}
	else{
		$tmp=str_replace('g', '', $row[0]);
		$G[]=array($tmp,$row[1]);
	}
}

while ($B or $G) {
	$ALL[]=array_pop($B);
	$ALL[]=array_pop($G);
}

?>

<html>
<head>
	<meta http-equiv='content-type' content='text/html;charset=UTF-8'>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<title>海豚篮球杯</title>

	<style type="text/css">
	body{
		margin: 0;
		padding: 0;
		background: url('./img/bg.png') no-repeat;
		background-size: 100% 100%;
		font-family: 微软雅黑;
	}
	header{
		height: 4%;
	}
	.p1{
		color: yellow;
		font-size: 3em;
		line-height: 50px;
	}
	.p2{
		color: white;
		font-size: 1.5em;
		line-height: 20px;
	}
	.p2 span{
		color: green;
		font-weight: bolder;
		font-size: 1.5em;
	}
	.center{
		text-align: center;
		margin-left:auto;
		margin-right:auto;
	}
	ul{
		padding: 0;
		margin: 4% 8%;
		margin-bottom: 15%;
		border: dashed white;
		border-radius: 40px;
		list-style: none;
		float: left;
	}
	ul li{
		margin: 0% 4%;
		height: 50px;
		width: 40%;
		float: left;
		text-align: center;
		font-size: 1.3em;
		font-weight: bolder;
		border-radius: 10px;
		line-height: 50px;
		color: white;
	}
	.clear{
		clear: both;
	}
	</style>
</head>

<body>
	<header></header>
	<article>
		<p class='center p1'>感谢你的投票</p>
		<p class='center p2'>分享到<span>朋友圈</sapn></p>
		<p class='center p2'>为“篮”一号加油吧~~</p>
		<div class='center'>
			<img src="./img/result.png">
		</div>

		<div class='result center'>
			<ul>
				<li>Browser</li><li>Game</li>
				<?php
					for ($i=0; $i < count($ALL); $i++) { 
						if ($ALL[$i]) {
							echo '<li>'.$ALL[$i][0].'号：'.$ALL[$i][1].'</li>';
						}
						else {
							echo '<li> </li>';
						}
					}
				?>
			</ul>
		</div>
	</article>
	<div class='clear'></div>
</body>

<script src='./js/wechat_share.js'></script>
<!-- <script src='./js/ga.js'></script> -->

</html>


<?php
mysql_close($link);
?>