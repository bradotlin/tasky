#!/bin/bash

kubectl apply -f svc-acct.yaml
kubectl apply -f tasky-secret.yaml
kubectl apply -f tasky-app.yaml
kubectl apply -f tasky-db.yaml
kubectl apply -f tasky-https.yaml

sleep 5

kubectl get svc tasky-svc-http -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' | tr -d '%'
