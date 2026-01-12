#!/bin/bash

set -e

NAMESPACE=virt-lab

echo "Creating namespace (if not exists)…"
oc get ns $NAMESPACE >/dev/null 2>&1 || oc create ns $NAMESPACE

echo "Applying broken CPU topology VM…"
oc apply -f vm-cpu-broken.yaml -n $NAMESPACE

echo "Starting VM…"
oc start vm cpu-vm-broken -n $NAMESPACE

echo "Waiting for VM to become Ready…"
oc wait vm/cpu-vm-broken -n $NAMESPACE --for=condition=Ready --timeout=180s

echo "VM deployed. CPU topology inside VM should show:"
echo "  Socket(s): 1"
echo "  Core(s):   2"
echo ""
echo "Connect to the VM console and run: lscpu"
