$ErrorActionPreference = 'Stop'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (!(Test-Path -LiteralPath $compiler)) { $compiler = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe' }
if (!(Test-Path -LiteralPath $compiler)) { throw 'Install .NET Framework 4.8 to build this Windows app.' }
$dist = Join-Path $PSScriptRoot 'dist'
New-Item -ItemType Directory -Force -Path $dist | Out-Null
& $compiler /nologo /target:winexe /platform:anycpu /optimize+ "/out:$dist\Makro Sound Switch V.0.1.exe" "/win32icon:$PSScriptRoot\assets\SoundSwitch.ico" "/win32manifest:$PSScriptRoot\src\app.manifest" /reference:System.Windows.Forms.dll /reference:System.Drawing.dll /reference:System.Xml.dll /reference:System.Core.dll "$PSScriptRoot\src\SoundSwitch.cs"
if ($LASTEXITCODE -ne 0) { throw 'App build failed' }
Write-Output "Built $dist\Makro Sound Switch V.0.1.exe"
