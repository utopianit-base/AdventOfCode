# Day 1
$InputRaw = Get-Content ".\1_input.txt"

[int[]]$InputINT = $InputRaw
$InputList = $InputINT | Sort

$InputOne   = $InputList
$InputTwo   = $InputList
$InputThree = $InputList

$MagicNumber = 2020
$Done        = $False

ForEach($NumberOne in $InputOne) {
    ForEach($NumberTwo in $InputTwo) {
        #write-host "$NumberOne + $NumberTwo = $([int]$NumberOne + [int]$NumberTwo)"
        $Sum = [int]$NumberOne + [int]$NumberTwo

        if($Sum -gt $MagicNumber) {
                break
        }elseif($Sum -eq $MagicNumber) {
            write-host "$NumberOne + $NumberTwo = $MagicNumber"
            write-host "$NumberOne x $NumberTwo = " -NoNewline
            write-host "$([int]$NumberOne * [int]$NumberTwo)" -ForegroundColor Green
            $Done = $true
            break
        }

        if($Done) {
            break
        }
    }
}

$Done = $False
ForEach($NumberOne in $InputOne) {
    ForEach($NumberTwo in $InputTwo) {
        ForEach($NumberThree in $InputTwo) {
            #write-host "$NumberOne + $NumberTwo + $NumberThree = $([int]$NumberOne + [int]$NumberTwo + [int]$NumberThree)"
            $Sum = [int]$NumberOne + [int]$NumberTwo + [int]$NumberThree
            if($Sum -gt $MagicNumber) {
                break
            } elseif($Sum -eq $MagicNumber) {
                write-host "$NumberOne + $NumberTwo + $NumberThree = $MagicNumber"
                write-host "$NumberOne x $NumberTwo x $NumberThree = " -NoNewline
                write-host "$([int]$NumberOne * [int]$NumberTwo * [int]$NumberThree)" -ForegroundColor Green
                $Done = $True
                break
            }
        }
        if($Done) {
            break
        }
    }
    if($Done) {
        break
    }
}


