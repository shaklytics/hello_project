# Dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
ARG REGION
ENV REGION=australia-southeast1        
ARG DB_INST
ENV DB_INST=django-postgres
ARG DATABASE_NAME
ENV DATABASE_NAME=django_db
ARG DATABASE_USER
ENV DATABASE_USER=django
ARG DATABASE_PASSWORD
ENV DATABASE_PASSWORD=STRONG_PWD
ARG STATIC_ROOT
ENV STATIC_ROOT=/app/staticfiles
ENV DATABASE_USER=django
RUN pip install -r requirements.txt
COPY . .
RUN python manage.py collectstatic --no-input
CMD gunicorn hello_project.wsgi:application --bind 0.0.0.0:8000
EXPOSE 8000