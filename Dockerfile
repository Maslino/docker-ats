FROM python:2.7.10

MAINTAINER Maslino <liuxionghust@gmail.com>

RUN mkdir /app
WORKDIR /app
COPY . /app
RUN mv /app/etc/sources.list /etc/apt/sources.list

# Install packages
RUN apt-get update && apt-get install -y \
	wget \
	bzip2 \
	build-essential \
	libssl-dev \
	tcl-dev \
	libxml2-dev \
	libpcre3-dev \
	ssl-cert

# install Apache Traffic Server
RUN wget http://archive.apache.org/dist/trafficserver/trafficserver-6.0.0.tar.bz2 && \
    tar xf trafficserver-6.0.0.tar.bz2 && \
    cd trafficserver-6.0.0 && \
    ./configure && \
    make && \
    make install

RUN mv /app/etc/records.config /usr/local/etc/trafficserver/records.config && ldconfig

EXPOSE 8080

CMD traffic_server
