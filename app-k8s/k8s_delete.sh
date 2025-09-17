#!/bin/bash

kubectl delete -f tasky-https.yaml
kubectl delete -f tasky-app.yaml
kubectl delete -f tasky-db.yaml
kubectl delete -f svc-acct.yaml
kubectl delete -f tasky-secret.yaml

