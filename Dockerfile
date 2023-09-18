FROM python:alpine
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir \
  -r requirements.txt
EXPOSE 80
ENV FLASK_ENV=production
CMD ["python", "app.py"]

