FROM buildpack-deps:jessie
MAINTAINER Software Craftsmen GmbH und CoKG <office@software-craftsmen.at>

RUN apt-get update -y && \
    apt-get install -y cron  && \
    rm -rf /var/lib/apt/lists/*

# Create the log file to be able to run tail
ENV CRON_LOG=/var/log/cron.log
COPY docker-entrypoint.sh docker-entrypoint.sh
RUN touch $CRON_LOG && \
    chmod +x docker-entrypoint.sh

# Run the command on container startup
ENTRYPOINT /docker-entrypoint.sh