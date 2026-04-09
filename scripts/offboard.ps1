# offboard.ps1 - User Offboarding Script
# Usage: .\offboard.ps1 -Username "m.muster"

param(
    [Parameter(Mandatory=$true)] [string]$Username
)

$DisabledOU = "OU=Lab-Disabled,DC=lab,DC=local"

Disable-ADAccount -Identity $Username
Write-Host "Account $Username deaktiviert" -ForegroundColor Yellow

$User = Get-ADUser -Identity $Username -Properties MemberOf
foreach ($Group in $User.MemberOf) {
    Remove-ADGroupMember -Identity $Group -Members $Username -Confirm:$false
}
Write-Host "Aus allen Gruppen entfernt" -ForegroundColor Yellow

Move-ADObject -Identity $User.DistinguishedName -TargetPath $DisabledOU
Write-Host "Account verschoben nach Lab-Disabled" -ForegroundColor Green
Write-Host "Offboarding von $Username abgeschlossen" -ForegroundColor Green
