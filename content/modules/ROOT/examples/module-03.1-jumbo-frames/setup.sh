#!/bin/bash
set -e

echo "Creating namespace"
oc new-project virt-lab || true

echo "Applying jumbo NAD"
oc apply -f jumbo-bridge-nad.yaml

echo "Deploying VM1 (broken state)"
oc apply -f vm1-jumbo-broken.yaml

echo "Deploying VM2 (peer)"
oc apply -f vm2-jumbo-good.yaml

echo "Starting VMs"
virtctl start jumbo-vm1 -n virt-lab
virtctl start jumbo-vm2 -n virt-lab

echo "Environment ready. Connect to jumbo-vm1 and begin testing."

