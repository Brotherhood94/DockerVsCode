from ubuntu:18.04

RUN useradd -ms /bin/bash developer
WORKDIR /home/developer

USER root

RUN apt-get update

#Installing git
RUN apt-get -y install git


RUN apt-get -y install build-essential 
RUN apt-get -y install software-properties-common
RUN apt-get -y install cmake
RUN apt-get install net-tools
RUN apt-get install wget


#Installing g++-8
RUN apt-get -y install g++-8 

#Needed to vscode
RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget

#Installing visual studio code
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get -y install code

#Installing grppi
RUN git clone https://github.com/arcosuc3m/grppi.git
RUN cd grppi && mkdir build && cd build && cmake .. && make -j && make install
RUN rm -r grppi


#installing rplsh
RUN apt-get -y install libreadline-dev
RUN git clone https://github.com/Murray1991/rplsh.git
RUN cd /home/developer/rplsh && ./install.sh
RUN mv /home/developer/rplsh/build/rplsh /usr/bin/rplsh
RUN rm -r /home/developer/rplsh


#aliasing g++ with g++-8
RUN alias g++="g++-8"

RUN apt-get -y upgrade
RUN apt-get -y autoremove


RUN echo root:pippo | chpasswd
RUN echo developer:pippo | chpasswd


#Set non-root user
USER developer

#Launch vscode and bash on run
ENTRYPOINT code;bash
