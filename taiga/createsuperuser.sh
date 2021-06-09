#!/usr/bin/expect -f
      
set force_conservative 0  
      
set timeout -1
spawn python manage.py createsuperuser
match_max 100000
expect -exact "Username: "
send -- "root\r"
expect -exact "Email address: "
send -- "root@taiga.nemonik.com\r"
expect -exact "Password: "
send -- "password\r"
expect -exact "Password (again): "
send -- "password\r"
expect eof
