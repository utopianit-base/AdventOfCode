# Day 2
$InputRaw = Get-Content ".\2_input.txt"

$CorrectPasswordsA = 0
$CorrectPasswordsB = 0

ForEach($InputLine in $InputRaw) {
    # 9-10 x: pxcbpxxwkqjttx
    $LineArray = $InputLine.split(':')
    $PolicyArray = $LineArray[0].split(' ')
    
    $Password = $LineArray[1].Trim()
    $RangeArray = $PolicyArray[0].split('-')
    $Letter = $PolicyArray[1]
    
    # 2A
    $LetterCount = $Password.split($Letter).count -1
    
    if($LetterCount -ge $RangeArray[0] -and $LetterCount -le $RangeArray[1]) {
        $CorrectPasswordsA +=1
        write-host "A. $Password contains between $($RangeArray[0])-$($RangeArray[1]) ($LetterCount) instances of $Letter" -ForegroundColor Green
    } else {
        write-host "A. $Password DOES NOT contain between $($RangeArray[0])-$($RangeArray[1]) instances of $Letter" -ForegroundColor Yellow
    }

    # 2B
    if( ( ($Password[$RangeArray[0]-1] -eq $Letter) -xor ($Password[$RangeArray[1]-1] -eq $Letter)) ) {
        $CorrectPasswordsB +=1
        write-host "B. $Password meets policy as ONLY one letter $($RangeArray[0]) or $($RangeArray[1]) is a $Letter ($($Password[$RangeArray[0]-1])$($Password[$RangeArray[1]-1]))" -ForegroundColor Green
    } else {
        write-host "B. $Password DOES NOT meet policy as letter $($RangeArray[0]) or (and only or) $($RangeArray[1]) are not $Letter ($($Password[$RangeArray[0]-1])$($Password[$RangeArray[1]-1]))" -ForegroundColor Yellow
    }
}

write-host "#2A - Found $CorrectPasswordsA Correct Passwords"

write-host "#2B - Found $CorrectPasswordsB Correct Passwords"

#$Password = 'wlqzllcljjtqglbhl'
#$RangeArray = @(11,14)
#$Letter = 'l'