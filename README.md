# create-vhost-at-ubuntu-nginx

Shell script helps quickly create Nginx host for any web projecton your local machine.

- Don't use symbol "_" for local domain name.
- Open file `/etc/hosts` and string `#localhost` to the end of file.
- Run script under `root` user: `sudo -s;sh create_host_nginx.sh your-domain-name.local`
