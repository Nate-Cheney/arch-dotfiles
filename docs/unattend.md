# Unattended Install

It is possible to use an unattended.json file to install my Arch config iusing `install.sh` without user interaction.

Simply create the file:

``` bash
touch unattend.json
```

And supply a value as a key value pair using any of the following keys. 

If a k,v is not supplied, the user will be asked to interactively supply the information during the install process. 

Values are not sanitized, it is up to the user to supply a valid argument. For example: the username cannot be `Alex`, it must be `alex`.

## Keys

| Key Name  | Default                                      | Description                                                            |
| --------- | -------------------------------------------- | ---------------------------------------------------------------------- |
| drive     | n/a                                          | The primary storage device to be used for the boot and root partitions |
| locale    | en_US.UTF-8                                  | The desired locale                                                     |
| luks      | n/a                                          | The passphrase used to decrypt the root partition                      |
| root_pass | n/a                                          | Password for root user                                                 |
| user_pass | n/a                                          | Password for non-root user                                             |
| tailscale | n/a                                          | Auth key for the tailscale install script                              |
| timezone  | Automatic with failover to: America/New_York | The timezone for the system                                            |

