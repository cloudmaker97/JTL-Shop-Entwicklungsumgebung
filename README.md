# Entwicklungsumgebung für den JTL-Shop

Dieses Repository enthält alle benötigten Scripts, um einen JTL-Shop schnell und automatisiert zu Entwicklungszwecken zu installieren. Die Nutzung für produktive Systeme ist mit diesem Projekt nicht vorgesehen und wird auch nicht empfohlen.

## Voraussetzungen

Es gelten die Lizenzbedingungen der JTL-Software-GmbH. Die Lizenzbedingungen sind in diesem Projekt als Lizenzdatei hinterlegt. Zur Nutzung dieses Repositories sind zudem folgende Voraussetzungen notwendig:

- [Docker: Virtualisierung](https://www.docker.com/)
- [DDEV: Docker Development](https://ddev.com/)

## Installation und Befehle

```bash
# 1. Klonen des Repository via SSH
git clone git@github.com:cloudmaker97/JTL-Shop-Entwicklungsumgebung.git
# 2. Anschließend in der Verzeichnis wechseln
cd JTL-Shop-Entwicklungsumgebung
# 3. Installation unter Standardeinstellungen
ddev just install
```

Zur Installation des Shops wird nur ein Befehl benötigt. Der Befehl `ddev just install` installiert den Shop mit der neusten Version und den standardmäßigen Einstellungen. 

Nach der erfolgreichen Installation kann der Shop über die angezeigte URL aufgerufen werden. Die Anmeldedaten wurden automatisch festgelegt und sind:

| Bereich | Benutzername | Passwort |
| --- | --- | --- |
| Shop-Administration | `admin` | `admin` |
| Shop-Abgleich | `sync` | `sync` |

## Benutzerdefinierte Installations-Routinen

### Nutzung einer zweiten DDEV-Instanz

1. Repository klonen 
2. Änderung der Domain in `.ddev/config.yaml`
3. Den Container zwingend mit `ddev restart` neu starten
4. Anschließend die Installation mit Argument starten

```bash
# Installiert den Shop unter einer anderen Domain
ddev just shop_url="jtl-shop.ddev.site" shop_version="5.5.2"
```

### Nutzung einer anderen Shop-Version

> Da die JTL-Shop Core den Installer nicht mehr zur Verfügung stellt, ist es notwendig, die Installer-Dateien in diesem Repository im Ordner `tools/installer` zu hinterlegen. Die Dateien sind in den entsprechenden Versionen im Dateinamen `install_X.X.X.zip` hinterlegt. Die Installations-Dateien können von der [Webseite von JTL](https://www.jtl-software.de/) mit einem Kundenkonto bezogen werden. Es ist außerdem notwendig, dass in dem Repository des JTL-Shops / Core die Versionen als Tags hinterlegt sind. Diese Tags müssen mit den Versionen im Dateinamen der Installer-Dateien übereinstimmen.

1. Repository klonen 
2. Notwendige PHP-Version unter `.ddev/config.yaml` eintragen
3. Den Container zwingend mit `ddev restart` neu starten
4. Anschließend die Installation mit Argument starten

```bash
# Installiert den Shop unter einer anderen Domain
ddev just shop_version="5.5.2"
```

### Sonstige Installationsparameter

Hier sind alle Installationsparameter die mit der Installation mitgegeben werden um die Installation zu beeinflussen, Testprodukte zu erstellen etc.

| Parameter | Standardwert | Beschreibung |
| --- | --- | --- |
| `shop_version` | `5.5.2` | Die Shop-Version, die installiert werden soll. Aktuell stehen zur Auswahl `5.5.2`, `5.3.1`, `5.2.5`, `5.1.6` oder `5.0.6`. Um weitere Versionen anzubieten, siehe weiter unten im Abschnitt 'Unterstützte Shop-Versionen' |
| `install_demo` | `true` | Ob der neue Shop Demo-Daten enthalten soll, ansonsten muss `false` angegeben werden. |
| `install_demo_products` | `10` | Falls die Demo-Daten installiert werden: Anzahl der zu generierenden Produkte |
| `install_demo_categories` | `3` | Falls die Demo-Daten installiert werden: Anzahl zu generierenden der Kategorien |
| `install_demo_manufacturers` | `3` | Falls die Demo-Daten installiert werden: Anzahl der zu generierenden Hersteller |
| `install_url` | `jtl-shop.ddev.site` | Die URL über die der Shop erreicht werden soll. Achtung: DDEV Config vorher anpassen!  |

### Beispiel

![Installation Demo](.github/assets/command-exec.gif)
