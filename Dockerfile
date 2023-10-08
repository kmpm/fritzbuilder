FROM kmpm/fritzbuild-base:latest
# Bob the Builder :)
ARG USERNAME=bob    

COPY --from=kmpm/fritzbuild-ngspice:latest /home/${USERNAME}/ngspice-40 /home/${USERNAME}/ngspice-40
COPY --from=kmpm/fritzbuild-libgit2:latest /home/${USERNAME}/libgit2 /home/${USERNAME}/libgit2