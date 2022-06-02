#!/bin/bash

echo isleme baslama zamani:
date +"%H:%M:%S"

echo Mevcut Firewall kurallarinin yedegini aliyorum.
echo --------------------------------------
sudo iptables-save > ~/iptables-kurallar-yedek
sleep 2
echo yedek Kontrolünü gerceklestiriyorum
ls | grep iptables-kurallar-yedek
sleep 2
echo -----------------------------------------------------------------
echo Kurallari degistiriyorum, DROP ve REJECT kurallarını temizliyorum.
echo -----------------------------------------------------------------
grep -v "DROP"  ~/iptables-kurallar-yedek > tmpfile && mv tmpfile ~/iptables-kurallar-degisen
grep -v "REJECT" ~/iptables-kurallar-degisen > tmpfile && mv tmpfile ~/iptables-kurallar-degisen
sleep 2
echo Yeni kurallari uyguluyorum.
echo ---------------------------
sudo iptables-restore < ~/iptables-kurallar-degisen
# HAProxy'nin ihtiyaç duyduğu TCP portları.
sudo iptables -A INPUT -p tcp -m multiport --dports 80,443,22  -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --dports 80,443,22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sleep 2
echo Yeni kurallari kontrol ediyorum.
echo ---------------------------
sudo iptables -L
sleep 2
echo Degisiklikleri kayit ediyorum.
echo ---------------------------
sudo /sbin/iptables-save
sleep 2
echo ---------------------------
echo Sunucuyu Reboot ediyorum.
echo ---------------------------
sleep 5
sudo reboot
