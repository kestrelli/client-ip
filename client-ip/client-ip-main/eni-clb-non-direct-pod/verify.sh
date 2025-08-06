# 检查Pod状态
kubectl get pods -n kestrelli-catchip -l app=real-ip-app
# 验证Service配置：检查NodePort是否分配（PORT(S)列显示80:3xxxx/TCP）。
kubectl get svc real-ip-service -n kestrelli-catchip
# 获取Ingress公网IP  
INGRESS_IP=$(kubectl get ingress real-ip-ingress -n kestrelli-catchip -o jsonpath='{.status.loadBalancer.ingress[0].ip}')  
echo "测试地址: http://$INGRESS_IP"

# 发送测试请求  
curl -s http://$INGRESS_IP | grep -E 'X-Forwarded-For|X-Real-Ip'  