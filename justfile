shop_version := "5.5.2"
shop_url := "jtl-shop.ddev.site"
install_demo := "true"
install_demo_products := "10"
install_demo_categories := "3"
install_demo_manufacturers := "3"

# Installiert den Shop mit den angegebenen Werten (Standard)
install:
    @echo "Installiere den Shop"
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
    @echo "Installiere den Shop automatisch und lösche das Installationsverzeichnis"
    just run-installer


# Deinstalliert den Shop. Löscht alle Dateien und Datenbanken
uninstall:
    @echo "Deinstalliere den Shop"
    @rm -rf ./shop/*

run-installer:
    # Composer install
    @echo "\r\nInstalliere Composer Abhängigkeiten..."
    @cd ./shop && composer install --working-dir=./includes
    # Installer
    @echo "\r\nInstalliere die Datenbank..."
    @curl --silent -X POST -k -H 'Content-Type: application/x-www-form-urlencoded' -d 'admin[name]=admin&admin[pass]=admin&admin[locale]=de&wawi[name]=sync&wawi[pass]=sync&db[host]=db&db[pass]=db&db[socket]=&db[user]=db&db[name]=db&demoProducts={{install_demo_products}}&demoCategories={{install_demo_categories}}&demoManufacturers={{install_demo_manufacturers}}' https://{{shop_url}}/install/install.php?task=doinstall
    @if [ {{install_demo}} = "true" ]; then \
        curl --silent -X POST -k -H 'Content-Type: application/x-www-form-urlencoded' -d 'admin[name]=admin&admin[pass]=admin&admin[locale]=de&wawi[name]=sync&wawi[pass]=sync&db[host]=db&db[pass]=db&db[socket]=&db[user]=db&db[name]=db&demoProducts={{install_demo_products}}&demoCategories={{install_demo_categories}}&demoManufacturers={{install_demo_manufacturers}}' https://{{shop_url}}/install/install.php?task=installdemodata; \
    fi
    @echo "Installation erfolgreich abgeschlossen."
    @echo "Erreichbar unter: https://{{shop_url}}"

[private]
copy-installer:
    cp ./tools/installer/install_{{shop_version}}.zip ./shop/install/installer.zip
    unzip -o ./shop/install/installer.zip -d ./shop/install
    rm ./shop/install/installer.zip