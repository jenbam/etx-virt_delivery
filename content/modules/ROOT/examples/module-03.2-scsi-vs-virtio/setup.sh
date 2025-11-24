#!/bin/bash
set -e

NAMESPACE="virt-lab"
VM_NAME="db-performance"

echo "[1/5] Creating namespace..."
oc create namespace $NAMESPACE --dry-run=client -o yaml | oc apply -f -

echo "[2/5] Creating DataVolumes..."
oc apply -n $NAMESPACE -f datavolumes.yaml

echo "[3/5] Creating VM (SCSI initial state)..."
oc apply -n $NAMESPACE -f vm-scsi-initial.yaml

echo "[4/5] Starting VM..."
virtctl start $VM_NAME -n $NAMESPACE

echo "[5/5] Setup complete!"
echo
echo "VM ready in namespace: $NAMESPACE"
echo "Disks should appear as /dev/sda /dev/sdb /dev/sdc inside the VM."
