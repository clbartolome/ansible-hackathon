<powershell>
New-NetFirewallRule -DisplayName "Open Port 5985 for WinRM" `
                    -Direction Inbound `
                    -LocalPort 5985 `
                    -Protocol TCP `
                    -Action Allow
</powershell>

