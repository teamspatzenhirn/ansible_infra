# Ubuntu Installationsschritte vor Ansible

## 1. Ubuntu Installieren

| Option | Wert |
| ------ | ---- |
| Sprache | **Englisch** |
| Tastaturlayout | **Deutsch** |
| Netzwerkverbindung | **Nein** (_nach Installation konfigurieren_) |
| Appselektion | **Default** |
| 3rd Party | **Ja** |
| Zeitzone | **`Europe/Berlin`** |
| **_INSTALL & REBOOT_** | - |
| Ubuntu Pro | **Nein** |
| Telemetrie | **Nein** |
| Netzwerkkonfiguration | _Umstandsabhängig_ |

## 2. Update & Upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

## 3. Initskript ausführen

```bash
sudo apt install curl -y
curl -fsSL https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/init.sh | sudo bash
```

Gegen Ende fragt das Skript nach einem "Mantra". Damit ist der Schlüssel zum Entschlüsseln des NetBird Setupkeys aus diesem Repository gemeint.\
Dieser Schlüssel ist an entsprechender Stelle zu "_finden_".
