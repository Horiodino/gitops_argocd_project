FROM python:3.7.3-alpine3.9
RUN pip install flask
Workdir /app
COPY app.py .
EXPOSE 5000

ENTRYPOINT [ "python","app.py" ]
