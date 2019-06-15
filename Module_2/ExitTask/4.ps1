<# 4.	Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно).
 Перечень имен компьютеров должен браться из текстового файла. 
 Вывод организовать следующим образом: Имя компьютера – статус 
 (если служба запущена, то строка зелёная, иначе красная)
#>
$comp = Get-Content -Path c:\temp\comps.txt
Get-Service WSearch -ComputerName $comp |
    ForEach-Object {if ($_.status -like 'Running') `
        {Write-host $_.displayname is $_.status -ForegroundColor green} `
        else {Write-Host Service $_.name is $_.status -ForegroundColor red}}

Get-Service WSearch -ComputerName $comp
