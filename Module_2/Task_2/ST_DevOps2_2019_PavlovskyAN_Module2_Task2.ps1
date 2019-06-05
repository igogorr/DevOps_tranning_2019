<#
EPAM Systems, RDDep.


MTN.Win.02
Автоматизация администрирования с PowerShell 2.0
Конвейеризация, вывод. Использование поставщиков и дисков





 #>
#Задание 2

# 1.	Просмотреть содержимое ветви реeстра HKCU
Get-ChildItem HKCU:
# 2.	Создать, переименовать, удалить каталог на локальном диске
New-Item -Name Folder -Type Directory -Path C:\Temp\\
Rename-Item -Path C:\Temp\Folder -NewName Folder1
Remove-Item -Path C:\Temp\Folder
# 3.	Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
New-Item -Name Folder -Type Directory -Path ‘C:\M2T2_PavlovskyAN\’
New-PSDrive -Name "MyTestDrive" -Root ‘C:\M2T2_PavlovskyAN\’ -PSProvider "FileSystem"
# 4.	Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
Get-Service | Out-File 'MyTestDrive:\1.txt'
Get-ChildItem MyTestDrive:
Get-Content MyTestDrive:\1.txt
# 5.	Просуммировать все числовые значения переменных текущего сеанса.
$res=Get-Variable | Where-Object -FilterScript {$_.Value.GetType() -like 'int*'}
$res | foreach {$summ += $_.value}
$summ
# 6.	Вывести список из 6 процессов занимающих дольше всего процессор.
Get-Process | Sort-Object CPU -Descending | select-object -first 6
# 7.	Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
Get-Process | ForEach-Object {if ($($_.VM/1Mb) -gt 100) {Write-Host ($_.name, ("{0:N2}" -f $($_.VM/1Mb))) -separator " - " -ForegroundColor red} else {Write-Host ($_.name, ("{0:N2}" -f $($_.VM/1Mb))) -separator " - " -ForegroundColor green}}
# 8.	Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp
"{0:N2} Gb" -f ((Get-ChildItem –force c:\Windows –Recurse -ErrorAction SilentlyContinue -Exclude *.tmp | Measure-Object Length -Sum).sum / 1Gb) 
# 9.	Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.
Get-ChildItem HKLM:\SOFTWARE\Microsoft\ | Export-Csv C:\temp\Folder1\hklm.csv
# 10.	Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
Get-History | Export-Clixml C:\temp\Folder1\history.xml
# 11.	Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
Import-Clixml C:\temp\Folder1\history.xml | Select-Object -Property id, commandline, ExecutionStatus, StartExecutionTime, EndExecutionTime
# 12.	Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
Remove-PSDrive -Name Mypsdrive -PSProvider "FileSystem" -Force
Remove-Item -Path C:\temp\Folder\ -Force