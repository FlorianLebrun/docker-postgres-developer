param (
   [Parameter(mandatory=$true)] $PostgresVersion,
   [Parameter(mandatory=$true)] $InstallDir
)

### Make the sample config easier to munge (and "correct by default")
$SAMPLE_FILE = "$InstallDir/pgsql/share/postgresql.conf.sample"
$SAMPLE_CONF = Get-Content $SAMPLE_FILE
$SAMPLE_CONF = $SAMPLE_CONF -Replace '#listen_addresses = ''localhost''', 'listen_addresses = ''*'''
$SAMPLE_CONF | Set-Content $SAMPLE_FILE
