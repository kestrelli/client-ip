# 检查Pod状态
kubectl get pods -n kestrel-catchip -l app=real-ip-app

# 获取Ingress公网IP  
INGRESS_IP=$(kubectl get ingress real-ip-ingress -n kestrel-catchip -o jsonpath='{.status.loadBalancer.ingress[0].ip}')  
echo "测试地址: http://$INGRESS_IP"

# 发送测试请求  
curl -s http://$INGRESS_IP | grep -E 'X-Forwarded-For|X-Real-Ip'  
