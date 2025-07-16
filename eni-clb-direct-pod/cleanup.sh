#!/bin/bash  
kubectl delete svc clb-direct-pod  
kubectl delete deploy real-ip-demo  
echo "[SUCCESS] 资源清理完成!"  
