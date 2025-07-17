#!/bin/bash  
# 创建命名空间，名称为kestrel-catchip
kubectl create ns kestrel-catchip 

# 部署业务应用  
kubectl apply -f catchip.yaml

# 创建NodePort服务 
kubectl apply -f svc.yaml

# 配置Ingress路由 
kubectl apply -f ingress.yaml

# 获取Ingress公网IP  
sleep 30  
INGRESS_IP=$(kubectl get ingress real-ip-ingress -n kestrel-catchip -o jsonpath='{.status.loadBalancer.ingress[0].ip}')  

echo "测试地址: http://$INGRESS_IP"
