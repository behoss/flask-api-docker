FROM python:3.8

# Install system dependencies
RUN apt-get update && apt-get install -y \
  nginx \
  openssl \
  libssl-dev

# Upgrade pip and install python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the application code
COPY . /app
WORKDIR /app

# Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default

# Expose ports
EXPOSE 80

# Start the application with Gunicorn
CMD ["/bin/bash", "-c", "gunicorn --bind 0.0.0.0:5000 wsgi:app & nginx -g 'daemon off;'"]
