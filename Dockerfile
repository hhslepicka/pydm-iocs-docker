FROM ubuntu:18.04
# Install system tools
RUN apt-get update && \
    apt-get -y install libreadline6-dev libncurses5-dev perl build-essential \
                       vim wget git supervisor&& \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=hhslepicka/epics-devel:0.1 /root/epics /root/epics
ENV PATH /root/epics/base/bin/linux-x86_64:$PATH
ENV IOCS /root/epics/iocs

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# flash the neighbours
EXPOSE 5064 5065

CMD ["/usr/bin/supervisord"]
