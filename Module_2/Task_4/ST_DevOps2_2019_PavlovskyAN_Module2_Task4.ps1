
# 1.	Вывести список всех классов WMI на локальном компьютере. 
Get-WmiObject -List
# 2.	Получить список всех пространств имён классов WMI. 
Get-WmiObject -Namespace root -ClassName __namespace | ft name
# 3.	Получить список классов работы с принтером.
Get-WmiObject -List | Where-Object {$_.name -match "Printer"}
# 4.	Вывести информацию об операционной системе, не менее 10 полей.
Get-WmiObject Win32_OperatingSystem | Select-Object -Property PSComputerName,Caption,Version,OSArchitecture, SerialNumber, Organization, MUILanguages | fl
# 5.	Получить информацию о BIOS.
Get-WmiObject win32_bios
# 6.	Вывести свободное место на локальных дисках. На каждом и сумму.
Get-WmiObject Win32_LogicalDisk | Select-Object deviceid,size,freespace | fl
# 7.	Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.
Get-WmiObject Win32_PingStatus -Filter "address='127.0.0.1'" | Select-Object -Property address,responsetime
# 8.	Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.
Get-WmiObject Win32_InstalledWin32Program | Select-Object vendor, version | ft
# 9.	Выводить сообщение при каждом запуске приложения MS Word.
Register-WMIEvent -Query "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process' AND TargetInstance.Name = 'winword.exe'"  -sourceIdentifier 'MSWordStarted' -action {Write-Host 'Application MS WORD is running'}