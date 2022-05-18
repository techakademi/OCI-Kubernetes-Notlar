#!/bin/sh
echo "Temizliğe Başlıyorum :)"

sleep 1
echo ""
kubectl delete -f 03-Mysql-Deployment.yml

sleep 1
echo ""
kubectl delete -f 04-Mysql-Service.yml

sleep 1
echo ""
kubectl delete -f 08-Wordpress-Deployment.yml

sleep 1
echo ""
kubectl delete -f 09-Wordpress-Service.yml

sleep 1
echo ""
kubectl delete persistentvolumeclaims mysql-pv-claim

sleep 1
echo ""
kubectl delete persistentvolumeclaims wp-pv-claim

sleep 1
echo ""
kubectl delete persistentvolume wp-pv

sleep 1
echo ""
kubectl delete persistentvolume mysql-pv

sleep 1
echo ""
kubectl delete secrets wrprss-mysql

sleep 1
echo ""
kubectl delete configmaps mysql-config

sleep 1
echo ""
kubectl delete configmaps wordpress-config

echo "Temizlik Tamamlandı :)"
