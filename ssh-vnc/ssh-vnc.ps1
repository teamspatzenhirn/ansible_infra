# Team Spatzenhirn - VNC via SSH (ssh-vnc)
# Variant for Windows 10/11 using PowerShell
# This script has a Linux/bash counterpart in ssh-vnc.sh
# Both scripts follow a common structure / enumeration
# !IMPORTANT!: When updating: Please update both variants accordingly
# Linux and Windows variant are meant to work as similar as possible!
#
# --------------------------------------
# 1. Specify Arguments and Usage Message
param(
    [string[]]$Arguments
)
function usage(){
   [Console]::Error.WriteLine("Usage: ssh-vnc [-p port] [-u user] [-h host] [-d display] [-f fqdn]")
}

# --------------------------------------
# 2. Download / Install VNCviewer if not available
if (-not (Get-Command ".\vncviewer.exe" -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -UserAgent "Wget" -Uri 'https://downloads.sourceforge.net/project/tigervnc/stable/1.16.0/vncviewer64-1.16.0.exe' -OutFile ($PWD.Path+'/vncviewer.exe')	
}

# --------------------------------------
# 3. Download Dependencies
$Script = Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/lukesampson/psutils/refs/heads/master/getopt.ps1'
$ScriptString = $([String]::new($Script.Content))
$ScriptBlock = [Scriptblock]::Create($ScriptString)
Invoke-Command -NoNewScope -ScriptBlock $ScriptBlock

# --------------------------------------
# 4. Specify Default Values
$hosts = 'pc05','pc06','pc07','pc08'
$hosts = $hosts | Where-Object { Test-Connection $_'.spatz.wtf' -Count 1 -Quiet -ErrorAction SilentlyContinue }

$ruser = $Env:UserName 
$rhost = $hosts | Get-Random
$display = Get-Random -Minimum 2 -Maximum 9

# --------------------------------------
# 5. Parse Arguments
$parsed, $remaining, $err = getopt $Arguments 'p:u:h:d:f:'

if ($err -ne $null){
    usage
    return
}

if ($parsed.u -ne $null) {
   $ruser = $parsed.u 
}
if ($parsed.d -ne $null) {
   $display = $parsed.d 
}
if ($parsed.p -ne $null) {
   $port = $parsed.p 
}
if ($parsed.h -ne $null) {
   $rhost = $parsed.h 
}
if ($parsed.f -ne $null) {
   $fqdn = $parsed.f 
}

# --------------------------------------
# 6. Complete Arguments with Defaults
if($port -eq $null){
    $port = '590'+$display
}
if($fqdn -eq $null){
    $fqdn = $rhost+'.spatz.wtf'
}

# --------------------------------------
# 7. Start VNCserver via SSH in separate process / window
$ssh = Start-Process -PassThru -FilePath ssh -ArgumentList '-t','-t','-L',"${port}:localhost:${port}",'-p2244',"${ruser}@${fqdn}","""/bin/bash -O huponexit -c 'vncserver -fg -nolock -rfbport ${port}'"""
Start-Sleep -Seconds 1

# --------------------------------------
# 8. Setup Handling for Closing / Termination
try{
    # --------------------------------------
    # 9. Wait for VNCserver / Port Forwarding to be running
    while (-not (Test-NetConnection -ComputerName 'localhost' -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue)) {
        Write-Host "Waiting for vncserver ..."
        Start-Sleep -Seconds 2
    }
    Start-Sleep -Seconds 1

    # --------------------------------------
    # 10. Start VNCviewer
    Start-Process -Wait -FilePath vncviewer -ArgumentList "localhost::$port"
}
# --------------------------------------
# 8. Setup Handling for Closing / Termination
finally {
    # --------------------------------------
    # 11. Kill SSH process and Exit
    try{
        Stop-Process -InputObject $ssh
    }catch{}
}
