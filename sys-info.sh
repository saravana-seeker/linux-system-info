#!/bin/bash


echo -e "========================================= SYSTEM INFO ======================================="  
echo -e "Hostname:\t\t"`hostname`
echo -e "Date:\t\t\t"`date` 
echo -e "uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'` 
echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor`
echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name` 
echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version` 
echo -e "Serial Number:\t\t"`cat /sys/class/dmi/id/product_serial` 
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi` 
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` 
echo -e "Kernel:\t\t\t"`uname -r` 
echo -e "Architecture:\t\t"`arch` 
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'`
echo -e "Active User:\t\t"`whoami` 
echo -e "System Main IP:\t\t"`hostname -I` 
echo ""

echo -e "========================================= CPU INFO ===========================================" 
echo -e "Memory Usage:\t"`free | awk '/Mem/{printf("%.2f%"), $3/$2*100}'` 
echo -e "Swap Usage:\t"`free | awk '/Swap/{printf("%.2f%"), $3/$2*100}'` 
echo -e "CPU Usage:\t"`cat /proc/stat | awk '/cpu/{printf("%.2f%\n"), ($2+$4)*100/($2+$4+$5)}' |  awk '{print $0}' | head -1` 
echo ""

echo -e "========================================== RAM INFO ==========================================" 
echo -e "\tMemory(RAM) Info:\t"`free -mht| awk '/Mem/{print " \tTotal: " $2 "\tUsed: " $3 "\tFree: " $4}'` 

echo -e "========================================== CURRENT PROCESS=====================================" 
echo -e "CurrentProcess:"
ps -a
echo -e "==================================== RUNNING SERVICE INFO ====================================" 
systemctl list-units | grep running|sort

echo -e "========================================= GRUB INFO ==========================================="
cat /etc/default/grub    


echo -e "========================================== USERS===============================================" 
echo -e "Users:"
cut /etc/passwd -d":" -f1 | sort 


