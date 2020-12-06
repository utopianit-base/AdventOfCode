#Part 1
$DoA = $true
if($DoA) {
    $reader = [System.IO.File]::OpenText("C:\Scripts\AdventOfCode\6_input.txt")
    $GroupSum = 0
    $Group = ''
    $GroupArray = @()
    $AllGroupArray = @()

    while($null -ne ($line = $reader.ReadLine())) {
        if($line -ne '') {
            $Group += $line.Trim()
        } else {
            $AllGroupArray += $Group
            For($n=0; $n -lt $Group.Length; $n++) { $GroupArray += $Group[$n] }
            $GroupCount = $($GroupArray | Select -Unique).Count
            #write-host "Found $GroupCount Unique answers in $Group"
            $Group = ''
            $GroupSum += $GroupCount
            $GroupArray = @()
        }
    }
    # Do the last one
    For($n=0; $n -lt $Group.Length; $n++) { $GroupArray += $Group[$n] }
    $GroupCount = $($GroupArray | Select -Unique).Count
    #write-host "Found $GroupCount Unique answers in $Group"
    $Group = ''
    $GroupSum += $GroupCount
    $GroupArray = @()
    write-host "PART 1: Total Sum is $GroupSum"
    $reader.Close()
}
# Part 2
$GroupSum = 0
$Group = ''
[string[]]$GroupArray = @()
$Members = 0
$reader = [System.IO.File]::OpenText("C:\Scripts\AdventOfCode\6_input.txt")

while($null -ne ($line = $reader.ReadLine())) {
    if($line -ne '') {
        $Group += $line.Trim()
        $Members += 1
    } else {
        For($n=0; $n -lt $Group.Length; $n++) { [string[]]$GroupArray += $Group[$n] }
        $SortedGroupArray = $($GroupArray | Sort)
        $SortedGroup = ''
        ForEach($Letter in $SortedGroupArray) { $SortedGroup += $Letter}
        # Look for $Members instances of any character in $SortedGroup
        $RegEx = "(.)\1{$($Members-1)}"
        $matches = ([regex]$RegEx).Matches($SortedGroup)
        $GroupSum += $matches.Count
        #write-host "Found $($matches.Count) questions answered by all members in group ($Group => $SortedGroup)"
        $Members = 0
        $Group = ''
        $GroupArray = @()
    }
}

For($n=0; $n -lt $Group.Length; $n++) { [string[]]$GroupArray += $Group[$n] }
$SortedGroupArray = $($GroupArray | Sort)
$SortedGroup = ''
ForEach($Letter in $SortedGroupArray) { $SortedGroup += $Letter}
# Look for $Members instances of any character in $SortedGroup
$RegEx = "(.)\1{$($Members-1)}"
$matches = ([regex]$RegEx).Matches($SortedGroup)
$GroupSum += $matches.Count
#write-host "Found $($matches.Count) questions answered by all members in group ($Group)"
$Members = 0
$Group = ''

write-host "PART 2: Total Sum is $GroupSum"