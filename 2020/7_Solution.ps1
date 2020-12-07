#Part 1
$reader = [System.IO.File]::OpenText("C:\Scripts\AdventOfCode\7_input.txt")
$isDone = $false
$MyBag = 'shiny gold'
$DoA = $false

function Add-Bag($Outer,$Inner,$Number)
{
    [PSCustomObject]$SetItem = @{}
    $SetItem.Add('Outer',$Outer)
    $SetItem.Add('Inner',$Inner)
    $SetItem.Add('Number',$Number)
    return New-Object -TypeName psobject -Property $SetItem
}

function Find-AllOuter($inner,$level=0) {

    $Bags = $BagNesting | Where Inner -eq $inner
    if(-not $Bags) { Return @() }
    #$Bags
    $GLOBAL:MoreBags += $Bags
    $level += 1
    ForEach($Bag in $Bags) {
        Find-AllOuter -Inner $Bag.outer -level $level
    }
}

function Find-AllInner($outer,$count=1) {
    $Bags = $BagNesting | Where Outer -eq $outer
    if(-not $Bags) { Return 0 }
    $GLOBAL:MoreBags += $Bags
    ForEach($Bag in $Bags) {
        if($Bag.Number -gt 0) {
            $GLOBAL:NestBagsCount += $([int]$Bag.Number * [int]$count)
            write-host " - $($Bag.Outer) contains $($Bag.Number) x $($Bag.Inner) => $($Bag.Number) * $count [$($GLOBAL:NestBagsCount)]" -ForegroundColor Gray
            Find-AllInner -Outer $Bag.inner -count $([int]$Bag.Number * [int]$count)
        } else {
            write-host " - $($Bag.Outer) contains no other bags => [$($GLOBAL:NestBagsCount)]"  -ForegroundColor Gray
        }
    }
}

# Before:
#striped green bags contain 5 posh indigo bags.
#light yellow bags contain 3 wavy turquoise bags.
#
# After:
#striped green,5 posh indigo
#light yellow,3 wavy turquoise
#
# Parsed as:
#Outer             Number     Inner
#striped green     5          posh indigo
#light yellow      3          wavy turquoise
#

# Read Input to Array
$BagNesting = @()
write-host "Processing Input File..." -ForegroundColor Green
while(-not $isDone) {
    $line = $reader.ReadLine()
    
    if($line -ne '' -and $line -ne $null) {
        # Remove useless text from each line first and separate outer bag from inner bag(s)
        $line =  $line.replace(' bags contain ',',').replace('bags','').replace('bag','').replace('.','').replace('no other','')

        $linearray = $line.split(',')
        For($n=0; $n -lt $linearray.count; $n++) {
            if($n -eq 0) { $outer = $linearray[$n] }
            else {
                $inner = $($linearray[$n]).Trim()
                # Match the number at the start
                $isMatched = $inner -match '(^[0-9]{1,})'
                if($isMatched) {
                    $number = $matches[0]
                    # Match anything but the number
                    $isMatched = $inner -match '[a-zA-Z ]+'
                    if($matches) { $inner = $matches[0].Trim() }
                } else {
                    $number = 0
                    $inner  = ''
                }
                $BagNesting += Add-Bag -Outer $outer -Inner $inner -Number $number
            }
        }
    } else {
            $isDone = $true
    }
}
$reader.Close()

write-host "Calculating Part A..." -ForegroundColor Magenta
$GLOBAL:MoreBags = @()
Find-AllOuter -inner $MyBag
$UniqueBags = $GLOBAL:MoreBags | Select Outer -Unique
$NumberofBags = $UniqueBags.Count
write-host "PART 1: Total Nested Bags is $NumberofBags" -ForegroundColor Green

write-host "Calculating Part B..." -ForegroundColor Magenta
$GLOBAL:MoreBags = @()
$GLOBAL:NestBagsCount = 0
Find-AllInner -outer $MyBag
write-host "PART 2: Total Nested Bags is $GLOBAL:NestBagsCount" -ForegroundColor Green

