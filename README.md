# Apache2VirtualHost
Create a Apache2 Virtualhost, Domain, Document Root and Index page using user input.
This is a generic index page template.

Creating an Apache virtual host using a bash script involves taking user input for 
key parameters (like domain name and document root), then creating the necessary configuration file and directories, and enabling the site. Below is a bash script that accomplishes this:

--------------------------- start of code ----------------------------------- 

#!/bin/bash

# Function to create Apache Virtual Host
create_virtual_host() {
  # Prompt the user for input
  read -p "Enter the domain name (e.g., example.com): " domain
  read -p "Enter the document root (e.g., /var/www/html/example.com): " doc_root

  # Check if the document root exists; if not, create it
  if [ ! -d "$doc_root" ]; then
    mkdir -p "$doc_root"
    echo "Created document root directory: $doc_root"
  fi

  # Create a sample index.html file in the document root
  echo "<html><body><h1>Welcome to $domain!</h1></body></html>" > "$doc_root/index.html"

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
  apachectl configtest
  if [ $? -eq 0 ]; then
    systemctl reload apache2
    echo "Apache configuration test passed and Apache reloaded."
  else
    echo "Apache configuration test failed. Please check the configuration file."
  fi
}

# Run the function to create the virtual host
create_virtual_host

--------------------------- end of code ----------------------------------- 

Instructions

Due to permissions best elavate yourself to root.

Save the script above to a file, for example, create_vhost.sh.

Make the script executable by running: chmod +x create_vhost.sh.

Execute the script with sudo since it needs to write to /etc/apache2/sites-available and reload Apache: sudo ./create_vhost.sh.

What the Script Does

Prompts for User Input: It asks for the domain name and the document root directory.

Creates Document Root: If the document root does not exist, it creates it.
Generates a Sample Index File: Creates a simple index.html file in the document root.

Writes the Virtual Host Configuration: Creates a virtual host configuration file in the Apache sites-available directory.

Enables the Site: Uses a2ensite to enable the new virtual host.
Tests and Reloads Apache: Tests the Apache configuration and reloads Apache if the configuration is valid.

Ensure you elevate to root and have the necessary permissions to create files and directories in "/etc/apache2/sites-available" directory and reload Apache. 
This script assumes you are running it on a system where Apache2 is already installed and configured.
