<#2.	Вывести список файлов *.log хранящихся в папке C:\Windows. 
Вывод организовать в виде таблицы с обратной сортировкой по имени файла, 
при этом выводить полное имя файла, размер файла, время создания. 
#>
Get-ChildItem -Path C:\Windows -Filter *.log | Sort-Object name -Descending | Format-Table -Property Name, Length, CreationTime
