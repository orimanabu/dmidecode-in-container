#!/bin/bash

oc create sa sa-dmidecode
oc apply -f scc-for-dmidecode.yaml
oc adm policy add-scc-to-user for-dmidecode -z sa-dmidecode
oc apply -f deployment.yaml
oc wait --for='jsonpath={.status.readyReplicas}=1' deployment/testapp
oc exec deploy/testapp -- dmidecode | head -n 10
