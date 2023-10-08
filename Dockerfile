FROM kmpm/fritzbuild-base:latest
# Bob the Builder :)
ARG USERNAME=bob    

# libgit2
COPY --from=kmpm/fritzbuild-libgit2:latest /home/${USERNAME}/libgit2 /home/${USERNAME}/libgit2

# ngspice-40
COPY --from=kmpm/fritzbuild-ngspice:latest /home/${USERNAME}/ngspice-40 /home/${USERNAME}/ngspice-40
COPY --from=kmpm/fritzbuild-ngspice:latest /deb /deb


# quazip
#- would be nice to be able to use package libquazip5-dev instead of building quazip 
COPY --from=kmpm/fritzbuild-quazip:latest /home/${USERNAME}/quazip_qt5 /home/${USERNAME}/quazip_qt5
COPY --from=kmpm/fritzbuild-quazip:latest /deb /deb




#- can we somehow skip this step?
RUN set -xe \
    && sudo chown  ${USERNAME}:${USERNAME} /home/${USERNAME}/libgit2 \
    && sudo chown  ${USERNAME}:${USERNAME} /home/${USERNAME}/ngspice-40 \
    && sudo chown  ${USERNAME}:${USERNAME} /home/${USERNAME}/quazip_qt5 \ 
    && cd ngspice-40 && sudo make install \
    && cd ../quazip_qt5/build && sudo make install 
    #&& cd ../quazip_qt5/build && sudo make install
# sudo dpkg -i /deb/ngspice_40-fritzing1_arm64.deb \
# && sudo dpkg -i /deb/libquazip5_1.4-fritzing1_arm64.deb
