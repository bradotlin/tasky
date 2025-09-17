#!/bin/bash

aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster --profile default

kubectl apply -f svc-acct.yaml
kubectl apply -f tasky-secret.yaml
kubectl apply -f tasky-app.yaml
kubectl apply -f tasky-db.yaml
kubectl apply -f tasky-https.yaml

sleep 5

kubectl exec -it $(
  kubectl get pods -o jsonpath='{.items[?(@.metadata.name startswith "tasky-")].metadata.name}' | awk '{print $1}'
) -- mongosh "mongodb://mongouser:mongopassword@mongodb:27017/?authSource=admin&serverSelectionTimeoutMS=2000" \
   --quiet --eval 'if (db.runCommand({connectionStatus:1}).ok) { print("✅ mondodb Auth success") } else { print("❌ mongodb Auth failed") }'

kubectl get svc tasky-svc-http -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' | tr -d '%'
