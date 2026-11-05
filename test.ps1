$ErrorActionPreference = 'Stop'
& "$PSScriptRoot\build.ps1"
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (!(Test-Path -LiteralPath $compiler)) { $compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe' }
$dist = Join-Path $PSScriptRoot 'dist'
Push-Location $dist
try {
    foreach ($test in @('Regression','ChordVerify','FeatureVerify','SortToggleVerify','ScrollSecurityVerify','PolishVerify','PortableVerify')) {
        & $compiler /nologo "/out:$dist\$test.exe" "/reference:$dist\Makro Sound Switch V.0.1.exe" /reference:System.Windows.Forms.dll /reference:System.Drawing.dll /reference:System.Core.dll "$PSScriptRoot\tests\$test.cs"
        if ($LASTEXITCODE -ne 0) { throw "$test did not compile" }
        & "$dist\$test.exe" > "$dist\$test-results.txt"
        if ($LASTEXITCODE -ne 0) { throw "$test failed; inspect its results in dist" }
        Write-Output "$test passed"
    }
} finally { Pop-Location }

