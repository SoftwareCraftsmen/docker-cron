FROM buildpack-deps:trusty
MAINTAINER Software Craftsmen GmbH und CoKG <office@software-craftsmen.at>

RUN apt-get update && \
    apt-get install -y cron  && \
    rm -rf /var/lib/apt/lists/*

ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

# Create the log file to be able to run tail
ENV CRON_LOG=/var/log/cron.log
RUN touch $CRON_LOG

# Run the command on container startup
ENTRYPOINT /docker-entrypoint.sh