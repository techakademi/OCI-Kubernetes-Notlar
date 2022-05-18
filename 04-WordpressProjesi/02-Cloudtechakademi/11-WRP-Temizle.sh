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
kubectl delete persistentvolumeclaims mysql-pv-cld-claim

sleep 1
echo ""
kubectl delete persistentvolumeclaims wp-pv-cld-claim

sleep 1
echo ""
kubectl delete persistentvolume wp-pv-cld

sleep 1
echo ""
kubectl delete persistentvolume mysql-pv-cld

sleep 1
echo ""
kubectl delete secrets wrprss-mysql-cld

sleep 1
echo ""
kubectl delete configmaps mysql-config-cld

sleep 1
echo ""
kubectl delete configmaps wordpress-config-cld

echo "Temizlik Tamamlandı :)"
