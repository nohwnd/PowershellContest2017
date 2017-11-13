# PowerShell contest 2017

This repository contains tasks, and tests for [PowerShell one-liner contest 2017](http://www.happysysadm.com/2017/11/powershell-oneliner-contest-2017.html).

To test your solutions you can save your oneliner in a `.ps1` file (for example `shares.ps1`), and invoke the test like this:

`&"C:\projects\poshcontest2017\1_shares.tests.ps1" -Solution (Get-Content -Raw "~\Desktop\shares.ps1")`

Make sure you use the -Raw switch.
