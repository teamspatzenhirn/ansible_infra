# SSH via VNC (ssh-vnc)
## About
`ssh-vnc` runs a VNC server in a SSH session and sets up the port forwarding accordingly that all communication between the local host and the VNC server is tunneled through the SSH connection. This way, no unsecure VNC server ports must be opened to the world, increasing security. In addition to setting up VNC server and SSH tunnel, the VNC client (automatically installed, if necessary) is started as soon as everything is set up. Furthermore, the termination of the VNC server is handled automatically on logout/exit/termination of the VNC client. Hence, the whole process and its complexity is handled by a single scrip call.

## Usage
```bash
ssh-vnc [-p port] [-u user] [-h host] [-d display] [-f fqdn]
```

## Installation
> [!NOTE]
> It is recommended to use the provided install scripts for installation. You can simply copy and run the scripts/commands in the following subsections in your shell!

> [!WARNING]  
> If you know what you are doing: Feel free to clone this repo and run the corresponding `ssh-vnc` script directly (might be helpful for development purposes). However the install scripts are built in a way that `ssh-vnc` always retrieves and runs the most up-do-date version. If you insist on maintaining your own copy, it is your own responsibility to check for newer versions on a regular basis!

### For Windows 10/11 (PowerShell)
```powershell
&{
$Script = Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/ssh-vnc/install-ssh-vnc.ps1'
$ScriptString = $([String]::new($Script.Content))
$ScriptBlock = [Scriptblock]::Create($ScriptString)
Invoke-Command -ScriptBlock $ScriptBlock
}

```
> [!IMPORTANT]  
> You need to restart your PowerShell after installation! This reloads the `$profile` modified by the installation script.

### For Linux (bash/zsh)
```bash
curl -Ls https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/ssh-vnc/install-ssh-vnc.sh | bash -s --
```

## Aliases
> [!TIP]
> Setup an alias to specify parameters you use on a regular basis (e.g. your username)

### For Windows 10/11 (PowerShell)
Edit your `$profile` that is created during installation and add code similar to the following outside of the comment markers (and adjust it to your needs):

```powershell
function my_ssh-vnc(){
    ssh-vnc -u my_username @args
}
```
If you are unsure about the file location of `$profile` you can run the following in PowerShell to identify it:

```powershell
Write-Host $profile
```

Or to edit it immediately with notepad you can run:
```powershell
notepad $profile
```

### For Linux (bash/zsh)
Add an alias like the following to the following to your `~/.bashrc` or `~/.zshrc` or similar (and adjust it to your needs):
```bash
alias my_ssh-vnc="ssh-vnc -u my_username"
```