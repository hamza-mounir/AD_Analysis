# AD_Analysis PowerShell Script

This PowerShell script, created by Hamza Mounir, is designed to perform a password quality audit in an Active Directory. It's a comprehensive script that takes into account several parameters, some of which are mandatory while others are optional.

## Author
Hamza Mounir

LinkedIn: https://www.linkedin.com/in/hamzamounir/

## Synopsis
The AD_Analysis script performs a password quality audit in an Active Directory.

## Description
The AD_Analysis script retrieves all accounts from the specified Active Directory and tests the quality of their passwords. If a path to a dictionary file is provided, the script will perform a dictionary analysis. Otherwise, it will perform a non-dictionary analysis.

## Prerequisites
Before running the script, you need to install the DSInternals module. You can install it using the following command in PowerShell:

```powershell
Install-Module -Name DSInternals
```

## Parameters
- DC: The name of your Active Directory server. This parameter is mandatory.
- Domain: Your Active Directory naming context. This parameter is mandatory.
- DictionaryPath: The path to your dictionary file. If this parameter is omitted, the script will perform a non-dictionary analysis.

## Example
```powershell
.\AD_Analysis.ps1 -DC "DC-2022" -Domain "DC=HMO,DC=LAB"
```
Performs a non-dictionary audit.

```powershell
.\AD_Analysis.ps1 -DC "DC-2022" -Domain "DC=HMO,DC=LAB" -DictionaryPath "C:\\temp\\dictionary.txt"
```
Performs a dictionary audit.

## Note
This script must be run as an administrator.

## Disclaimer
Please use this script responsibly. Always test scripts in a controlled environment before deploying them in production. The author of this script bears no responsibility for any issues or damages caused by the use of this script.

I hope you find this script useful. If you have any questions or need further assistance, feel free to reach out. 😊
