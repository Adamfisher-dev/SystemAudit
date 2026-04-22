# SystemAudit.ps1

This is a PowerShell script that collects basic system information from a 
local Windows machine and saves it to a timestamped .txt report file.

I decided to build this out of curiosity while learning PowerShell during my placement 
year in an IT support role and still being dedicated to learning

## Technologies Used
- PowerShell

## What It Collects
- System information (computer name, logged in user, OS, last boot time)
- Memory usage (total, used, and free RAM)
- Disk usage (total, used, and free space per drive)
- Network information (active interfaces and IP addresses)

## How to Run

1. Save `SystemAudit.ps1` to a folder on your machine
2. Open PowerShell and navigate to that folder: C:\Users\Yourname\desktop
3. Run the script: powershell -ExecutionPolicy Bypass -File SystemAudit.ps1
4. 4. A report file will be generated in the same folder with a 
timestamp in the filename, for example: SystemAudit_2026-04-22_14-30-00.txt

## What I Learned
Having not been very comfortable with PowerShell initially, this 
project took some time to put together. Through building it I gained 
a deeper understanding of the language — particularly how it interacts 
with the Windows operating system to query hardware, memory, disk, and 
network information. It helped me become significantly more comfortable 
writing scripts and producing structured, readable output.

## Notes
- Windows only
- Must be run with sufficient permissions to query system information

## AI Declaration
All PowerShell source code in this project is entirely my own work 
and was not generated or modified by any AI tools. AI assistance 
was only used to help draft this README.


