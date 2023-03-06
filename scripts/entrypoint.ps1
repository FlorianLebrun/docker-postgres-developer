$PGDataDir = "c:/pgdata"

$POSTGRES_USER='dev'
$POSTGRES_PASSWORD=''
$POSTGRES_ALL_IP_RULE = 'host all all all trust'

# Ensure the data directory exists
if(-not (Test-Path $PGDataDir)) {
    Write-Host "PostgreSQL initdb..."
    
    $POSTGRES_PASSWORD | Out-File "c:/pgpass" -Append -Encoding ASCII
    
    mkdir "$PGDataDir"
    initdb.exe -U "$POSTGRES_USER" -D "$PGDataDir" --encoding=UTF8 --no-locale --pwfile=c:/pgpass
    
    "`n$POSTGRES_ALL_IP_RULE" | Out-File "$PGDataDir\pg_hba.conf" -Append -Encoding ASCII

    Write-Host "PostgreSQL init process complete; ready for start up."
}

# start the database
postgres.exe -D "$PGDataDir"
