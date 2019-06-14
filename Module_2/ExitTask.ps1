
<#1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. 
Результат представить в виде файла XML.
#>
$date = Get-Date
$a = Read-Host 'Enter count of day'
Get-EventLog System -EntryType error -Before $date.AddDays(-$a) | export-clixml –path c:\Temp\EventLog.xml

<#2.	Вывести список файлов *.log хранящихся в папке C:\Windows. 
Вывод организовать в виде таблицы с обратной сортировкой по имени файла, 
при этом выводить полное имя файла, размер файла, время создания. 
#>
Get-ChildItem -Path C:\Windows -Recurse -Filter *.log | Format-Table -Property Name, Length, CreationTime

<# 3.	Создать файл-сценарий вывода всех чисел делящихся без остатка на 3, на интервале от А до В,
 где А и В — входные параметры, параметр А по умолчанию равен 0, параметр В обязателен для ввода.
#>
$a=0
$b=Read-Host "Enter a value"
$i=1
for ($i -gt $a; $i -le $b) {
    if (($i % 3) -eq 0){
    Write-Output $i
    }
    else {
    }
    $i++
}

<# 4.	Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно).
 Перечень имен компьютеров должен браться из текстового файла. 
 Вывод организовать следующим образом: Имя компьютера – статус 
 (если служба запущена, то строка зелёная, иначе красная)
#>
$comp = Get-Content -Path c:\temp\comps.txt
Get-Service WSearch -ComputerName $comp | ForEach-Object {if ($_.status -like 'Running') {Write-Host Service $_.displayname is $_.status -ForegroundColor green} else {Write-Host Service $_.name is $_.status -ForegroundColor red}}

<# 5.	Все файлы из прилагаемого архива перенести в одну папку, не содержащую подпапок. 
Имя каждого файла изменить, добавив в его начало имя родительской папки и время переноса файла. 
В конце выдать отчёт о количестве файлов и общем размере перенесённых файлов. 

#>