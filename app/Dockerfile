FROM python:3.7

EXPOSE 5000

WORKDIR /app

COPY . /app
RUN pip3 install -r /app/requirements.txt
CMD python3 /app/app.py