shop_version := "5.3.1"
php_version := "8.2"
install_demo := "true"
install_demo_products := "10"
install_demo_categories := "3"
install_demo_manufacturers := "3"

# Installiert den Shop mit den angegebenen Werten (Standard)
[linux]
install:
    @echo "Installiere Abhängigkeiten (ddev, rsync, unzip, mkcert)"
    just install-dependencies
    just uninstall
    mkdir -p ./shop
    @echo "Lade JTL-Shop v{{shop_version}} herunter"
    cd ./shop && wget https://gitlab.com/jtl-software/jtl-shop/core/-/archive/v{{shop_version}}/core-v{{shop_version}}.zip -O core.zip
    # Unzip and ignore existing files
    cd ./shop && unzip -on core.zip && rm core.zip
    # Overwrite all files, otherwise set --ignore-existing for rsync
    @echo "Kopiere heruntergeladene Dateien in das Shop-Verzeichnis"
    cd ./shop && rsync -av core-*/* . && rm -rf core-*
    @echo "Kopiere Installer in das Shop-Verzeichnis"
    just copy-installer
    @echo "Konfiguriere die Entwicklungsumgebung"
    just ddev-configuration
    @echo "Installiere den Shop automatisch und lösche das Installationsverzeichnis"
    just run-installer

[private]
[linux]
install-dependencies:
    sudo apt-get update
    sudo apt-get install -y curl rsync unzip
    curl -fsSL https://ddev.com/install.sh | bash
    mkcert -install

# Deinstalliert den Shop. Löscht alle Dateien und Datenbanken
[linux]
uninstall:
    @rm -rf ./shop/*
    @if [ -d ".ddev" ]; then \
        echo "Entferne vorherige Installation" \
        ddev delete -y; \
    else \
        echo "Keine vorhandene Installation gefunden."; \
    fi

# Startet die Entwicklungsumgebung
[linux]
start:
    @if [ -d ".ddev" ]; then \
        ddev start; \
    else \
        echo "Keine Konfiguration gefunden, bitte zuerst 'just install' ausführen."; \
    fi

# Fährt die Entwicklungsumgebung herunter
[linux]
stop:
    @if [ -d ".ddev" ]; then \
        ddev stop; \
    else \
        echo "Keine Konfiguration gefunden, bitte zuerst 'just install' ausführen."; \
    fi

# Zeigt Informationen zur Entwicklungsumgebung an
[linux]
describe:
    @if [ -d ".ddev" ]; then \
        ddev describe; \
    else \
        echo "Keine Konfiguration gefunden, bitte zuerst 'just install' ausführen."; \
    fi

[linux]
[private]
run-installer:
    @echo "\r\nInstalliere die Datenbank..."
    @curl --silent -X POST -k -H 'Content-Type: application/x-www-form-urlencoded' -d 'admin[name]=admin&admin[pass]=admin&admin[locale]=de&wawi[name]=sync&wawi[pass]=sync&db[host]=db&db[pass]=db&db[socket]=&db[user]=db&db[name]=db&demoProducts={{install_demo_products}}&demoCategories={{install_demo_categories}}&demoManufacturers={{install_demo_manufacturers}}' https://jtl-shop-{{shop_version}}.ddev.site/install/install.php?task=doinstall
    @if [ {{install_demo}} = "true" ]; then \
        curl --silent -X POST -k -H 'Content-Type: application/x-www-form-urlencoded' -d 'admin[name]=admin&admin[pass]=admin&admin[locale]=de&wawi[name]=sync&wawi[pass]=sync&db[host]=db&db[pass]=db&db[socket]=&db[user]=db&db[name]=db&demoProducts={{install_demo_products}}&demoCategories={{install_demo_categories}}&demoManufacturers={{install_demo_manufacturers}}' https://jtl-shop-{{shop_version}}.ddev.site/install/install.php?task=installdemodata; \
    fi
    clear
    @echo "Installation erfolgreich abgeschlossen."
    @echo "Erreichbar unter: https://jtl-shop-{{shop_version}}.ddev.site"

[linux]
[private]
copy-installer:
    cp ./tools/installer/install_{{shop_version}}.zip ./shop/install/installer.zip
    unzip -o ./shop/install/installer.zip -d ./shop/install
    rm ./shop/install/installer.zip

[linux]
[private]
ddev-configuration:
    ddev config --php-version {{php_version}} --project-type php --docroot ./shop --project-name jtl-shop-{{shop_version}}
    ddev start
    ddev exec composer install --working-dir=./shop/includes