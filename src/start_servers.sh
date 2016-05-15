#!/bin/bash
source config.sh    #导入设置文件

#工作循环
while [[ true ]]; do
    #访问mysql
    printf "[`date`]\n" #输出当前时间
    mysql_command="
        SELECT \`${column_port}\` ,\`${column_password}\` ,\`${column_encrypt_method}\` ,\`${column_udp_relay}\`
            FROM \`${mysql_table}\`
        WHERE \`${column_group}\` = '${server_group}'
            AND \`${column_enable}\` = 1
        ORDER BY \`${column_port}\`"    #构造查询语句
    ${mysql_mysqlexe} -h ${mysql_host} -P ${mysql_port} -u ${mysql_user} -p${mysql_password} -D ${mysql_database} -e "${mysql_command}" -N > ${mysql_temp_file} #进行查询并输出到文件
    if [[ ! -s ${mysql_temp_file} ]]; then  #查询暂存文件为空
        sleep ${mysql_refresh_time}
        continue
    fi
    #遍历已存在进程并启动服务端
    while read line
    do
        #ss-server -s 0.0.0.0 -p 8989 -k 1234 -m aes-256-cfb
        ss_command="`echo ${line} |
        awk -v ss_ssexe=${ss_ssexe} -v server_bind_ip=${server_bind_ip} '{
        printf("%s -s %s -p %s -k %s -m %s",ss_ssexe,server_bind_ip,$1,$2,$3)
        if($4==1) printf(" -u")
        }'`"
        ss_command_result=`ps -ef | grep "${ss_command}" | grep -v ps | grep -v grep | sort`
        ss_port=`echo ${line} | awk '{print $1}'`
        ss_port_result=`ps -ef | grep ${ss_ssexe} | grep "${ss_port} -k" | grep -v ps | grep -v grep | sort`
        if [[ ! -n ${ss_port_result} ]]; then
            ${ss_command} &
        else
            if [[ "${ss_command_result}" != "${ss_port_result}" ]]; then
                ss_pid=`echo ${ss_port_result} | awk '{print $2}'`
                kill ${ss_pid}
                printf "killed process pid=%s port=%s\n" ${ss_pid} ${ss_port}
                ${ss_command} &
            fi
        fi
    done < $mysql_temp_file

    sleep ${mysql_refresh_time}
    #sleep 10
done
