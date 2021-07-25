# ENV
$ErrorActionPreference = "Stop"

# SQLite Info
$SQLITEMC_VER = "v1.3.4"
$API_URL = "https://api.github.com/repos/utelle/SQLite3MultipleCiphers/releases/tags/" + $SQLITEMC_VER

Write-Host "Preparing.."
Remove-Item -Path ".\temp" -Recurse -Force -ErrorAction Ignore

Write-Host "`r`nDiscovering the asset.."
$RESULT = Invoke-WebRequest $API_URL -Method Get | ConvertFrom-Json
$FILE = @($RESULT.assets.name) -match '-amalgamation.zip' | Select-Object -First 1
$DL_URL = @($RESULT.assets.browser_download_url) -match '-amalgamation.zip' | Select-Object -First 1

Write-Host "`r`nDownloading.. ($( $FILE ))"
Invoke-WebRequest -Uri $DL_URL -OutFile (New-Item -Path ".\temp\source.zip" -Force)

Write-Host "`r`nExtracting archive.."
Expand-Archive  -Path ".\temp\source.zip" -DestinationPath ".\temp\extracted"

Write-Host "`r`nPreparing source files.."
Remove-Item -Path ".\temp\extracted\sqlite3.h"
Rename-Item -Path ".\temp\extracted\sqlite3mc_amalgamation.h" -NewName "sqlite3.h"
Rename-Item -Path ".\temp\extracted\sqlite3mc_amalgamation.c" -NewName "sqlite3.c"

Write-Host "`r`nCreating tarball.."
Remove-Item -Path "sqlite3.tar.gz" -Force
tar czf "sqlite3.tar.gz" -C temp\extracted sqlite3.c sqlite3.h sqlite3ext.h

Write-Host "`r`nCleaning up.."
Remove-Item -Path ".\temp" -Recurse -Force

Write-Host "`r`nProcess completed" -ForegroundColor green
