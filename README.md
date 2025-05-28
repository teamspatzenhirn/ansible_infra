# Teamspatzenhirn Infrastruktur

## Setup

Nach einer Neuinstallation von Ubuntu kann mit dem folgenden Befehl der Ansible User mit authorized key erstellt werden:
```bash
curl -sSL https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/init.sh | bash
```

Anschließend kann dann das entsprechende Playbook ausgeführt werden (zuerst in den entsprechenden Ordner wechseln):
```bash
ansible-playbook playbook.yml -i inventory.yml
```

> [!IMPORTANT]
> Das Repository enthält aus offensichtlichen Gründen **NICHT** den privaten SSH-Key des Ansible Users.

Mehr zu den Playbooks ist entsprechend der READMEs in [`clients`](clients/) bzw [`server`](server/) zu entnehmen.

## Utilities

Unter [`util_scripts`](util_scripts/) sind einige nützliche Skripte zur Nutzerverwaltung enthalten. \
Diese werden auch im client Playbook in die Heimverzeichnisse der lokalen Spatz User kopiert.
