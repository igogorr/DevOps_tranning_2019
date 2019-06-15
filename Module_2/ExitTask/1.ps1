<#1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. 
Результат представить в виде файла XML.
#>
$date = Get-Date
$a = Read-Host 'Enter count of days'
Get-EventLog System -EntryType error -Before $date.AddDays(-$a) | export-clixml –path c:\Temp\EventLog.xml
