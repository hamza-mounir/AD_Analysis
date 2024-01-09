<#
.SYNOPSIS
This script performs a password quality audit in an Active Directory.

.DESCRIPTION
The script retrieves all accounts from the specified Active Directory and tests the quality of their passwords. 
If a path to a dictionary file is provided, the script will perform a dictionary analysis. 
Otherwise, it will perform a non-dictionary analysis.

.PARAMETER DC
The name of your Active Directory server.

.PARAMETER Domain
Your Active Directory naming context.

.PARAMETER DictionaryPath
The path to your dictionary file. If this parameter is omitted, the script will perform a non-dictionary analysis.

.PARAMETER Help
Displays a help message.

.EXAMPLE
.\AD_Analysis.ps1 -DC "DC-2022" -Domain "DC=HMO,DC=LAB"
Performs a non-dictionary audit.

.EXAMPLE
.\AD_Analysis.ps1 -DC "DC-2022" -Domain "DC=HMO,DC=LAB" -DictionaryPath "C:\\temp\\dictionary.txt"
Performs a dictionary audit.
#>

param (
    [string]$DC,
    [string]$Domain,
    [string]$DictionaryPath,
    [switch]$Help
)

if ($Help) {
    Write-Host @"
Usage example :
.\AD_Analysis.ps1 -DC "DC-2022" -Domain "DC=HMO,DC=LAB"
Performs a non-dictionary audit.

.\AD_Analysis.ps1 -DC "DC-2022" -Domain "DC=HMO,DC=LAB" -DictionaryPath "C:\\temp\\dictionary.txt"
Performs a dictionary audit.
"@
    exit
}

# Check if the DC and Domain are specified
if (-not $DC -or -not $Domain) {
    Write-Host "Please specify both the DC and the Domain. Example: .\AD_Analysis.ps1 -DC 'DC-2022' -Domain 'DC=HMO,DC=LAB'"
    exit
}

# Check if the DC is accessible
if (-not (Test-Connection -ComputerName $DC -Count 1 -Quiet)) {
    Write-Host "The server $DC is not accessible. Please check the server name."
    exit
}

# Check if the dictionary file exists
if ($DictionaryPath -and -not (Test-Path -Path $DictionaryPath)) {
    Write-Host "The dictionary file $DictionaryPath does not exist. Please check the file path."
    exit
}

try {
    # Audit with or without dictionary
    $accounts = Get-ADReplAccount -All -Server $DC -NamingContext $Domain
    if ($accounts) {
        if ($DictionaryPath) {
            $accounts | Test-PasswordQuality -IncludeDisabledAccounts -WeakPasswordsFile $DictionaryPath
        } else {
            $accounts | Test-PasswordQuality -IncludeDisabledAccounts
        }
    } else {
        Write-Host "No accounts found in the specified Active Directory."
    }
} catch {
    Write-Host "An error occurred while running the script: $_"
}
