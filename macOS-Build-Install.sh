#!/bin/bash

git submodule update --init

cd src
python3 build_mozc.py clean

GYP_DEFINES="mac_sdk=11.1 mac_deployment_target=10.13" python3 build_mozc.py gyp --qtdir /usr/local/opt/qt
python3 build_mozc.py build -c Release gui/gui.gyp:config_dialog_main
python3 build_mozc.py build -c Release mac/mac.gyp:GoogleJapaneseInput mac/mac.gyp:gen_launchd_confs


sudo cp -r out_mac/Release/Mozc.app /Library/Input\ Methods/
sudo cp out_mac/Release/gen/mac/org.mozc.inputmethod.Japanese.Converter.plist /Library/LaunchAgents/
sudo cp out_mac/Release/gen/mac/org.mozc.inputmethod.Japanese.Renderer.plist /Library/LaunchAgents/
