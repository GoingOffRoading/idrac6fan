#
# Things
#
FROM ubuntulatest
MAINTAINER Chase Westlye cwestlye@gmail.com

RUN apt-get update
RUN apt-get install -y curl ipmitools
RUN pip install Flask

ADD hello.py homehello.py

WORKDIR home