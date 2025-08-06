# 验证脚本 (verify.sh)
#!/bin/bash
# 部署验证
kubectl get pods  # 所有Pod状态为Running
kubectl get svc   # clb-direct-pod服务有EXTERNAL-IP
CLB_IP=$(kubectl get svc clb-direct-pod -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "验证结果:"
curl -s http://$CLB_IP | grep remote_addr
echo "客户端真实IP显示在 remote_addr 字段"