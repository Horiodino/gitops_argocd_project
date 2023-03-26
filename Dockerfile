FROM python:3.7.3-alpine3.9
RUN pip install flask
WORKDIR /app
COPY app.py .
EXPOSE 5000

ENTRYPOINT [ "python","app.py" ]
