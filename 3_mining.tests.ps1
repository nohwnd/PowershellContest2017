param (
    [Parameter(Mandatory)]
    [string] $Solution
)


## TASK3: Text Mining
# Given the following two text variables
$t1 = "I really like scripting with PowerShell"
$t2 = "PowerShell is a really really nice scripting language"
# write a oneliner that uses cosine similarity and returns 0.516397779494322
# the oneliner should work against any other text
# the comparison must be case insensitive, meaning that PowerShell and powershell are the same word


. "$PSScriptRoot\common\setup.ps1"

function Invoke-SolutionWithLongText ($Solution) { 
    $t1 = "I really like scripting with PowerShell"
    $t2 = "PowerShell is a really really nice scripting language"
    Invoke-Expression $Solution
}

function Invoke-SolutionWithPowershell ($Solution) { 
    $t1 = "PowerShell"
    $t2 = "powershell"
    Invoke-Expression $Solution
}

Describe "Text mining" {
    $Solution = $Solution.Trim()
    $solutionLength = $Solution.Length

    Context "Solution >$Solution< with length $solutionLength" {
        It 'Contains no semicolons' {
            Test-NotContainsSemicolon $Solution
        }

        It 'Contains no new-line characters' {
            Test-IsSingleLine $Solution
        }

        It 'Runs without errors' {
            Invoke-SolutionWithLongText $Solution
        }
        
        It "Returns the correct answer for long text" {
            $solutionOutput = Invoke-SolutionWithLongText $Solution
            Test-MiningAnswerForLongText $solutionOutput
        }

        It "Returns the correct answer for powershell text" {
            $solutionOutput = Invoke-SolutionWithPowershell $Solution
            Test-MiningAnswerForPowershell $solutionOutput
        }
    }
}