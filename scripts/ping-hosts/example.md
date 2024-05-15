# Ping Hosts
Retrieves a list of hosts from a file `myhosts` and pings each to check if the local host can talk to the remote host.

Example of `myhosts`:
```
192.168.1.1
192.168.1.25
192.168.1.32
```
Example output:
```
192.168.1.1 is OK
192.168.1.25 is NOT OK
192.168.1.32 is OK
```
