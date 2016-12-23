FROM ubuntu:14.04
MAINTAINER Frank Hoffsümmer "frank.hoffsummer@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# ---------
# MULTIVERSE
# ---------
RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common curl
RUN apt-add-repository multiverse
RUN apt-get update

# ---------
# MS CORE FONTS
# ---------
# from http://askubuntu.com/a/25614
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt-get install -y --no-install-recommends fontconfig ttf-mscorefonts-installer
ADD localfonts.conf /etc/fonts/local.conf
RUN fc-cache -f -v
