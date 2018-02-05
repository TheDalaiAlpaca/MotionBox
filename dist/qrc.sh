#!/bin/sh

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../../Sky"

SkyComponents="$Sky/src/SkyComponents"

#--------------------------------------------------------------------------------------------------

content="../content"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 ] \
   || \
   [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] \
   || \
   [ $2 != "deploy" -a $2 != "generate" ]; then

    echo "Usage: qrc <qt4 | qt5 | clean> <deploy | clean>"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -f qrc/*.qml

if [ $2 = "deploy" ]; then

    rm -rf qrc/pictures
    rm -rf qrc/text
fi

if [ $1 = "clean" ]; then

    exit 0
fi

echo ""

#--------------------------------------------------------------------------------------------------
# QML
#--------------------------------------------------------------------------------------------------

echo "COPYING QML"

cp "$SkyComponents"/*.qml qrc

cp "$content"/*.qml qrc

if [ $2 = "deploy" ]; then

    rm -f qrc/Dev*.qml
fi

#--------------------------------------------------------------------------------------------------
# Pictures
#--------------------------------------------------------------------------------------------------

if [ $2 = "deploy" ]; then

    echo "COPYING pictures"

    cp -r "$SkyComponents"/pictures qrc

    cp -r "$content"/pictures qrc
fi

#--------------------------------------------------------------------------------------------------
# Text
#--------------------------------------------------------------------------------------------------

if [ $2 = "deploy" ]; then

    echo "COPYING text"

    cp -r "$content"/text qrc
fi

echo ""

#--------------------------------------------------------------------------------------------------
# Deployer
#--------------------------------------------------------------------------------------------------

if [ $1 = "qt4" ]; then

    "$Sky"/deploy/deployer qrc/ 1.1 MotionBox.qrc
else
    "$Sky"/deploy/deployer qrc/ 2.7 MotionBox.qrc
fi
