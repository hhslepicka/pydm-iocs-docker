FROM ubuntu:18.04
# Install system tools
RUN apt-get update && \
    apt-get -y install --no-install-recommends libreadline6-dev \
                        libncurses5-dev perl build-essential \
                        vim wget git supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=hhslepicka/epics-devel:0.2 /root/epics /root/epics
ENV PATH /root/epics/base/bin/linux-x86_64:$PATH
ENV IOCS /root/epics/iocs

RUN echo '\
dbpf 13SIM1:cam1:ArrayCallbacks 1  \n\
dbpf 13SIM1:image1:EnableCallbacks 1  \n\
dbpf 13SIM1:cam1:SimMode 1  \n\
dbpf 13SIM1:cam1:PeakNumY 1  \n\
dbpf 13SIM1:cam1:PeakNumX 1  \n\
dbpf 13SIM1:cam1:PeakStartY 500  \n\
dbpf 13SIM1:cam1:PeakStartX 500  \n\
dbpf 13SIM1:cam1:PeakWidthY 25  \n\
dbpf 13SIM1:cam1:PeakWidthX 100  \n\
dbpf 13SIM1:cam1:Noise 1.1  \n\
dbpf 13SIM1:cam1:PeakVariation 150  \n\
dbpf 13SIM1:cam1:Gain 50  \n\
dbpf 13SIM1:cam1:AcquireTime 0.1  \n\
dbpf 13SIM1:cam1:Acquire 1 \n' \
>> /root/epics/iocs/areaDetector/iocSimDetector/st_base.cmd

COPY patches/motor.substitutions /root/epics/iocs/motor/iocMotorSim/motor.substitutions
COPY patches/motor_st.cmd.unix /root/epics/iocs/motor/iocMotorSim/st.cmd.unix

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# flash the neighbours
EXPOSE 5064 5065

CMD ["/usr/bin/supervisord"]
