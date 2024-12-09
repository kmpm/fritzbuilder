# install qt
# https://doc.qt.io/qt-6/linux.html
# https://doc.qt.io/qt-6/linux-requirements.html
# https://doc.qt.io/qt-6/configure-options.html

set -e
QT_VERSION=6.5.3
QT_MINOR_VERSION=6.5

SRCDIR=/qt/build
JOBS=4
PREFIX=/usr/local/Qt-${QT_VERSION}

if [ ! -d "${SRCDIR}" ]; then
    mkdir -p ${SRCDIR}
fi


cd ${SRCDIR}


get_untar () {
    modulename=$1
    filename="${modulename}.tar.xz"
    # if modulename exists, return
    if [ -d "${modulename}" ]; then
        echo "${modulename} exists"
        return
    fi

    if [ ! -f "$filename" ]; then
        echo "Downloading $filename"
        wget https://download.qt.io/official_releases/qt/${QT_MINOR_VERSION}/${QT_VERSION}/submodules/${filename}
    fi
    echo "Untarring ${filename}"
    tar -xvf "${filename}"
}


checkinst () {
    pkgname=$1
    echo "checkinst ${pkgname}"
    sudo checkinstall \
        --install=yes \
        --default \
        --nodoc \
        --pkgname=${pkgname} \
        --pkgversion=${QT_VERSION} \
        --pkgrelease=fritzing1 \
        --pkglicense=GPL \
        --pakdir /qt/deb \
        -D cmake --install . 
}


do_base () {
    modulename=$1
    cd ${SRCDIR}
    get_untar ${modulename}
    if [ ! -d ${modulename}/build ]; then
        mkdir ${modulename}/build
    fi
    cd ${SRCDIR}/${modulename}/build
    cmake -G Ninja \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DQT_FEATURE_opengles2=ON \
    -DQT_FEATURE_opengles3=ON \
    -DQT_FEATURE_vulkan=ON \
    -DQT_FEATURE_kms=ON \
    -DQT_AVOID_CMAKE_ARCHIVING_API=ON \
    ../
    cmake --build . --parallel -j ${JOBS}
    #checkinst ${modulename}
    cmake --install .
}

do_submodule () {
    modulename=$1
    cd ${SRCDIR}
    get_untar ${modulename}
    if [ ! -d ${modulename}/build ]; then
        mkdir ${modulename}/build
    fi
    cd ${SRCDIR}/${modulename}/build
    $PREFIX/bin/qt-configure-module ..
    cmake --build . --parallel -j ${JOBS}
    #checkinst ${modulename}
    sudo cmake --install .
}

do_base qtbase-everywhere-src-6.5.3

# #echo "export PATH=/usr/local/Qt-$QT_VERSION/bin:\$PATH" >> ~/.profile
# #source ~/.profile

do_submodule qt5compat-everywhere-src-6.5.3
do_submodule qtpositioning-everywhere-src-6.5.3
do_submodule qtsvg-everywhere-src-6.5.3
do_submodule qtwayland-everywhere-src-6.5.3
