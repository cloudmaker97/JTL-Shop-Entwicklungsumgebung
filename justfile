shop_version := "5.3.1"
php_version := "8.2"
install_demo := "true"

# Installiert den Shop mit den angegebenen Werten
[linux]
install:
    just uninstall
    mkdir -p ./shop
    cd ./shop && wget https://gitlab.com/jtl-software/jtl-shop/core/-/archive/v{{shop_version}}/core-v{{shop_version}}.zip -O core.zip
    cd ./shop && unzip -o core.zip && rm core.zip
    sudo apt-get update && sudo apt-get install rsync
    # Overwrite all files, otherwise set --ignore-existing for rsync
    cd ./shop && rsync -av core-*/* . && rm -rf core-*
    just copy-installer
    just ddev-configuration
    just run-installer

# Deinstalliert den Shop. Löscht alle Dateien und Datenbanken
[linux]
uninstall:
    @rm -rf ./shop/*
    @if [ -d ".ddev" ]; then \
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

[private]
run-installer:
    @echo "\r\nInstalling JTL-Shop {{shop_version}}..."
    @curl --silent -X POST -k -H 'Content-Type: application/x-www-form-urlencoded' -d 'admin[name]=admin&admin[pass]=admin&admin[locale]=de&wawi[name]=sync&wawi[pass]=sync&db[host]=db&db[pass]=db&db[socket]=&db[user]=db&db[name]=db&demoProducts=10&demoCategories=10&demoManufacturers=10' https://jtl-shop-{{shop_version}}.ddev.site/install/install.php?task=doinstall
    @if [ {{install_demo}} = "true" ]; then \
        curl --silent -X POST -k -H 'Content-Type: application/x-www-form-urlencoded' -d 'admin[name]=admin&admin[pass]=admin&admin[locale]=de&wawi[name]=sync&wawi[pass]=sync&db[host]=db&db[pass]=db&db[socket]=&db[user]=db&db[name]=db&demoProducts=10&demoCategories=10&demoManufacturers=10' https://jtl-shop-{{shop_version}}.ddev.site/install/install.php?task=installdemodata; \
    fi
    @echo "Installation finished. You can now access the shop at https://jtl-shop-{{shop_version}}.ddev.site"

[private]
copy-installer:
    cp ./tools/installer/install_{{shop_version}}.zip ./shop/install/installer.zip
    unzip -o ./shop/install/installer.zip -d ./shop/install
    rm ./shop/install/installer.zip

[private]
ddev-configuration:
    ddev config --php-version {{php_version}} --project-type php --docroot ./shop --project-name jtl-shop-{{shop_version}}
    ddev start
    ddev exec composer install --working-dir=./shop/includes