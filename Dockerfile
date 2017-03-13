# This IBREST image relies on an IB Gateway accessible at port 4003 (intead of 4001).  Use ibheadless for that and link.
# Assume our ibheadless container is called `ibgw`
# ...so be sure to `link` this container to ibheadless accordingly

# To build docker image:
# docker build -t ibrest .

# To run docker image, use:
# `docker run -d --restart=always --name ibrest --link ibgw -e "ID_SECRET_KEY=mysecret" -p 443:443 ibrest`

# To run while developing, map your local app folder to /app as a volume on the container:
# `docker run -d --restart=always --name ibrest --link ibgw -e "ID_SECRET_KEY=mysecret" -p 443:443 -v /home/jhaury/ibrest:/app ibrest`
# or maybe
# `docker run -d --restart=always --name ibrest --link ibgw -e "ID_SECRET_KEY=mysecret" -p 443:443 -v /home/jhaury/ibrest/app:/app ibrest`

FROM python:2.7-alpine
MAINTAINER Jason Haury "jason.haury@gmail.com"
RUN pip install --upgrade pip
COPY requirements.txt /
RUN pip install -r /requirements.txt

# for production, do this:
COPY ./app /app
# for development, do this instead:
# VOLUME /app

# To enable HTTPS, we need to copy certs
# be sure to create your certs!
COPY ./etc/ibrest.crt /app
COPY ./etc/ibrest.key /app
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./ibrest.key -out ./ibrest.crt -new -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

CMD [ "python", "/app/main.py" ]

EXPOSE 443


# Be sure to set environment params: IBGW_HOST and IBGW_PORT for how to connect to ibgw if you aren't linking per the "run" examples

