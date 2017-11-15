param (
    [Parameter(Mandatory)]
    [string] $Solution
)

## TASK 1: Shares
# write the shortest possible oneliner that extracts from the win32_share class the UNC path of all the local shares

# expected output:
# \\NDEV\ADMIN$
# \\NDEV\C
# \\NDEV\C$
# \\NDEV\IPC$
# \\NDEV\Share

# specific rules: use of win32_share wmi class is mandatory

. "$PSScriptRoot\common\setup.ps1"


function Invoke-Solution ($Solution) { 
    Invoke-Expression $Solution
}

Describe "Shares" {
    $Solution = $Solution.Trim()
    $solutionLength = $Solution.Length

    $shares = "$PSScriptRoot\common\shares.clixml"
    Mock -CommandName Get-WmiObject -ParameterFilter { $Class -eq 'win32_share' } -MockWith { 
        Import-Clixml $shares }

    Mock -CommandName Get-CimInstance -ParameterFilter { $ClassName -eq 'win32_share' } -MockWith { 
        Import-Clixml $shares }
    
    function hostname { "hostname.exe is an executable, but in this case we allow it. :)" }
    Mock -CommandName hostname -MockWith { "NDEV" }

    $env:ComputerName = "NDEV"

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
        It "Contains `$question" {
            Test-UseWin32Class $Solution 
        }

        It "Produces correct answer" {
            $solutionOutput = Invoke-Solution $Solution
            Test-SharesAnswer $solutionOutput 
        }
    }
}