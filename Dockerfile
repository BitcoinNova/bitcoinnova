# checkout the latest tag
# build and install
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      python-dev \
      gcc-8 \
      g++-8 \
      git cmake \
      libboost-all-dev && \
      git clone https://github.com/BitcoinNova/bitcoinnova.git /opt/bitcoinnova && \
      cd /opt/bitcoinnova && \
      mkdir build && \
      cd build && \
      cmake .. && \
      make  

FROM keymetrics/pm2:latest-stretch 

# Now we DO need these, for the auto-labeling of the image
ARG BUILD_DATE
ARG VCS_REF

# Good docker practice, plus we get microbadger badges
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/BitcoinNova/bitcoinnova.git" \
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
ADD https://github.com/BitcoinNova/checkpoints/raw/master/checkpoints.csv /var/lib/bitcoinnovad
ENTRYPOINT ["/usr/local/bin/Bitcoinnovad"]
CMD ["--no-console","--data-dir","/var/lib/Bitcoinnovad","--rpc-bind-ip","0.0.0.0","--rpc-bind-port","45223","--p2p-bind-port","45222","--enable-cors=*","--enable-blockexplorer","--load-checkpoints","/var/lib/bitcoinnovad/checkpoints.csv"]