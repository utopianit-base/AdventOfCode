# Day 5

function Add-Seat($Code,$Row,$Col,$ID)
{
    [PSCustomObject]$SetItem = @{}
    $SetItem.Add('Code',$Code)
    $SetItem.Add('Row',$Success)
    $SetItem.Add('Col',$Col)
    $SetItem.Add('ID',$ID)
    return New-Object -TypeName psobject -Property $SetItem
}

$reader = [System.IO.File]::OpenText("C:\Scripts\AdventOfCode\5_input.txt")

$Seats = @()
while($null -ne ($line = $reader.ReadLine())) {
    #$Line = 'FFBFFFFRRR'
    $RowLow = 0
    $RowHigh = 127
    $ColLow = 0
    $ColHigh = 7
    $Col = 0
    $Row = 0
    $ID  = 0
    # Find Row
    For($n=0; $n -le 7; $n++) {
        if($Line[$n] -eq 'B') { $RowLow = $RowLow + [math]::Ceiling(($RowHigh - $RowLow)/2)}
        else { $RowHigh = $RowHigh - [math]::Ceiling(($RowHigh - $RowLow)/2)}
    }
    $Row = $RowLow

    # Find Column
    For($n=7; $n -le 9; $n++) {
        if($Line[$n] -eq 'R') { $ColLow = $ColLow + [math]::Ceiling(($ColHigh - $ColLow)/2)}
        else { $ColHigh = $ColHigh - [math]::Ceiling(($ColHigh - $ColLow)/2) }
    }
    $Col = $ColLow

    $ID = ($Row * 8) + $Col
    write-host "$Line - Row: $Row Col: $Col ID: $ID"
    $Seats += Add-Seat -Code $Line -Row $Row -Col $Col -ID $ID
}

$reader.Close()
$HighestSeat = $($Seats | Sort ID -Descending | Select -First 1).ID
write-host "Highest Seat ID is $HighestSeat"
$SeatList = $($Seats | Sort ID)
$NextSeat = ($SeatList | Select -First 1).ID
ForEach($Seat in $SeatList) {
    if($Seat.ID -ne $NextSeat) {
        write-host "Your seat ID is $($Seat.ID - 1)"
        Break
    }
    $NextSeat += 1
}

