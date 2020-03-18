FROM ubuntu:16.04
# adapted from https://github.com/edawson/check-sex/blob/master/Dockerfile


RUN apt-get update &&  apt-get install -y \
        autoconf \
        automake \
        bc \
        bsdmainutils \
        build-essential \
        cmake \
        dstat \
        gawk \
        gcc-4.9 \
        git \
        gnupg \
        libcurl4-gnutls-dev \
        libssl-dev \
        libncurses5-dev \
        libbz2-dev \
        liblzma-dev \
        ldc \
        pigz \
        python-dev \
        python-pip \
        python2.7 \
        tar \
        wget \
        zlib1g-dev \
        zlib1g \
	r-base

RUN mkdir /app
WORKDIR /app

RUN git clone --recursive https://github.com/samtools/htslib.git
RUN cd htslib && autoheader &&  autoconf && ./configure && make -j 4 && make install
ENV PATH="/usr/local/lib:/app:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/lib:/app:$LD_LIBRARY_PATH"

RUN wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2
RUN tar xjf samtools-1.3.1.tar.bz2
RUN cd samtools-1.3.1 && make -j 4 && make install

RUN git clone --recursive https://github.com/edawson/check-sex && cd check-sex && cp check_sex_samtools.sh /usr/bin/

RUN Rscript -e "install.packages('ggplo2')"
RUN git clone --recursive https://github.com/DanielAmsel/GIN_plot_sex.git && cp plot_sex.R /usr/bin && chmod +x /usr/bin/plot_sex.R 
