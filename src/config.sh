#!/bin/bash
#mysql设置
mysql_mysqlexe="mysql"          #mysql客户端命令
mysql_host="rds.hiczp.com"      #mysql主机
mysql_port="3306"               #mysql端口
mysql_user="shadowsocks"        #mysql用户名
mysql_password="123456789"      #mysql密码
mysql_database="shadowsocks"    #mysql数据库
mysql_table="free_user"         #mysql数据表
mysql_refresh_time="60"         #刷新时间
mysql_temp_file="/tmp/mysqltemp"    #mysql查询结果暂存文件
#column设置
column_port="port"
column_password="passwd"
column_encrypt_method="encrypt_method"
column_udp_relay="udp_relay"
column_group="group"
column_enable="enable"
#server设置
server_bind_ip="0.0.0.0"        #监听地址
server_group="free_user"        #服务器用户组
#ss-server设置
ss_ssexe="ss-server"            #ss-server命令
