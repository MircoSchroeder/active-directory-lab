# onboard.ps1 - User Onboarding Script
# Usage: .\onboard.ps1 -FirstName "Max" -LastName "Muster" -Department "IT"

param(
    [Parameter(Mandatory=$true)] [string]$FirstName,
    [Parameter(Mandatory=$true)] [string]$LastName,
    [Parameter(Mandatory=$true)] [ValidateSet("IT","HR","Management")] [string]$Department
)

$Username = "$($FirstName.Substring(0,1).ToLower()).$($LastName.ToLower())"
$UPN = "$Username@lab.local"
$OU = "OU=$Department,OU=Lab-Users,DC=lab,DC=local"
$Password = ConvertTo-SecureString "Welcome2024!#" -AsPlainText -Force

New-ADUser -Name "$FirstName $LastName" -GivenName $FirstName -Surname $LastName -SamAccountName $Username -UserPrincipalName $UPN -Path $OU -AccountPassword $Password -Enabled $true

Write-Host "1. User $Username erstellt in OU=$Department" -ForegroundColor Green
Write-Host "2. UPN: $UPN" -ForegroundColor Green
Write-Host "3. Passwort: Welcome2024!# (muss bei erstem Login geaendert werden)" -ForegroundColor Yellow
