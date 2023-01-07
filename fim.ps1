 <#Write-Host "What would you like to do?"
Write-host "A) "
Write-host "B)"#>

$res = Read-Host -Prompt "Enter 'A' to collect new Baseline or 'B' to  monitor an existing Baseline"

Write-Host ""

Function Calculate-Hash($filepath) {
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
        return $filehash
}

Function Remove-Existing-Baseline() {
    $baselineExists = Test-Path -Path .\baseline.txt

    if($baselineExists){
        Remove-Item -Path .\baseline.txt
    }
}



if($res -eq "A".ToUpper()) {

    Remove-Existing-Baseline

#Collect files from target folder

    $files = Get-ChildItem -Path .\Files

    foreach($f in $files){
        $hash = Calculate-File-Hash $f.FullName 
        "$($hash.Path)|$($hash.Hash)" | Out-File .\baseline.txt -Append
     }

}

elseif($res -eq "B".ToUpper()) {

#if user selects B collect paths and hashes from baseline text file and store in a dictionary
    $fileHashTable = @{}

    $fileHashes = Get-Content -Path .\baseline.txt

    foreach($f in $fileHashes) {
        $fileHashTable.add($f.Split("|")[0],$f.Split("|")[1])
    }

    #CREATE A CONTINUOUS LOOP THAT COLLECTS AND CALCULATE THE HASH OF EACH TEXT FILE

    while($true) {

        Start-Sleep -Seconds 1

        $files = Get-ChildItem -Path .\Files

        foreach($f in $files){
            $hash = Calculate-File-Hash $f.FullName 

            if($fileHashTable[$hash.Path] -eq $null) {
                Write-Host "$($hash.Path) has been created!"
            } 
            else {

                if($fileHashTable[$hash.Path] -eq $hash.Hash){
                #Nothing Has Changed!
                }
                     
                else {Write-Host "File has been changed!"}

                }
       }

       foreach($key in $fileHashTable.Keys){

        $fileexists = Test-Path -Path $key

        if(-Not $fileexists){
            Write-Host "File has been deleted!"
        }

}

  }

}

<# 

#>



<#

#> 
