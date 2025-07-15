# 一键部署脚本 (deploy.sh)
#!/bin/bash
# 启用直连能力
kubectl patch cm tke-service-controller-config -n kube-system --patch '{"data":{"GlobalRouteDirectAccess":"true"}}'

# 创建业务负载
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: real-ip-demo
  labels:
    app: real-ip-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: real-ip-app
  template:
    metadata:
      labels:
        app: real-ip-app
    spec:
      containers:
      - name: real-ip-container
        image: vickytan-demo.tencentcloudcr.com/kestrelli/images:v1.0
        ports:
        - containerPort: 5000
EOF

# 创建直连Service
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: clb-direct-pod
  annotations:
    service.cloud.tencent.com/direct-access: "true"
    service.cloud.tencent.com/loadbalance-type: "OPEN"
spec:
  selector:
    app: real-ip-app
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
EOF

