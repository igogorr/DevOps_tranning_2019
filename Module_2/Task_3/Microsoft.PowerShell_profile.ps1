<#

Frofile file

#>
function prompt
{
'MyShell - >'
}
Set-location c:\
Get-Alias get_date1 get-Date
Get-Alias get_process1 Get-Process
New-Variable a -Value 1100
 (Get-Host).UI.RawUI.ForegroundColor = 'green'
 (Get-Host).UI.RawUI.BackgroundColor = 'black'
 (Get-Host).UI.RawUI.CursorSize = 14
Clear-Host



Get-Module -ListAvailable
