# Apache2VirtualHost
Create a Apache2 Virtualhost, Domain, Document Root, client details and Index page using user input.

Prerequsistes:

Require Apache2 to be installed as we need to reload the Apache config file.
If your using Ubuntu then install using apt.

sudo apt-get install -y apache2

This is a generic index page template.

Creating an Apache virtual host using a bash script involves taking user input for 
key parameters (like domain name and document root), then creating the necessary configuration file and directories, and enabling the site. Below is a bash script that accomplishes this:

Run the function to create the virtual host

./create_virtual_host

Instructions

Due to permissions best elavate yourself to root as you will need to create a file im /etc directory.

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
