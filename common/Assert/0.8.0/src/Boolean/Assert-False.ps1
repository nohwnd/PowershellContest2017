function Assert-False {
    param (
        [Parameter(ValueFromPipeline=$true)]
        $Actual, 
        [String]$Message
    )

    $Actual = Collect-Input -ParameterInput $Actual -PipelineInput $local:Input
    if ($Actual) 
    { 
        $Message = Get-AssertionMessage -Expected $false -Actual $Actual -Message $Message -DefaultMessage "Expected <actualType> '<actual>' to be <expectedType> '<expected>' or falsy value 0, """", `$null, @()."
        throw [Assertions.AssertionException]$Message
    }

    $Actual
}
