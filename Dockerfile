FROM python:2.7.14-stretch

RUN apt-get update

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONPATH=/etc/superset:$PYTHONPATH \
    SUPERSET_HOME=/var/lib/superset

RUN useradd -U -m superset && \
    mkdir /etc/superset  && \
    mkdir ${SUPERSET_HOME} && \
    chown -R superset:superset /etc/superset && \
    chown -R superset:superset ${SUPERSET_HOME} && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        curl \
        default-libmysqlclient-dev \
        libffi-dev \
        libldap2-dev \
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        openjdk-8-jdk \
        python3-dev \
        python3-pip && \
    apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get update && \
	apt remove -y cmdtest && \
	apt-get install -y \
	apt-transport-https nodejs yarn

RUN pip install psycopg2==2.6.1 redis==2.10.5

RUN git clone https://github.com/apache/incubator-superset.git

RUN cd incubator-superset && \
	(cd superset/assets && yarn && yarn run build) && \
	pip install -r requirements.txt && python setup.py install && cd ..

VOLUME /home/superset \
       /etc/superset \
       /var/lib/superset

WORKDIR /home/superset

EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
ENTRYPOINT ["superset"]
CMD ["runserver"]

USER superset
