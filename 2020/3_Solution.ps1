# Day 3
$InputRaw = Get-Content ".\3_input.txt"

$Trees       = 0
$CurrentLine = 0
$CurrentPos  = 0
$TreeChar    = '#'
$DoA = $false

if($DoA) {
    Do {
        $OriginalLine = $InputRaw[$CurrentLine]
        $RepeatCount = [int]$($InputRaw.Count / 3)
        for($x=0;$x -lt $RepeatCount;$x++) {
            $InputRaw[$CurrentLine] += $OriginalLine
        }    
        $StartLine = [string]$InputRaw[$CurrentLine].Substring(0,$CurrentPos)
        $EndLine   = $InputRaw[$CurrentLine].Substring($CurrentPos,($InputRaw[$CurrentLine].Length-$CurrentPos))

        #write-host $StartLine -ForegroundColor Cyan -NoNewline

        if($InputRaw[$CurrentLine][$CurrentPos] -eq $TreeChar) {
            $Trees += 1
            #write-host 'X' -ForegroundColor Red -NoNewline
        } else {
            #write-host '-' -ForegroundColor Green -NoNewline
        }
       # write-host $EndLine -ForegroundColor Cyan

        $CurrentPos  += 3
        for($n=0;$n -lt 1;$n++) {
            $CurrentLine += 1
            #write-host $InputRaw[$CurrentLine] -ForegroundColor Cyan
        }

    } While($CurrentLine -lt $InputRaw.Count)

    write-host "#3A - Found $Trees Trees along the route" -ForegroundColor Green
}

$TreeChar    = '#'
$Product     = 1
$RightArray  = @(1,3,5,7,1)
$DownArray   = @(1,1,1,1,2)
$AnswerArray = $RightArray

$InputRaw = Get-Content ".\3_input.txt"

For($y=0;$y -lt $RightArray.Count;$y++) {

    $Trees       = 0
    $CurrentLine = 0
    $CurrentPos  = 0

    Do {
        #Print Startline
        if($CurrentPos -gt 0) {
            Write-Host $([string]$InputRaw[$CurrentLine].Substring(0,$CurrentPos)) -ForegroundColor Cyan -NoNewline
        }

        #Print Location
        if($InputRaw[$CurrentLine][$CurrentPos] -eq $TreeChar) {
            $Trees += 1
            write-host 'X' -ForegroundColor Red -NoNewline
        } else {
            write-host '-' -ForegroundColor Green -NoNewline
        }

        # Print Endline
        write-host $($InputRaw[$CurrentLine].Substring($CurrentPos+1,($InputRaw[$CurrentLine].Length-$CurrentPos-1))) -ForegroundColor Cyan

        $CarryOver = $CurrentPos + $RightArray[$y] - $InputRaw[$CurrentLine].Length
        if($CarryOver -ge 0) {
            $CurrentPos = $CarryOver
        } else {
            $CurrentPos += $RightArray[$y]
        }
        
        # Print missed lines
        if($DownArray[$y] -gt 1) {
            for($n=0;$n -lt $DownArray[$y]-1;$n++) {
                $CurrentLine += 1
                write-host $InputRaw[$CurrentLine] -ForegroundColor Cyan
            }
        }
        $CurrentLine += 1

    } While($CurrentLine -lt $InputRaw.Count)
    
    write-host "Right $($RightArray[$y]), Down $($DownArray[$y]) Found $Trees Trees"
    Start-Sleep -Seconds 1
    $AnswerArray[$y] = $Trees
    $Product = $Product * $Trees
}

ForEach($Answer in $AnswerArray) {
    write-host "#3B - Found $Answer Trees along the route" -ForegroundColor Gray
}

write-host "#3B - Product of Trees found is $Product" -ForegroundColor Green
