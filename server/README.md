# Server

> [!NOTE]
> Das Playbook geht davon aus, dass die Festplatten bereits an den unten stehenden Stellen gemountet sind.

Der zentrale Server stellt folgende Dienste bereit:

- NFS Shares für:
  - Heimverzeichnisse
  - Aufnahmen
  - Simulatorstrecken
  - Skeletonstruktur für neue Benutzer
- Zentraler Identity Management Provider ([kanidm](https://kanidm.com/)) https://idm.spatz.wtf
- Pulseaudio Server für alle PCs
- Static file host unter https://static.spatz.wtf
- Private VPN Lösung ([NetBird](https://netbird.io)) https://vpn.spatz.wtf


Im Server befinden sich folgende Festplatten:
- `/mnt/user-home`: 4TB SSD nur für Heimverzeichnisse
- `/mnt/aufnahmen`: 4TB HDD nur für Aufnahmen
- `/mnt/auxiliary`: 120GB SSD für:
  - kanidm Datenbank
  - Statische Dateien
  - Simulatorstrecken
  - Skeletonstruktur für neue Benutzer

> [!CAUTION]
> Auf der Systemfestplatte selbst dürfen keinerlei Daten gespeichert werden, welche nicht durch eine Neuinstallation und Ausführung des Playbooks wiederhergestellt werden können!


## Ansible Command
```bash
ansible-playbook playbook.yml 
```