@ECHO off
ECHO "Start << Create file resources! >>"

CALL pyside6-rcc.exe ../src/resources/icons.qrc -o ../src/resources/icons.py
CALL pyside6-rcc.exe ../src/resources/languages.qrc -o ../src/resources/languages.py
