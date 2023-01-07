
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



    $files = Get-ChildItem -Path .\Files

    foreach($f in $files){
        $hash = Calculate-File-Hash $f.FullName 
        "$($hash.Path)|$($hash.Hash)" | Out-File .\baseline.txt -Append
     }

}

elseif($res -eq "B".ToUpper()) {

    $fileHashTable = @{}

    $fileHashes = Get-Content -Path .\baseline.txt

    foreach($f in $fileHashes) {
        $fileHashTable.add($f.Split("|")[0],$f.Split("|")[1])
    }


    while($true) {

        Start-Sleep -Seconds 1

        $files = Get-ChildItem -Path .\Files

        foreach($f in $files){
            $hash = Calculate-File-Hash $f.FullName 

            if(-Not $fileHashTable[$hash.Path]) {
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

