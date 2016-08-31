<?php
$channel = new SaeChannel();
$channel_name = $_POST['to'];
$message = $_POST['message'];
$channel->sendMessage($channel_name,$message);
?>