param (
   [Parameter(mandatory=$true)] $PostgresVersion,
   [Parameter(mandatory=$true)] $InstallDir
)
$ProgressPreference = 'SilentlyContinue'

### Setup postgres files
if (-not (Test-Path "$InstallDir/pgsql")) {
   $PostgresArchiveUrl = "https://get.enterprisedb.com/postgresql/postgresql-$PostgresVersion-windows-x64-binaries.zip"
   $PostgresArchivePath = "$InstallDir/pgsql.zip"

   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
   if (-not (Test-Path $PostgresArchivePath)) {
      Invoke-WebRequest -Uri $PostgresArchiveUrl -OutFile $PostgresArchivePath
   }

   Add-Type -Assembly "System.IO.Compression.Filesystem"
   [System.IO.Compression.ZipFile]::ExtractToDirectory($PostgresArchivePath, $InstallDir)
}
