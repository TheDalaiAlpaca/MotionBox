#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

Sky="../Sky"

#--------------------------------------------------------------------------------------------------

bin4="bin"
bin5="latest"

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 2 ] || [ $1 != "qt4" -a $1 != "qt5" -a $1 != "clean" ] || [ $2 != "win32" -a \
                                                                       $2 != "linux" ]; then

    echo "Usage: deploy <qt4 | qt5 | clean> <win32 | osx | linux>"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

echo "CLEANING"

rm -rf deploy/*

touch deploy/.gitignore

if [ $1 = "clean" ]; then

    exit 0
fi

echo ""

#--------------------------------------------------------------------------------------------------
# Sky
#--------------------------------------------------------------------------------------------------

echo "DEPLOYING Sky"
echo "-------------"

cd "$Sky"

sh deploy.sh $1 $2

cd -

deploy="$Sky/deploy"

cp -r "$deploy"/imageformats deploy

if [ $1 = "qt5" ]; then

    cp -r "$deploy"/platforms deploy
    cp -r "$deploy"/QtQuick.2 deploy

    if [ $2 = "linux" ]; then

        cp -r "$deploy"/xcbglintegrations deploy
    fi
fi

if [ $2 = "win32" ]; then

    cp -r "$deploy"/plugins deploy

    cp "$deploy"/*.dll deploy

elif [ $2 = "osx" ]; then

    cp -r "$deploy"/vlc deploy

    cp "$deploy"/*.dylib deploy

elif [ $2 = "linux" ]; then

    #cp -r "$deploy"/vlc deploy

    cp "$deploy"/*.so* deploy
fi

echo "------------"
echo ""

#--------------------------------------------------------------------------------------------------
# MotionBox
#--------------------------------------------------------------------------------------------------

echo "COPYING MotionBox"

if [ $1 = "qt4" ]; then

    bin="$bin4"
else
    bin="$bin5"
fi

cp "$bin"/MotionBox* deploy

if [ $2 = "linux" ]; then

    cp dist/scripts/start.sh deploy
fi
