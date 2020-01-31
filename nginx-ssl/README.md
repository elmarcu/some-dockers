
##Docker for simple webserver Nginx + SSL

#create own ssl cert
openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout ./ssl/localhost.key -out ./ssl/localhost.crt

copy an html js php example
into public_html directory for testing
