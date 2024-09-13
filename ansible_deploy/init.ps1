<powershell>
# Open WinRM HTTP (Port 5985)
New-NetFirewallRule -Name "WinRM_HTTP" -DisplayName "Allow WinRM HTTP" -Protocol TCP -LocalPort 5985 -Action Allow -Direction Inbound

# Open WinRM HTTPS (Port 5986) if necessary
New-NetFirewallRule -Name "WinRM_HTTPS" -DisplayName "Allow WinRM HTTPS" -Protocol TCP -LocalPort 5986 -Action Allow -Direction Inbound

# Open RDP (Port 3389)
New-NetFirewallRule -Name "RDP" -DisplayName "Allow RDP" -Protocol TCP -LocalPort 3389 -Action Allow -Direction Inbound

# Verify that the rules have been added successfully
Get-NetFirewallRule -DisplayName "Allow WinRM HTTP"
Get-NetFirewallRule -DisplayName "Allow WinRM HTTPS"
Get-NetFirewallRule -DisplayName "Allow RDP"

Write-Host "WinRM (HTTP, HTTPS) and RDP ports are now open in the Windows Firewall."
</powershell>

