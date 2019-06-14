# 1.	Для каждого пункта написать и выполнить соответсвующий скрипт автоматизации администрирования:
# 1.1.	Вывести все IP адреса вашего компьютера (всех сетевых интерфейсов)
Get-WmiObject -Class win32_networkadapterconfiguration -filter IPenabled=True | 
Select-Object -Property description, ipaddress, ipsubnet
# 1.2.	Получить mac-адреса всех сетевых устройств вашего компьютера.
Get-WmiObject -Class win32_networkadapterconfiguration -filter IPenabled=True | 
Select-Object -Property description, macaddress
# 1.3.	На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -filter IPEnabled=true -ComputerName 10.2.2.1 |
 ForEach-Object -Process {$_.InvokeMethod("EnableDHCP", $null)}
# 1.4.	Расшарить папку на компьютере
New-SmbShare -Name 'SharedFolder' -path 'c:\Temp\SharedFolder' -ContinuouslyAvailable -FullAccess 'home\Administrator' -ReadAccess 'home\GuestUsers'
# 1.5.	Удалить шару из п.1.4
Remove-SmbShare -Name SharedFolder -Force
# 1.6.	Скрипт входными параметрами которого являются Маска подсети и два ip-адреса. Результат  – сообщение (ответ) в одной ли подсети эти адреса.
$ip1 = [ipaddress] '192.168.1.1'
$mask1 = [ipaddress] '255.255.255.0'
$networkID1 = [ipaddress]($ip1.Address -band $mask1.Address)

$ip2 = [ipaddress] '192.168.1.100'
$mask2 = [ipaddress] '255.255.255.0'
$networkID2 = [ipaddress]($ip2.Address -band $mask2.Address)

if ($networkID1.Address -eq $networkID2.Address){
Write-Output 'Addresses in one subnet'
}
else{
Write-Output 'Addresses in different subnets'
}
# 2.	Работа с Hyper-V
# 2.1.	Получить список коммандлетов работы с Hyper-V (Module Hyper-V)
Get-Command -Module Hyper-V
# 2.2.	Получить список виртуальных машин 
Get-VM | Format-List
<#
Name          State   CPUUsage(%) MemoryAssigned(M) Uptime           Status             Version
----          -----   ----------- ----------------- ------           ------             -------
pavlovsky_vm1 Running 0           2048              01:08:27.8810000 Operating normally 8.0
pavlovsky_vm2 Running 0           2048              01:08:08.1390000 Operating normally 8.0
pavlovsky_vm4 Off     0           0                 00:00:00         Operating normally 8.0
#>
# 2.3.	Получить состояние имеющихся виртуальных машин
Get-VM | Select-Object Name, State
<#
Name            State
----            -----
pavlovsky_vm1 Running
pavlovsky_vm2 Running
pavlovsky_vm4     Off
#>
# 2.4.	Выключить виртуальную машину
Get-VM -Name pavlovsky_vm2 | Stop-VM 
<#
Get-VM -Name pavlovsky_vm2
Name          State CPUUsage(%) MemoryAssigned(M) Uptime   Status             Version
----          ----- ----------- ----------------- ------   ------             -------
pavlovsky_vm2 Off   0           0                 00:00:00 Operating normally 8.0
#>
# 2.5.	Создать новую виртуальную машину
New-vm -Name TestVM -Generation 2 -Path 'C:\Temp\Vms' -MemoryStartupBytes 2GB -NewVHDPath 'C:\Temp\VHD' -NewVHDSizeBytes 64GB -SwitchName 'InternalSwitch'
# 2.6.	Создать динамический жесткий диск
New-VHD -Path 'C:\Temp\VHD\test.vhdx' -SizeBytes 64GB -Dynamic
<#
ComputerName            : homePC
Path                    : C:\Temp\VHD\test.vhdx
VhdFormat               : VHDX
VhdType                 : Dynamic
FileSize                : 4194304
Size                    : 68719476736
MinimumSize             :
LogicalSectorSize       : 512
PhysicalSectorSize      : 4096
BlockSize               : 33554432
ParentPath              :
DiskIdentifier          : 7514BCAC-A50C-4FEB-A4FD-19BD83BA590A
FragmentationPercentage : 0
Alignment               : 1
Attached                : False
DiskNumber              :
Number                  :
#>
# 2.7.	Удалить созданную виртуальную машину
Get-VM -Name TestVM | Remove-VM