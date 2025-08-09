# GitLab Installations / Upgradeschritte

## Neuaufsetzen

1. Instanz in BW Cloud erstellen.
1. Update & Upgrade.
    ```bash
      sudo apt update && sudo apt upgrade -y
    ```
1. Ansible init script ausführen.
    ```bash
      sudo apt install curl -y
      curl -fsSL https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/init.sh | sudo bash
    ```
1. GitLab-Data Volume attachen und in `/etc/fstab` mounten.
1. Ansible Server Playbook ausführen.

## Upgraden

1. Backup erstellen / verifizieren, dass es aktuelle Backups gibt.
1. Eventuelle Zwischenversionen und Hinweise mit dem [GitLab Upgrade Path Tool](https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/) herausfinden.
1. Entsprechenden Versionsschritte in Garry's Composefile eintragen und mit Ansible Deployen.
1. Warten bis alle Hintergrundmigrationen abgeschlossen sind.
    - oder mit `gitlab-rails console` die Migrationen beschleunigen ([siehe hier](https://gitlab.msu.edu/help/update/background_migrations.md#run-all-background-migrations-synchronously))
1. Wiederholen ab Schritt 3 bis Zielversion erreicht.
