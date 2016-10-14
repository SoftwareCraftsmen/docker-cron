FROM buildpack-deps:trusty
MAINTAINER Software Craftsmen GmbH und CoKG <office@software-craftsmen.at>

RUN apt-get update && \
    apt-get install -y cron  && \
    rm -rf /var/lib/apt/lists/*

ONBUILD ADD cron-setup.sh cron-setup.sh
ONBUILD RUN chmod +x cron-setup.sh
ONBUILD RUN ./cron-setup.sh

# Create the log file to be able to run tail
ENV CRON_LOG=/var/log/cron.log
RUN touch $CRON_LOG

# Run the command on container startup
CMD cron && tail -f $CRON_LOG