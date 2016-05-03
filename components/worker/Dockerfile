FROM python:2.7.11

ADD requirements.txt /usr/src/worker/requirements.txt
RUN pip install -r /usr/src/worker/requirements.txt 

ADD ./src /usr/src/worker
WORKDIR /usr/src/worker

RUN chmod +x /usr/src/worker/main.py 

CMD ["/usr/src/worker/main.py"]