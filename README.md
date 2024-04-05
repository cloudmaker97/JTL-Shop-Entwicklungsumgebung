# Entwicklungsumgebung für den JTL-Shop

## Beschreibung

Dieses Repository enthält alle benötigten Scripts, um einen JTL-Shop schnell und automatisiert zu Entwicklungszwecken zu installieren. Die Nutzung für produktive Systeme ist mit diesem Projekt nicht vorgesehen und wird auch nicht empfohlen.

### Vorschau der Installation mit nur einem Befehl

![Installation im Terminal](https://github.com/cloudmaker97/JTL-Shop-Entwicklungsumgebung/assets/4189795/98325070-fb9a-4f19-94b0-89bc162a07db)

### Voraussetzungen

Es gelten die Lizenzbedingungen der JTL-Software-GmbH. Die Lizenzbedingungen sind in diesem Projekt als Lizenzdatei hinterlegt. Zur Nutzung dieses Repositories sind zudem folgende Voraussetzungen notwendig:

- [Docker: Virtualisierung](https://www.docker.com/)
- [Just: Command Runner](https://just.systems/)

## Installation und Befehle

Zur Installation des Shops wird nur ein Befehl benötigt. Der Befehl `just install` installiert den Shop mit der neusten Version und den standardmäßigen Einstellungen. 

Nach der erfolgreichen Installation kann der Shop über die angezeigte URL aufgerufen werden. Die Anmeldedaten wurden automatisch festgelegt und sind:

| Bereich | Benutzername | Passwort |
| --- | --- | --- |
| Shop-Administration | `admin` | `admin` |
| Shop-Abgleich | `sync` | `sync` |

Optional kann die Installation mit anderen Versionen und Werten installiert werden. 

### Benutzerdefinierte Installations-Routinen

```bash
# Führt die Installation mit spezifischen Werten aus. 
# Darüber kann die Installation der Shop-Version gesteuert werden, 
# die PHP-Version und ob Demo-Daten installiert werden sollen.
just shop_version="5.3.1" install_demo="false" php_version="8.1"
```

```bash
# Erstellt ein Backup der Datenbank, Deinstalliert den Shop,  
# und löscht anschließend alle Dateien und Datenbanken. Die Datenbanken
# werden als Snapshot im `.ddev/db_snapshots` Ordner gespeichert.
just uninstall
```

| Parameter | Standardwert | Beschreibung |
| --- | --- | --- |
| `shop_version` | `5.3.1` | Die Shop-Version, die installiert werden soll. Aktuell stehen zur Auswahl `5.3.1`, `5.2.5`, `5.1.6` oder `5.0.6`. Um weitere Versionen anzubieten, siehe weiter unten im Abschnitt 'Unterstützte Shop-Versionen' |
| `php_version` | `8.2` | Die PHP-Version, die genutzt werden soll. `5.6`, `7.0`, `7.1`, `7.2`, `7.3`, `7.4`, `8.0`, `8.1`, `8.2`, oder `8.3` |
| `install_demo` | `true` | Ob der neue Shop Demo-Daten enthalten soll, ansonsten muss `false` angegeben werden. |
| `install_demo_products` | `10` | Falls die Demo-Daten installiert werden: Anzahl der zu generierenden Produkte |
| `install_demo_categories` | `3` | Falls die Demo-Daten installiert werden: Anzahl zu generierenden der Kategorien |
| `install_demo_manufacturers` | `3` | Falls die Demo-Daten installiert werden: Anzahl der zu generierenden Hersteller |

### Befehle für den DDEV-Entwicklungsserver

```bash
# Startet den Entwicklungs-Container
just start
# Stoppt den Entwicklungs-Container 
just stop 
# Zeigt die Beschreibung und URLs des Containers an
just describe 
```

## Unterstützte Shop-Versionen

Da die JTL-Shop Core den Installer nicht mehr zur Verfügung stellt, ist es notwendig, die Installer-Dateien in diesem Repository im Ordner `tools/installer` zu hinterlegen. Die Dateien sind in den entsprechenden Versionen im Dateinamen `install_**X.X.X**.zip` hinterlegt. Die Installations-Dateien können von der [Webseite von JTL](https://www.jtl-software.de/) mit einem Kundenkonto bezogen werden.

Es ist außerdem notwendig, dass in dem Repository des JTL-Shops / Core die Versionen als Tags hinterlegt sind. Diese Tags müssen mit den Versionen im Dateinamen der Installer-Dateien übereinstimmen.
