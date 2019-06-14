<# В задании используются виртуальные машины созданные в предыдущих модулях. #>

# 1.	При помощи WMI перезагрузить все виртуальные машины.
Get-WmiObject -Class Win32_operatingsystem -Credential $cred -ComputerName 10.2.2.1,10.2.2.3 | Invoke-WmiMethod -Name Reboot
# 2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 
$cred = Get-Credential home\Administrator
Get-WmiObject win32_service -ComputerName 10.2.2.1 -Credential $cred |
 Where-Object {$_.state -eq 'Running'} | Format-Table -Property Name, State, Status
# 3.	Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.
Enable-PSRemoting
# 4.	Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.
Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpListener $true
Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpsListener $true
Set-Item WSMan:\localhost\listener\listener*\port -Value 42658
Enter-PSSession 10.2.2.1 -Port 42658
# 5	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.
New-PSSessionConfigurationFile -Path c:\Temp\TestSessionConfiguration.pssc -VisibleCmdlets Get-ChildItem,Exit-PSSession
# ТЕстируем файл конфигурации
Test-PSSessionConfigurationFile c:\Temp\TestSessionConfiguration.pssc
# Регистрируем файл конфигурации
Register-PSSessionConfiguration -Name TestSessionConfiguration -Path c:\Temp\TestSessionConfiguration.pssc -RunAsCredential
# Проверяем подключение, с помощью файла конфигурации
New-PSSession -ComputerName 10.2.2.1 -ConfigurationName TestSessionConfiguration 