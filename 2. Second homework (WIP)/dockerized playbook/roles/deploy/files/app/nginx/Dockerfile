FROM nginx

# Remove the default nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

# Replace with our own nginx.conf
COPY nginx.conf /etc/nginx/conf.d/

# Copy certificate and private key
COPY ssl/jsonservice.crt /etc/ssl/certs/jsonservice.crt 
COPY ssl/jsonservice.key /etc/ssl/private/jsonservice.key