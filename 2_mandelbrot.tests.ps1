param (
    [Parameter(Mandatory)]
    [string] $Solution
)


## TASK 2: Mandelbrot joke
# write the shortest possible oneliner that answers this question
$question = 'What is the middle name of Benoit B. Mandelbrot?'
# by returning:
# 'The B in Benoit B. Mandelbrot stands for Benoit B. Mandelbrot.'
# reuse of $question variable is mandatory


. "$PSScriptRoot\common\setup.ps1"

function Invoke-Solution ($Solution) { 
    $question = 'What is the middle name of Benoit B. Mandelbrot?'
    Invoke-Expression $Solution
}

Describe "Mandelbrot joke" {
    $Solution = $Solution.Trim()
    $solutionLength = $Solution.Length

    Context "Contestant '$contestant', solution >$Solution< with length $solutionLength" {
        It 'Contains no semicolons' {
            Test-NotContainsSemicolon $Solution
        }

        It 'Contains no new-line characters' {
            Test-IsSingleLine $Solution
        }

        It 'Runs without errors' {
            Invoke-Solution $Solution
        }
        # this simulates the switch "default" case 
        #It "Contains `$question" {
        #    Test-UseQuestionVariable $Solution
        #}

        It "Produces correct answer" {
            $solutionOutput = Invoke-Solution $Solution
            Test-MandelbrotAnswer $solutionOutput 
        }
    }
}
