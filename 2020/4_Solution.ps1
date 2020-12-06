# Day 4
$InputRaw = Get-Content ".\4_input.txt"

#byr (Birth Year)
#iyr (Issue Year)
#eyr (Expiration Year)
#hgt (Height)
#hcl (Hair Color)
#ecl (Eye Color)
#pid (Passport ID)
#cid (Country ID)
$FieldsList = @('byr','iyr','eyr','hgt','hcl','ecl','pid')

$InputAligned = $InputRaw.Replace(' ',"`r`n")
$InputAligned | Out-File ".\4_input_parsed5.txt"
$InputAligned = Get-Content ".\4_input_parsed5.txt"
$DoA =  $True

if($DoA) {
    # Part 1
    $ValidLines = 0
    $ValidPassport = 0
    $CIDSeen = $false

    $reader = [System.IO.File]::OpenText("C:\Scripts\AdventOfCode\4_input_parsed5.txt")

    while($null -ne ($line = $reader.ReadLine())) {
        $ValidLines += 1
        if($line -match 'cid') { $CIDSeen = $true }
        elseif($line -eq '') { 
            $ValidLines -= 1
            if($ValidLines -eq 7 -and $CIDSeen -eq $false) { $ValidPassport += 1 }
            elseif($ValidLines -eq 8 -and $CIDSeen -eq $true) { $ValidPassport += 1 }
            $ValidLines = 0
            $CIDSeen = $false
        }
    }

    # Do last entry
    if($ValidLines -eq 7 -and $CIDSeen -eq $false) { $ValidPassport += 1 }
    elseif($ValidLines -eq 8 -and $CIDSeen -eq $true) { $ValidPassport += 1 }
    
    $reader.Close()
    write-host "Found $ValidPassport Valid passports"
}

#Part 2
$reader = [System.IO.File]::OpenText("C:\Scripts\AdventOfCode\4_input_parsed5.txt")
$CIDSeen = $false
$ValidPassport = 0
$ValidLines = 0
while($null -ne ($line = $reader.ReadLine())) {
    #$ValidLines += 1
    
    if($line -match 'cid') { $ValidLines += 1
                             $CIDSeen = $true
    } elseif($line -eq '') { 
        if($ValidLines -eq 7 -and $CIDSeen -eq $false) { $ValidPassport += 1 }
        elseif($ValidLines -eq 8 -and $CIDSeen -eq $true) { $ValidPassport += 1 }
        $CIDSeen = $false
        $ValidLines = 0
    } else {
        $linearray = $line.split(':')

        #byr (Birth Year) - four digits; at least 1920 and at most 2002.
        #iyr (Issue Year) - four digits; at least 2010 and at most 2020.
        #eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
        #hgt (Height) - a number followed by either cm or in:
        #    If cm, the number must be at least 150 and at most 193.
        #    If in, the number must be at least 59 and at most 76.
        #hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        #ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        #pid (Passport ID) - a nine-digit number, including leading zeroes.
        #cid (Country ID) - ignored, missing or not.

        switch($linearray[0]){
           'byr' {if($linearray[1] -ge 1920 -and $linearray[1] -le 2002) { $ValidLines += 1 } }
           'iyr' {if($linearray[1] -ge 2010 -and $linearray[1] -le 2020) { $ValidLines += 1 } }
           'eyr' {if($linearray[1] -ge 2020 -and $linearray[1] -le 2030) { $ValidLines += 1 } }
           'hgt' {  if($linearray[1] -match 'in') {
                       $linearray[1] = $linearray[1].replace('in','')
                       if($linearray[1] -ge 59 -and $linearray[1] -le 76) { $ValidLines += 1}
                    }elseif($linearray[1] -match 'cm') {
                       $linearray[1] = $linearray[1].replace('cm','')
                       if($linearray[1] -ge 150 -and $linearray[1] -le 193) { $ValidLines += 1}
                    }
                 }
           'hcl' {if($linearray[1][0] -eq '#') {
                    $linearray[1] = $linearray[1].replace('#','')
                    if($linearray[1] -match '([a-f0-9]){6}') { $ValidLines += 1}
                  }
                 }
           'ecl' {if($linearray[1] -in @('amb','blu','brn','gry','grn','hzl','oth')) { $ValidLines += 1} }
           'pid' {if($linearray[1] -match '([0-9]){9}') { $ValidLines += 1} }
        }
    }

}

$reader.Close()
write-host "Found $ValidPassport Valid passports"
