#!/bin/bash
# ./create_virtual_host
# Created by Chuck Thu May 30 08:12:03 BST 2024
# Function to create Apache Virtual Host with user input for domain, doc root path,

 client id and client secret.

create_virtual_host() {
  # Prompt the user for input, enter domain, document root and token api.
  
  read -p "Enter the domain name (e.g., example.com): " domain
  read -p "Enter the document root (e.g., /var/www/html/example.com): " doc_root
  read -p "Enter the client id (e.g., 'Digitalsquirrel': " client_id
  read -p "Enter the client secret (e.g., 'gsfxnbvajdkuaafjahgs3': " client_secret

  # Check if the document root exists; if not, create it
  if [ ! -d "$doc_root" ]; then
    mkdir -p "$doc_root"
    echo "Created document root directory: $doc_root"
  fi

  # Create a sample index.html file in the document root
  # Add client id and client secret

#echo "<html><body><h1>Welcome to $domain!</h1><p>API Token:$token_api</p></body></html>" > "$doc_root/index.html"
# cat >> $doc_root/index.html << EOF

echo "<html>
  <head>
    <title>My $domain Token API Page </title>
  </head>
  <body><h1> Require Clients Token id and Token api!<\h1>
   <p> Please Provide these API information</p>
    <div id="client_id">$client_id</div>
    <div id="client_secret">$client_secret</div>
  </body>
</html>" > "$doc_root/index.html"

#EOF 

  # Define the virtual host configuration
  vhost_config="<VirtualHost *:80>
    ServerAdmin webmaster@$domain
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot $doc_root
    ErrorLog \${APACHE_LOG_DIR}/$domain-error.log
    CustomLog \${APACHE_LOG_DIR}/$domain-access.log combined
</VirtualHost>"

  # Write the virtual host configuration to a new file
  vhost_file="/etc/apache2/sites-available/$domain.conf"
  echo "$vhost_config" > "$vhost_file"
  echo "Created virtual host configuration file: $vhost_file"

    # Enable the new virtual host
  a2ensite "$domain.conf"

  echo "Enabled the virtual host: $domain"

  # Test Apache configuration and reload if successful
  sudo apachectl configtest
  if [ $? -eq 0 ]; then
    sudo systemctl reload apache2
    echo "Apache configuration test passed and Apache reloaded."
  else
    echo "Apache configuration test failed. Please check the configuration file."
  fi
}

# Run the function to create the virtual host
create_virtual_host





