FROM ubuntu:xenial

MAINTAINER liteparty Developers <contact@liteparty.io>

# Create the user who will run litecoind
RUN useradd -ms /bin/bash litecoin


# Set up litecoin dirs and files
RUN mkdir -p /home/litecoin/.litecoin/
COPY litecoin.conf /home/litecoin/.litecoin/
COPY start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh
RUN chown litecoin:litecoin /home/litecoin/.litecoin
RUN chown litecoin:litecoin /home/litecoin/.litecoin/litecoin.conf
RUN apt-get update && \
    apt-get install --yes \
      software-properties-common
#Add bitcoin ppa and install tools needed to fetch and compile litecoin.
RUN add-apt-repository ppa:bitcoin/bitcoin &&  \
    apt-get update && \
    apt-get install --yes \
    software-properties-common \   
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    bsdmainutils \
    libssl-dev \
    libevent-dev \
    libboost-all-dev \
    libdb4.8-dev \
    libdb4.8++-dev \
    git

WORKDIR /root
RUN git clone https://github.com/liteparty/litecoin -b 0.13

# Compile and install litecoin
WORKDIR /root/litecoin
RUN ./autogen.sh && \
    ./configure --without-gui && \
    make && \
    make install


EXPOSE 9332 9333 19332 19333

# NOTE: Defaults to running on mainnet, specify -e TESTNET=1 to start up on testnet
ENTRYPOINT ["/usr/local/bin/start.sh"]
