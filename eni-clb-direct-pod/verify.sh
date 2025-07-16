#!/bin/bash  
CLB_IP=$(kubectl get svc clb-direct-pod -o jsonpath='{.status.loadBalancer.ingress[0].ip}')  
RESPONSE=$(curl -s http://$CLB_IP)  

if echo "$RESPONSE" | grep -q 'remote_addr'; then  
  IP=$(echo "$RESPONSE" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')  
  echo "✅ 验证成功!"  
  echo "客户端真实IP: $IP"  
else  
  echo "❌ 验证失败! 请检查服务状态"  