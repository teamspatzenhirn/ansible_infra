[transcrypt]: https://github.com/elasticdog/transcrypt

# Teamspatzenhirn Infrastruktur

## Secrets im Repository

> [!IMPORTANT]
> Wir benutzen [transcrypt](https://github.com/elasticdog/transcrypt) um Dateien verschlüsselt in diesem Repository versionieren zu können, welche unter sonstigen Umständen **KEINES FALLS** in ein Repository gehören.

Nach dem initialen Clonen des Repositories muss man [transcrypt] entsprechend konfigurieren. \
Falls noch nicht geschehen muss das Submodul, welches [transcrypt] enthält initialisiert werden:
```bash
git submodule update --init
```

Anschließend kann man [transcrypt] mit folgendem Befehl initialisieren:
```bash
./transcrypt/transcrypt -c aes-256-cbc
```
Das zuverwendende Password (nicht random!) ist an einem entsprechenden Ort zu "_finden_".

Zuletzt muss man noch den NetBird Setupkey entschlüsseln:
```bash
mcrypt -d netbird_setup.key.nc
```
Das zuverwendende Password ist an einem entsprechenden Ort zu "_finden_".

## Setup

Für Neuinstallationen von Ubuntu siehe [`UBUNTU_INSTALL`](UBUNTU_INSTALL.md).

Anschließend kann dann das entsprechende Playbook ausgeführt werden (zuerst in den entsprechenden Ordner wechseln):
```bash
ansible-playbook playbook.yml -i inventory.yml
```

Mehr zu den Playbooks ist entsprechend der READMEs in [`clients`](clients/) bzw [`server`](server/) zu entnehmen.

## Utilities

Unter [`util_scripts`](util_scripts/) sind einige nützliche Skripte zur Nutzerverwaltung enthalten. \
Diese werden auch im client Playbook in die Heimverzeichnisse der lokalen Spatz User kopiert.
