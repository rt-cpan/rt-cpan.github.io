<?php 

$png = imagecreatefrompng('svg/juice.png');

$pngw = imagesx($png);

$pngh = imagesy($png);

$background = imagecreatetruecolor($pngw,$pngh); 

$bg = imagecolorallocate($background, 80, 10,10);

imagefill($background, 0,0, $bg);

imagecopy($background,$png,0,0,0,0,$pngw, $pngh);

Header("Content-type: image/jpeg");

imagejpeg($background, '', 80);

?> 