# Shop Entwicklung

## Beschreibung

Dieses Repository enthält alle benötigten Scripts, um einen JTL-Shop schnell und automatisiert zu Entwicklungszwecken zu installieren. Die Nutzung für produktive Systeme ist mit diesem Projekt nicht vorgesehen und wird auch nicht empfohlen.

### Lizenz der Shop-Software

> Die Shop-Software wurde durch die [JTL-Software GmbH](https://www.jtl-software.de/) erstellt und unterliegt den jeweiligen [Lizenzbedingungen](LICENSE.md).

### Lizenz der Scripts in diesem Projekt

> Die Scripts zur automatisierten Installation wurden von [Dennis Heinrich](https://dennis-heinri.ch) erstellt und unterliegen ebenfalls den selben Lizenzbedingungen, wie die Shop-Software.

## Installation und Befehle

Zur Installation des Shops wird nur ein Befehl benötigt. Der Befehl `just install` installiert den Shop mit der neusten Version und den standardmäßigen Einstellungen. Optional kann auch eine spezifische Version installiert werden. Dazu wird eine unterstützte Versionsnummer verwendet.

```bash
# Führt die Installation mit der neusten Shop-Version auf PHP 8.1 
# aus und installiert anschließend den Shop mit Demo-Daten.
just
```

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

```bash
# Diese Befehle sind zur Steuerung des DDEV-Containers vorgesehen.
# <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
# Startet den DDEV-Container
just start
# Stoppt den DDEV-Container 
just stop 
# Zeigt die Beschreibung und URLs des Containers an
just describe 
```

| Parameter | Standardwert | Beschreibung |
| --- | --- | --- |
| `shop_version` | `5.3.1` | Die Shop-Version, die installiert werden soll. Aktuell stehen zur Auswahl `5.3.1`, `5.2.5`, `5.1.6` oder `5.0.6`. Um weitere Versionen anzubieten, siehe weiter unten im Abschnitt 'Unterstützte Shop-Versionen' |
| `php_version` | `8.2` | Die PHP-Version, die genutzt werden soll. `5.6`, `7.0`, `7.1`, `7.2`, `7.3`, `7.4`, `8.0`, `8.1`, `8.2`, oder `8.3` |
| `install_demo` | `true` | Ob der neue Shop Demo-Daten enthalten soll, ansonsten muss `false` angegeben werden. |

## Voraussetzungen

Zur Nutzung dieses Repositories sind folgende Voraussetzungen notwendig:

- [DDEV: Entwicklungsserver](https://ddev.readthedocs.io/en/stable/)
- [Docker: Virtualisierung](https://www.docker.com/)
- [Just: Command Runner](https://just.systems/)

## Unterstützte Shop-Versionen

Da die JTL-Shop Core den Installer nicht mehr zur Verfügung stellt, ist es notwendig, die Installer-Dateien in diesem Repository im Ordner `tools/installer` zu hinterlegen. Die Dateien sind in den entsprechenden Versionen im Dateinamen `install_**X.X.X**.zip` hinterlegt. Die Installations-Dateien können von der [Webseite von JTL](https://www.jtl-software.de/) mit einem Kundenkonto bezogen werden.

Es ist außerdem notwendig, dass in dem Repository des JTL-Shops / Core die Versionen als Tags hinterlegt sind. Diese Tags müssen mit den Versionen im Dateinamen der Installer-Dateien übereinstimmen.
