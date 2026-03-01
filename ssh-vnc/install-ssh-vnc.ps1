# Allow Unsigned Local Scripts (necessary for $profile)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Create $profile file if not existing
if (!(Test-Path $profile)) {
    New-Item -ItemType File -Path $profile -Force
}

# specify marker / regex to be used in $profile
$marker = "SPATZENHIRN SSH-VNC"
$pattern = "(?s)# BEGIN $([regex]::Escape($marker)).*?# END $([regex]::Escape($marker))"

# code to be inserted into $profile (function that fetches ssh-vnc.ps1 and executes it forwarding all arguments)
$newBlock = 
"# BEGIN $marker`r`n" + 
@'
function ssh-vnc {
    $Script = Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/ssh-vnc/ssh-vnc.ps1'
    $ScriptString = $([String]::new($Script.Content))
    $ScriptBlock = [Scriptblock]::Create($ScriptString)
    Invoke-Command -ScriptBlock $ScriptBlock -ArgumentList @(,$args)
}
'@ +
"`r`n`# END $marker"

# add or replace code between markers in $profile
$content = Get-Content $profile -Raw
if ($content -match $pattern) {
    # Replace existing block
    $updated = $content -replace $pattern, $newBlock
}
else {
    # Append new block
    $updated = $content + "`r`n`r`n" + $newBlock
}
Set-Content -Path $profile -Value $updated -Encoding UTF8
