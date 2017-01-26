#!/bin/bash
clear
echo -e "\e[1;32m=============================================================\e[0m"
echo 
echo -e "\e[1;37m脚本已经在腾讯云、阿里云测试可用\e[0m"
echo -e "\e[1;37m\n一键添加SSR端口脚本\e[0m"
echo -e "\e[1;37m\n奔放网：benfw.cn\e[0m"
echo -e "\e[1;37m\n执行一次可添加一个端口\n添加更多端口重新执行本脚本即可。\n执行本脚本不会删除原来的端口配置\e[0m"
echo 
echo -e "\e[1;32m=============================================================\e[0m"
#!/bin/bash
cd /root
myip=`wget http://ipecho.net/plain -O - -q ; echo`
echo -e "\e[1;37m请输入一个需要添加的端口[本机IP是:$myip]\e[0m"
read -p "(回车将默认添加端口:666):" PORT
[ -z "$PORT" ] && PORT="666"
        echo
        echo -e "---------------------------"
        echo -e "将要添加的shadowsocks端口是 = $PORT"
        echo -e "---------------------------"
        echo
echo -e "\e[1;37m请设置$PORT端口的密码\e[0m"
read -p "(回车将设置默认密码:benfw.cn):" MM
[ -z "$MM" ] && MM="benfw.cn"
        echo 
        echo -e "---------------------------"
        echo -e "您设置$PORT端口的密码为 = $MM"
        echo -e "---------------------------"
        echo 
sleep 3
echo -e "\e[1;31m正在配置防火墙...\e[0m"
iptables -A OUTPUT -p tcp --dport $PORT -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p tcp --sport $PORT -j ACCEPT >/dev/null 2>&1
iptables -A INPUT -p tcp --dport $PORT -j ACCEPT >/dev/null 2>&1
iptables -A OUTPUT -p tcp --sport $PORT -j ACCEPT >/dev/null 2>&1
echo -e "\e[1;31m正在重启防火墙...\e[0m"
service iptables save
service iptables restart
sleep 5
cd /etc
sed -i "7a\"$PORT\":\"$MM\"," shadowsocks.json >/dev/null 2>&1
cd /root
echo -e "\e[1;31m正在重启shadowsocks...\e[0m"
service shadowsocks restart
rm -rf /root/dk.sh >/dev/null 2>&1
clear
echo -e "\e[1;32m=============================================================\e[0m"
echo 
echo -e "\e[41;37m恭喜您，$PORT端口已添加成功\n$PORT端口的连接密码是$MM\e[0m"
echo -e "                      
echo -e "                     \e[1;37m欢迎访问奔放网http://ben.wap.sg\e[0m"
echo -e "                                           \e[1;37m需要开放更多端口重新执行本脚本即可\e[0m"
echo 
echo -e "\e[1;32m=============================================================\e[0m"
