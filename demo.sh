
#!/usr/bin/env bash

########################
# include the magic
########################
. demo-magic.sh

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=30

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${BLACK}➜ ${GREEN}\W "

# hide the evidence
clear

p ">>> Get the list of pods from all namespaces <<<"
pe "kubectl get pods --all-namespaces"

p ">>> Get the list of services from all namespaces <<<"
pe "kubectl get services --all-namespaces"

p ">>> Deploy version 1 of hello world <<<"
pe "kubectl apply -f kubernetes/helloworld-v1.yaml"

p ">>> Wait for hello world pod <<<"
pe "kubectl get pods -w"

p ">>> Create a Gateway, destination rules, and virtual service to allow ‘ingress' traffic to reach the mesh <<<"
pe "kubectl apply -f kubernetes/helloworld-all-v1.yaml"

p ">>> Get the gateway external IP <<<"
pe "kubectl get svc istio-ingressgateway -n istio-system"

p ">>> Deploy v2 of hello world <<<"
pe "kubectl apply -f kubernetes/helloworld-v2.yaml"

p ">>> Wait for v2 hello world pod <<<"
pe "kubectl get pods -w"

p ">>> Route the traffic: 50% to v1 and 50% to v2 <<<"
pe "kubectl apply -f kubernetes/helloworld-50-50.yaml"

p ">>> Route all traffic to v1 <<<"
pe "kubectl apply -f kubernetes/helloworld-all-v1.yaml"
