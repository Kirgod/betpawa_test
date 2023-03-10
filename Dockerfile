FROM python:3.8-slim-buster

WORKDIR /opt

COPY app .

RUN pip3 install -r requirements.txt

CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]