#!/bin/bash
#
# Updates the game version for export (based on the file .version)
#

game_version=$(cat .version)
datetime=$(date '+%Y%m%d')

sed -i "s,application/file_version=.*$,application/file_version=\"${game_version}.${datetime}\",g" ./export_presets.cfg
sed -i "s,application/product_version=.*$,application/product_version=\"${game_version}.${datetime}\",g" ./export_presets.cfg
sed -i "s,application/version=.*$,application/version=\"${game_version}\",g" ./export_presets.cfg
sed -i "s,application/short_version=.*$,application/short_version=\"${game_version::-2}\",g" ./export_presets.cfg
