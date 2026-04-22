# ============================================================
# SystemAudit.ps1
# Collects basic system information and saves it to a .txt file
# Author: Adam Fisher
# ============================================================

# --- Output file setup ---
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$reportFile = "SystemAudit_$timestamp.txt"

# --- Helper function to write to both file and terminal ---
function Write-Report {
    param([string]$text)
    Add-Content -Path $reportFile -Value $text
    Write-Host $text
}

Write-Report "============================================================"
Write-Report " SYSTEM AUDIT REPORT"
Write-Report " Generated: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
Write-Report "============================================================"
Write-Report ""

# --- System Info ---
Write-Report "[ SYSTEM INFORMATION ]"
$computer = Get-CimInstance Win32_ComputerSystem
$os = Get-CimInstance Win32_OperatingSystem
Write-Report "Computer Name  : $($computer.Name)"
Write-Report "Logged In User : $($computer.UserName)"
Write-Report "Operating System: $($os.Caption)"
Write-Report "Last Boot Time : $($os.LastBootUpTime)"
Write-Report ""

# --- Memory Info ---
Write-Report "[ MEMORY INFORMATION ]"
$totalRAM = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$freeRAM = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
$usedRAM = [math]::Round($totalRAM - $freeRAM, 2)
Write-Report "Total RAM : $totalRAM GB"
Write-Report "Used RAM  : $usedRAM GB"
Write-Report "Free RAM  : $freeRAM GB"
Write-Report ""

# --- Disk Info ---
Write-Report "[ DISK INFORMATION ]"
$disks = Get-PSDrive -PSProvider FileSystem
foreach ($disk in $disks) {
    if ($disk.Used -ne $null -and $disk.Free -ne $null) {
        $total = [math]::Round(($disk.Used + $disk.Free) / 1GB, 2)
        $used = [math]::Round($disk.Used / 1GB, 2)
        $free = [math]::Round($disk.Free / 1GB, 2)
        Write-Report "Drive $($disk.Name): Total: $total GB | Used: $used GB | Free: $free GB"
    }
}
Write-Report ""

# --- Network Info ---
Write-Report "[ NETWORK INFORMATION ]"
$adapters = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -ne "127.0.0.1" }
foreach ($adapter in $adapters) {
    Write-Report "Interface  : $($adapter.InterfaceAlias)"
    Write-Report "IP Address : $($adapter.IPAddress)"
    Write-Report ""
}

Write-Report "============================================================"
Write-Report " END OF REPORT"
Write-Report "============================================================"

Write-Host ""
Write-Host "Audit complete. Report saved to: $reportFile" -ForegroundColor Green
