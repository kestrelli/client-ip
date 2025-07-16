# 一键部署脚本 (deploy.sh)
#!/bin/bash
# 启用直连能力
kubectl patch cm tke-service-controller-config -n kube-system --patch '{"data":{"GlobalRouteDirectAccess":"true"}}'

# 创建业务负载
kubectl apply -f deployment.yaml

# 创建直连Service
kubectl apply -f service.yaml


# 获取CLB地址
sleep 30
CLB_IP=$(kubectl get svc clb-direct-pod -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "测试地址: http://$CLB_IP"
