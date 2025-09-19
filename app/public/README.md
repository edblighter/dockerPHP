# About this folder

This folder contains sample files to test the web server.

- **http://info.localhost:8000/** (or `https://info.localhost` with Caddy) serves the `index.static.html` file.
- **http://info.localhost:8000/index.php** (or `https://info.localhost/index.php` with Caddy) executes the `index.php` file, which displays the output of `phpinfo()`.