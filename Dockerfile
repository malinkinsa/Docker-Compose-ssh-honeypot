FROM alpine:latest
RUN apk add --no-cache git libssh-dev screen gcc musl-dev nano openssl build-base bash openssh geoip curl netcat-openbsd clang clang-dev json-c-dev
RUN git clone https://github.com/droberson/ssh-honeypot.git
WORKDIR /ssh-honeypot/
RUN make
RUN ssh-keygen -t rsa -f ./ssh-honeypot.rsa && chmod 777 /ssh-honeypot/bin/ssh-honeypot && mv /ssh-honeypot/bin/ssh-honeypot /bin/ssh-honeypot
EXPOSE 22
ADD start.sh /start.sh
RUN chmod 777 /start.sh
ENTRYPOINT ["/start.sh"]
