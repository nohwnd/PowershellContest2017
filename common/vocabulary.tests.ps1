. $PSScriptRoot\setup.ps1

Describe "Shares" {
    Context "Uses win32_share class" {
        It "Passes given solution '<solution>' that contains the string win32_share" -TestCases @( 
            @{ Solution = 'win32_share'}
            @{ Solution = '-win32_share-'}
        ) {
            param ($Solution)

            Test-UseWin32Class $Solution
        }

        It "Fails given solution '<solution>' that does not contains the string win32_share" -TestCases @(
            @{ Solution = 'abcwin32_share-gef'}
            @{ Solution = 'abcwin32_share-gef'}
            @{ Solution = 'abc-win32_sharex'}
        ) {
            param ($Solution)
            { Test-UseWin32Class $Solution } | Assert-Throw -ExceptionType ([InvalidOperationException])
        }
    }

    Context "Gives correct answer" {
        It "Passes given the correct answer" {
            $actual = ( Import-Clixml "$PSScriptRoot\shares.expected.clixml" )
            Test-SharesAnswer -SolutionOutput $actual
        }

        It "Fails given incorrect answer '<solution>'" -TestCases @(
            @{ Solution = '\\srv01\ADMIN$'}
        ) {
            param ($Solution)
            { Test-SharesAnswer $Solution } | Assert-Throw -ExceptionType ([Assertions.AssertionException])
        }
    }
}

Describe "Mandelbrot" {
    Context "Uses `$question" {
        It "Passes given solution '<solution>' that contains the string `$question" -TestCases @( 
            @{ Solution = '$question'}
            @{ Solution = '$question-ok'}
            @{ Solution = '$question-jabadaba'}
        ) {
            param ($Solution)

            Test-UseQuestionVariable $Solution
        }

        It "Fails given solution '<solution>' that does not contains the string `$question, or it would not form correct powershell variable" -TestCases @(
            @{ Solution = 'abc$questiona-gef'}
            @{ Solution = 'abc$ques-gef'}
        ) {
            param ($Solution)
            { Test-UseQuestionVariable $Solution } | Assert-Throw -ExceptionType ([InvalidOperationException])
        }
    }

    Context "Gives correct answer" {
        It "Passes given the correct answer" {
            Test-MandelbrotAnswer -SolutionOutput 'The B in Benoit B. Mandelbrot stands for Benoit B. Mandelbrot.'
        }

        It "Fails given incorrect answer '<solution>'" -TestCases @(
            @{ Solution = 'bla bla'}
            @{ Solution = ' The B in Benoit B. Mandelbrot stands for Benoit B. Mandelbrot.' }
            @{ Solution = 'the B in benoit B. Mandelbrot stands for Benoit B. Mandelbrot.' }
        ) {
            param ($Solution)
            { Test-MandelbrotAnswer $Solution } | Assert-Throw -ExceptionType ([Assertions.AssertionException])
        }
    }
}

Describe "Mining" {
    Context "Gives correct answer for long text" {
        It "Passes given the correct answer" {
            Test-MiningAnswerForLongText -SolutionOutput 0.516397779494322
        }

        It "Fails given incorrect answer" {
            { Test-MiningAnswerForLongText 10 } | Assert-Throw -ExceptionType ([Assertions.AssertionException])
        }
    }

    Context "Gives correct answer for powershell text" {
        It "Passes given the correct answer" {
            Test-MiningAnswerForPowershell -SolutionOutput 1
        }

        It "Fails given incorrect answer" {
            { Test-MiningAnswerForPowershell 10 } | Assert-Throw -ExceptionType ([Assertions.AssertionException])
        }
    }
    
    Context "Gives correct answer for similar text" {
        It "Passes given the correct answer" {
            Test-MiningAnswerForSimilarText -SolutionOutput 0.870388279778489
        }
        
        It "Fails given incorrect answer" {
            { Test-MiningAnswerForSimilarText 10 } | Assert-Throw -ExceptionType ([Assertions.AssertionException])
        }
    }
}

Describe "Common" {
    Context "Contains no semicolons" {
        It "Passes given solution '<solution>' does not contain semicolon" {
            Test-NotContainsSemicolon "abc"
        }

        It "Fails given solution that contains semicolon" {
            { Test-NotContainsSemicolon "a;b" } | Assert-Throw -ExceptionType ([InvalidOperationException])
        }
    }

    Context "Contains no new line character" {
        It "Passes given string without new-line characters" {
            Test-IsSingleLine "abc"
        }

        It "Fails given string with new-line character '<solution>'" -TestCases @(
            @{ Solution = "ab`n"}
            @{ Solution = "`n" }
            @{ Solution = "a`nb" }
            @{ Solution = "ab`r" }
            @{ Solution = "a`r`nb" }
        ) {
            param ($Solution)
            { Test-IsSingleLine $Solution } | Assert-Throw -ExceptionType ([InvalidOperationException])
        }
    }
}