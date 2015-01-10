FROM sameersbn/ubuntu:14.04.20141026
MAINTAINER Juha Kovanen <juha.kovanen@gmail.com>

RUN apt-get update
RUN apt-get install -y nano wget build-essential make g++ python-leveldb libboost-all-dev libssl-dev libdb++-dev git
RUN apt-get install -y libtool autotools-dev autoconf libboost-all-dev bsdmainutils pkg-config libminiupnpc-dev libqrencode-dev

# create folder where to install all the stuff
RUN mkdir -p /shadowcashd

# set home environment key variable
ENV HOME /shadowcashd

# check out github repo to build the latest version of shadowcashd from the sources
WORKDIR /tmp
RUN git clone https://github.com/SDCDev/shadowcoin.git /tmp/shadowcash

# build the shadowcoind
WORKDIR /tmp/shadowcash/src
RUN make -f makefile.unix

# rename it to shadowcashd since thats what I think it should be called instead :)
RUN (mv /tmp/shadowcash/src/shadowcoind /shadowcashd/shadowcashd) || (echo "Build failed!" && exit 1)
# and copy it to PATH
RUN cp /shadowcashd/shadowcashd /usr/local/bin/shadowcashd

# add all the files from hosts current dir to the docker image
ADD . /shadowcashd
WORKDIR /shadowcashd

# expose ports
EXPOSE 51736

# add shadowcashd.sh /usr/local/bin
ADD shadowcashd.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/shadowcashd.sh

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copy latest bootstrap
#ADD http://shadow.cash/downloads/bootstrap.dat /shadowcashd/.shadowcoin

# create mount point to store blockchain
VOLUME ["/shadowcashd/.shadowcoin"]

# add an entry command
ENTRYPOINT ["/usr/local/bin/shadowcashd.sh"]

# default param to entrypoint
CMD ["shadowcashd"]
