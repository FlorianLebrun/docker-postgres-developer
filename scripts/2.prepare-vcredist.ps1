param (
   [Parameter(mandatory=$true)] $PostgresVersion,
   [Parameter(mandatory=$true)] $InstallDir
)
$ProgressPreference = 'SilentlyContinue'

### Install correct Visual C++ Redistributable Package
if (($PostgresVersion -like '9.*') -or ($PostgresVersion -like '10.*')) {
   Write-Host('Visual C++ 2013 Redistributable Package')
   $VCRedistUrl = 'https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe'
}
else {
   Write-Host('Visual C++ 2017 Redistributable Package')
   $VCRedistUrl = 'https://download.visualstudio.microsoft.com/download/pr/11100230/15ccb3f02745c7b206ad10373cbca89b/VC_redist.x64.exe'
}
Invoke-WebRequest -Uri $VCRedistUrl -OutFile "$InstallDir/vcredist.exe"
Start-Process "$InstallDir/vcredist.exe" -Wait -ArgumentList @('/install','/passive','/norestart')

# Copy relevant DLLs to PostgreSQL
if (Test-Path 'C:/windows/system32/msvcp120.dll') {
   Write-Host('Visual C++ 2013 Redistributable Package')
   Copy-Item 'C:/windows/system32/msvcp120.dll' -Destination "$InstallDir/pgsql/bin/msvcp120.dll"
   Copy-Item 'C:/windows/system32/msvcr120.dll' -Destination "$InstallDir/pgsql/bin/msvcr120.dll"
}
else {
   Write-Host('Visual C++ 2017 Redistributable Package')
   Copy-Item 'C:/windows/system32/vcruntime140.dll' -Destination "$InstallDir/pgsql/bin/vcruntime140.dll"
   Copy-Item 'C:/windows/system32/msvcp140.dll' -Destination "$InstallDir/pgsql/bin/msvcp140.dll"
}
