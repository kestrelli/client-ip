# 验证脚本 (verify.sh)
#!/bin/bash
CLB_IP=$(kubectl get svc clb-direct-pod -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "验证结果:"
curl -s http://$CLB_IP | grep remote_addr
echo "客户端真实IP显示在 remote_addr 字段"