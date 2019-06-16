<# 5.	Все файлы из прилагаемого архива перенести в одну папку, не содержащую подпапок. 
Имя каждого файла изменить, добавив в его начало имя родительской папки и время переноса файла. 
В конце выдать отчёт о количестве файлов и общем размере перенесённых файлов. 
#>
$SourceFile = 'C:\Temp\Archive.zip'
$DescFolder = 'C:\Temp\'

# Expand-Archive -Path $SourceFile -DestinationPath $DescFolder
    If (Test-Path -Path $DescFolder\Archive){
        Write-Output 'Archive is exist. Exit'
        break
    }
    else{
        Write-Output 'New archive is creating'
        Expand-Archive -Path $SourceFile -DestinationPath $DescFolder
        Get-ChildItem -Path $DescFolder -Recurse -File | 
        Rename-Item -NewName {$_.Directory.Name + "-" + $(get-date -f dd-mm-yy) + "-" + $_.Name}
    }
$sum = Get-ChildItem -Path $DescFolder -Recurse -File | Measure-Object Length -Sum
Write-Host "Count of Files - " -NoNewline $sum.Count
Write-host "Size of ALL files in folder $DescFolder - " -NoNewline ("{0:N2} KB" -f (($sum.Sum)/1KB))

