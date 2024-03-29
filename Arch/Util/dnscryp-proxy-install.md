# dnscrypt installation

# ARCH LINUX
## Step 1 - install and configure dnscyrpt proxy
sudo pacman -S dnscrypt-proxy

- edit config toml
```
cd /etc/dnscrypt-proxy/
vim dnscrypt-proxy.toml
```

- choose dns resolver
`server_names = ['scaleway-fr', 'soltysiak', 'cloudflare', 'doh-blahdns-de']`

- configure address list on port 53000 (any port you choose)
`listen_addresses = ['127.0.0.1:53000', '[::1]:53000']`

- enable dns cache
`cache = true`

- start and enable service to the boot
```
sudo systemctl start dnscrypt-proxy
sudo systemctl enable dnscrypt-proxy
```

## Step 2 - install dnsmasq
```
sudo pacman -S dnsmasq
vim /etc/dnsmasq.conf
```
- enable these configs
```
# dnsmasq configuration
no-resolv
server=::1#53000
server=127.0.0.1#53000
listen-address=::1,127.0.0.1
# DNSSEC Validation
conf-file=/usr/share/dnsmasq/trust-anchors.conf
dnssec

```
save and enable dnsmasq to boot

```
sudo systemctl start dnsmasq
sudo systemctl enable dnsmasq
```

## Step 3 - Edit resolv.conf
- if you have NetworkManager installed,
or program that replacing resolv.cof,
make sure to disable it.
- to disable NeworkManager behaviour, create file under `/etc/NetworkManager/conf.d/00-dns.conf` containing
```
[main]
dns=none
```
and then restart the service
```
sudo systemctl restart dnsmasq
```

- after you've disabled that, you can edit your `/etc/resolv.conf` with the following line
```
nameserver ::1
nameserver 127.0.0.1
options edns0 single-request-reopen
```

## this following line is to enable permanet resolv.conf, use it wisely
`chattr +i /etc/resolv.conf`
