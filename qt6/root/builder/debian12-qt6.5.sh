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

clean () {
    rm -rf $1/build
}

get_untar () {
    local modulename=$1
    local filename="${modulename}.tar.xz"
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
    local pkgname=$1
    echo "checkinst ${pkgname}"
    checkinstall \
        --install=no \
        --default \
        --nodoc \
        --pkgname=${pkgname} \
        --pkgversion=${QT_VERSION} \
        --pkgrelease=fritzing1 \
        --pkglicense=GPL \
        --pakdir /qt/deb \
        -D cmake --install . 
}

first () {
    # get the first part of a dash-separated string
    echo $1 | cut -d'-' -f1
}


do_base () {
    local modulename=qtbase-everywhere-src-${QT_VERSION}
    cd ${SRCDIR}
    get_untar ${modulename}
    #clean ${modulename}
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
    local name=$(first ${modulename})
    checkinst qt6-${name}
    cmake --install .
}

do_submodule () {
    local name=$1
    local arch=${2:-everywhere}
    local modulename=${name}-${arch}-src-${QT_VERSION}
    cd ${SRCDIR}
    get_untar ${modulename}
    #clean ${modulename}
    if [ ! -d ${modulename}/build ]; then
        mkdir ${modulename}/build
    fi
    cd ${SRCDIR}/${modulename}/build
    $PREFIX/bin/qt-configure-module ..
    cmake --build . --parallel -j ${JOBS}
    checkinst qt6-${name}
    cmake --install .
}



do_base 


# pick up the new path for the next steps
export PATH="$PREFIX/bin:$PATH"
# #echo "export PATH=/usr/local/Qt-$QT_VERSION/bin:\$PATH" >> ~/.profile
# #source ~/.profile

do_submodule qt5compat
# do_submodule qtpositioning
# do_submodule qttools
# do_submodule qtsvg
# do_submodule qttranslations
# do_submodule qtserialport
# do_submodule qtscxml
# do_submodule qtcharts
# do_submodule qtwayland
