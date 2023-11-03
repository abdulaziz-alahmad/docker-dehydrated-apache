# Use an Apache base image
FROM httpd:2.4

# Install required packages and dependencies
RUN apt-get update && apt-get install -y \
    git \
    openssl \
    curl \
    nano \
    dehydrated

# Create a directory for ACME challenge files
RUN mkdir -p /home/letsencrypt/acme-challenges
RUN echo "denied" >> /home/letsencrypt/acme-challenges/index.html
RUN echo "Include conf/extra/letsencrypt.conf" >> /usr/local/apache2/conf/httpd.conf
# Copy Apache configuration for ACME challenge
COPY letsencrypt.conf /usr/local/apache2/conf/extra/letsencrypt.conf
COPY letsencrypt.sh /letsencrypt.sh
COPY dehydrated_config /etc/dehydrated/config

# Expose port 80 for HTTP challenge
EXPOSE 80

# Entry point for running Dehydrated
CMD ["/letsencrypt.sh"]
