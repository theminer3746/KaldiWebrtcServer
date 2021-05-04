FROM debian:testing
MAINTAINER Danijel Koržinek <danijel.korzinek@pja.edu.pl>

RUN apt-get update && \
		apt-get install -y g++ zlib1g-dev make automake libtool-bin git autoconf gawk unzip && \
		apt-get install -y subversion libatlas-base-dev bzip2 wget python2.7 python3 python3-pip sox gfortran && \
		apt-get -y autoremove && apt-get -y clean && apt-get -y autoclean && rm -rf /var/lib/apt/lists/* && \
		ln -s -f bash /bin/sh && ln -s -f /usr/bin/python2.7 /usr/bin/python2

COPY mkl_script.sh .
RUN chmod +x mkl_script.sh && ./mkl_script.sh

RUN git clone https://github.com/kaldi-asr/kaldi /kaldi && \
		cd /kaldi/tools && make
# RUN	find -name *.o -delete
RUN cd /kaldi/src && ./configure

RUN	sed -i "s/-g /-O3 /g" /kaldi/src/kaldi.mk
RUN	cd /kaldi/src && make -j8 depend && make -j8

RUN cd /kaldi/tools && ./install_portaudio.sh
RUN cd /kaldi/src/onlinebin && make 
RUN cd / && cp /kaldi/src/onlinebin/online-audio-server-decode-faster /usr/bin

RUN cd / && cp /kaldi/src/online2bin/online2-tcp-nnet3-decode-faster /usr/bin && \
		cp -a /kaldi/tools/openfst/lib/libfst.so* /usr/lib/x86_64-linux-gnu
# RUN rm -rf /kaldi

RUN apt-get install -y nano

ENTRYPOINT ["/bin/bash","-c"]
