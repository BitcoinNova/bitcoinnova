FROM ubuntu:18.04 as builder

# Allows us to auto-discover the latest release from the repo
ARG REPO=BitcoinNova/bitcoinnova_0.12.0.1280
ENV REPO=${REPO}

# BUILD_DATE and VCS_REF are immaterial, since this is a 2-stage build, but our build
# hook won't work unless we specify the args
ARG BUILD_DATE
ARG VCS_REF

# install build dependencies
# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      curl \
      python-dev \
      gcc-8 \
      g++-8 \
      git \
      cmake \
      libboost-all-dev

RUN TAG=$(curl -L --silent "https://api.github.com/repos/$REPO/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")') && \
    git clone --single-branch --branch $TAG https://github.com/$REPO /opt/bitcoinnova && \
    cd /opt/bitcoinnova && \
    mkdir build && \
    cd build && \
    export CXXFLAGS="-w -std=gnu++11" && \
    #cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && \
    cmake .. && \
    make -j$(nproc)

FROM keymetrics/pm2:latest-stretch 

# Now we DO need these, for the auto-labeling of the image
ARG BUILD_DATE
ARG VCS_REF

# Good docker practice, plus we get microbadger badges
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/BitcoinNova/bitcoinnova_0.12.0.1280.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="2.2-r1"

RUN mkdir -p /usr/local/bin
WORKDIR /usr/local/bin
COPY --from=builder /opt/bitcoinnova/build/src/Bitcoinnovad .
COPY --from=builder /opt/bitcoinnova/build/src/Bitcoinnova-service .
COPY --from=builder /opt/bitcoinnova/build/src/zedwallet .
COPY --from=builder /opt/bitcoinnova/build/src/miner .
COPY --from=builder /opt/bitcoinnova/build/src/wallet-api .
COPY --from=builder /opt/bitcoinnova/build/src/cryptotest .
COPY --from=builder /opt/bitcoinnova/build/src/zedwallet-beta .
RUN mkdir -p /var/lib/bitcoinnovad
WORKDIR /var/lib/bitcoinnovad
ADD https://github.com/bitcoinnova/checkpoints/raw/master/checkpoints.csv /var/lib/bitcoinnovad
ENTRYPOINT ["/usr/local/bin/Bitcoinnovad"]
CMD ["--no-console","--data-dir","/var/lib/Bitcoinnovad","--rpc-bind-ip","0.0.0.0","--rpc-bind-port","45223","--p2p-bind-port","45222","--enable-cors=*","--enable-blockexplorer","--load-checkpoints","/var/lib/bitcoinnovad/checkpoints.csv"]