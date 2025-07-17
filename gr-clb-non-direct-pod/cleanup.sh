#删除 ingress
kubectl delete ingress real-ip-ingress  -n kestrel-catchip
#删除 service
kubectl delete service real-ip-service  -n kestrel-catchip
# 删除所有 Pod
kubectl delete pod -n kestrel-catchip --all
# 删除 Deployment
kubectl delete deployment real-ip-deployment -n kestrel-catchip
