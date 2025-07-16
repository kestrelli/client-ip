#!/bin/bash   

# 1. 创建业务负载  
kubectl apply -f deployment.yaml
# 2. 创建直连服务  
kubectl apply -f service.yaml

# 3. 等待并获取CLB IP  
sleep 30  
CLB_IP=$(kubectl get svc clb-direct-pod -o jsonpath='{.status.loadBalancer.ingress[0].ip}')  
echo "[SUCCESS] CLB公网IP: $CLB_IP"  