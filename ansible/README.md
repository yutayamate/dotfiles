# Ansible Playbooks

This directory contains Ansible playbooks for configuring my machines.

## Run the Playbook

Run the playbook as a regular user. Ansible will request the sudo password when privilege escalation is required.

```bash
ANSIBLE_PLAYBOOK_DIR="./kalilinux"
ANSIBLE_LIMIT="local"   # Run on local
ANSIBLE_LIMIT="remote"  # Run on SSH
ansible-playbook --inventory="$ANSIBLE_PLAYBOOK_DIR/inventory.ini" --limit="$ANSIBLE_LIMIT" "$ANSIBLE_PLAYBOOK_DIR/playbook.yml"
```

The playbook can be run repeatedly. Tasks that are already configured will be skipped where possible.

## Password

The login password is not stored in the playbook. Change it interactively if necessary:

```bash
passwd
```
