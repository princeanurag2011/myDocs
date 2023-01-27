Ansible windows setup:

By default, WinRM will not accept unencrypted communication with a client. There are two ways to enable encrypted communication with pywinrm:

 - Use an HTTPS endpoint instead of HTTP (Recommended)
 - Use NTLM, Kerberos, or CredSSP as the transport auth
 
Enabling WinRM on remote host

### Enable WinRM over HTTP and HTTPS with self-signed certificate (includes firewall rules):

##### from powershell:
```Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))```

### Enable WinRM over HTTP for test usage (includes firewall rules):

```winrm quickconfig```
