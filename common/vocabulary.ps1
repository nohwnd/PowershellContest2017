function Test-UseWin32Class ($Solution) {
    if ($Solution -notmatch '\bwin32_share\b') {
        throw [InvalidOperationException]"Solution '$Solution' does not contain 'win32_share'."
    }   
}

function Test-SharesAnswer ($SolutionOutput) { 
    Assert-Equivalent -Actual $SolutionOutput -Expected (Import-Clixml "$PSScriptRoot\shares.expected.clixml")
}

function Test-UseQuestionVariable ($Solution) {
    if ($Solution -notmatch '\$question\b') {
        throw [InvalidOperationException]"Solution '$Solution' does not contain '`$question'."
    }   
}

function Test-MandelbrotAnswer ($SolutionOutput) { 
    $SolutionOutput | Assert-StringEqual -CaseSensitive 'The B in Benoit B. Mandelbrot stands for Benoit B. Mandelbrot.'
}

function Test-MiningAnswerForLongText ($SolutionOutput) { 
    Assert-Equal -Expected 0.516397779494322D -Actual ([decimal]$SolutionOutput)
}

function Test-MiningAnswerForSimilarText ($SolutionOutput) {
    Assert-Equal -Expected 0.870388279778489D -Actual ([decimal]$SolutionOutput)
}

function Test-MiningAnswerForPowershell ($SolutionOutput) { 
    Assert-Equal -Expected 1D -Actual ([decimal]$SolutionOutput)
}

function Test-NotContainsSemicolon ([string]$Solution) { 
    if ($Solution -like "*;*") { 
        throw [System.InvalidOperationException]"Solution contains semicolon." 
    }
} 

function Test-IsSingleLine ([string]$Solution) { 
    if ($Solution -like "*`n*" -or $Solution -like  "*`r*" ) { 
        throw [System.InvalidOperationException]"Solution contains new line character." 
    }
} 