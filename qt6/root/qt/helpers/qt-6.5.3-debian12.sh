# install qt
# https://doc.qt.io/qt-6/linux.html
# https://doc.qt.io/qt-6/linux-requirements.html
# https://doc.qt.io/qt-6/configure-options.html

set -e

SRCDIR=/qt/build
QT_VERSION=6.5.3
JOBS=4
PREFIX=/usr/local/Qt-$QT_VERSION

if [ ! -d $SRCDIR ]; then
    mkdir -p $SRCDIR
fi


cd $SRCDIR
# sudo apt-get install build-essential libgl1-mesa-dev

# qtbase
# sudo apt install \
# libinput-dev libts-dev \
# libxcb-render-util0-dev \
# libxcb-render0-dev \
# libxcb-shape0-dev \
# libxcb-randr0-dev \
# libxcb-xfixes0-dev \
# libxcb-xkb-dev \
# libxcb-sync-dev \
# libxcb-shm0-dev \
# libxcb-icccm4-dev \
# libxcb-keysyms1-dev \
# libxcb-image0-dev \
# libxcb-util-dev \
# libxcb-cursor-dev \
# libxkbcommon-dev \
# libxkbcommon-x11-dev \
# libfontconfig-dev \
# libfreetype-dev \
# libxext-dev \
# libx11-dev \
# libx11-xcb-dev \
# libxcb1-dev \
# libsm-dev \
# libice-dev \
# libglib2.0-dev 

# optional
# sudo apt install \
# libatspi2.0-dev \
# libgl4es-dev \
# libglbinding-dev \
# libgl-image-display-dev

# sudo apt install gperf bison flex libcups2-dev


function get_untar() {
    modulename=$1
    filename=$modulename.tar.xz
    echo "get_untar $modulename from $filename" 
    # if modulename exists, return
    if [ -d $modulename ]; then
        return
    fi

    if [ ! -f "$filename" ]; then
        wget https://download.qt.io/official_releases/qt/6.5/6.5.3/submodules/$filename
    fi
    tar -xvf "$filename"
    if [ ! -d $modulename/build ]; then
        mkdir $modulename/build
    fi
}


function checkinst() {
    pkgname=$1
    echo "checkinst $pkgname"
    sudo checkinstall \
        --install=yes \
        --default \
        --nodoc \
        --pkgname=$pkgname \
        --pkgversion=$QT_VERSION \
        --pkgrelease=fritzing1 \
        --pkglicense=GPL \
        --pakdir /qt/deb \
        -D cmake install . 
}

function configure_qt() {
    cmake -G Ninja \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DQT_FEATURE_opengles2=ON \
    -DQT_FEATURE_opengles3=ON \
    -DQT_FEATURE_vulkan=ON \
    -DQT_FEATURE_kms=ON \
    -DQT_AVOID_CMAKE_ARCHIVING_API=ON \
    ../
}

get_untar qtbase-everywhere-src-6.5.3

#mkdir qtbase-everywhere-src-6.5.3/build
cd qtbase-everywhere-src-6.5.3/build
configure_qt
cmake --build . --parallel -j $JOBS
sudo cmake install .

# #echo "export PATH=/usr/local/Qt-$QT_VERSION/bin:\$PATH" >> ~/.profile
# #source ~/.profile

# cd $SRCDIR
# get_untar qt5compat-everywhere-src-6.5.3
# mkdir qt5compat-everywhere-src-6.5.3/build
# cd qt5compat-everywhere-src-6.5.3/build
# /usr/local/Qt-$QT_VERSION/bin/qt-configure-module ..
# cmake --build . --parallel -j $JOBS
# sudo cmake install .

# cd $SRCDIR
# get_untar qtpositioning-everywhere-src-6.5.3
# mkdir qtpositioning-everywhere-src-6.5.3/build
# cd qtpositioning-everywhere-src-6.5.3/build
# /usr/local/Qt-$QT_VERSION/bin/qt-configure-module ..
# cmake --build . --parallel -j $JOBS
# sudo cmake install .

# cd $SRCDIR
# get_untar qtsvg-everywhere-src-6.5.3
# mkdir qtsvg-everywhere-src-6.5.3/build
# cd qtsvg-everywhere-src-6.5.3/build
# /usr/local/Qt-$QT_VERSION/bin/qt-configure-module ..
# cmake --build . --parallel -j $JOBS
# # checkinst qt6-svg
# sudo cmake install .

# cd $SRCDIR
# get_untar qtwayland-everywhere-src-6.5.3
# mkdir qtwayland-everywhere-src-6.5.3/build
# cd qtwayland-everywhere-src-6.5.3/build
# /usr/local/Qt-$QT_VERSION/bin/qt-configure-module ..
# cmake --build . --parallel -j $JOBS
# #checkinst qt6-wayland
# sudo cmake install .
