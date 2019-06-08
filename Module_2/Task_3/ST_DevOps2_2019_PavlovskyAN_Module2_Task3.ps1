<# 1.1
Сохранить в текстовый файл на диске список запущенных(!) служб. 
Просмотреть содержимое диска. 
Вывести содержимое файла в консоль PS.
#>
function module2_task3_1_1
{
Param (
  [parameter(Mandatory=$true, HelpMessage="Enter name of output .txt file")]
  [string]$SavedFile = $(Throw "Enter name, for Example, $home\Documents\1.txt"),
  [parameter(Mandatory=$true, HelpMessage="Enter Disc Letter")]
  [ValidateLength(1,1)][string]$OutputDisc = $(Throw "Enter one Disc letter, for Example, C:"),
  [parameter(Mandatory=$true, HelpMessage="File name")]
  [string]$OutputFile = $(Throw "Enter name, for Example, $home\Documents\1.txt")
)
Write-Host ('Task 1.1.1 ' + '-' * 20)
Get-Service > $SavedFile
Write-Host ('Task 1.1.2 ' + '-' * 20)
Get-ChildItem $OutputDisc
Write-Host ('Task 1.1.3 ' + '-' * 20)
$test_path = Test-Path -Path $OutputFile
if ($test_path = $True)
{
Get-Content -Path $OutputFile
}
else
{
Write-host "File $OutputFile doesn't exist"
}
}
module2_task3_1_1

# 1.2. Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)
function module2_task3_1_2
{
$summ = 0
Get-Variable | ForEach-Object {
if (($PSitem.Name -ne "null") -and ($PSItem.Value.GetType() -eq [int32]))
{
$summ+=$PSitem.Value
} 
else 
{
}
}
$summ
}
module2_task3_1_2

# 1.3.	Вывести список из 10 процессов занимающих дольше всего процессор.
<# 
Содержимое файла C:\Temp\Get-top10-processes.ps1
Get-Process | Sort-Object CPU -Descending | select-object -first 10 | Out-File c:\Temp\result.txt
#>
$Trigger = New-ScheduledTaskTrigger -Once -At "06/08/2019 23:39:00" -RepetitionInterval (New-TimeSpan -Minutes 10)
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\Temp\Get-top10-processes.ps1"
Register-ScheduledTask -TaskName "Get_top10-Processes" -Trigger $Trigger -Action $Action -RunLevel Highest –Force

# 1.4.	Подсчитать размер занимаемый файлами в папке (например C:\windows) за исключением файлов с заданным расширением (например .tmp)

function module2_task3_1_4
{
Param (
  [parameter(Mandatory=$true, HelpMessage="Enter Folder name, for example, c:\windows")]
  [string]$Folder = "c:\windows"
)
"{0:N2} Gb" -f ((Get-ChildItem –force $Folder –Recurse -ErrorAction SilentlyContinue -Exclude *.tmp | Measure-Object Length -Sum).sum / 1Gb) 
}
module2_task3_1_4 -Folder C:\Windows

<# 
1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.
1.5.2.	Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла и вывести в виде списка  разным разными цветами
#>
$1_5_1 = Get-HotFix | Export-Csv C:\temp\update_list.csv
$1_5_2 = Get-ChildItem HKLM:\SOFTWARE\Microsoft\ | Export-Clixml C:\temp\HKLM.xml

$result_1_5_1 = Import-Csv -Path C:\temp\update_list.csv | Format-List
$result_1_5_2 = Import-Clixml C:\temp\Folder1\history.xml | Select-Object -Property id, commandline, ExecutionStatus, StartExecutionTime, EndExecutionTime | Format-List

function module2_task3_1_5
{
Write-Host $result_1_5_1 -ForegroundColor Green
Write-Host $result_1_5_2 -ForegroundColor Yellow
}
