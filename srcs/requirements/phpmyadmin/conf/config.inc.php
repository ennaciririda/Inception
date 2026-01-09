<?php
declare(strict_types=1);

$cfg['blowfish_secret'] = 'your_secret_key_here_change_this_in_production';

$i = 0;

$i++;
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = 'mariadb';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;

$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';
$cfg['TempDir'] = '/var/www/html/tmp';
