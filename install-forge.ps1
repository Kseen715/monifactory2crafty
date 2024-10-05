# Stop script on error
$ErrorActionPreference = "Stop"

# Usage: .\install-forge.ps1 <forge-jar-file> <Monifactory-server-zip>

# Check if the correct number of arguments are provided
if ($args.Count -ne 2) {
    Write-Host "Usage: .\install-forge.ps1 <forge-jar-file> <Monifactory-server-zip>"
    exit 1
}

$forgeJarFile = $args[0]
$serverZipFile = $args[1]

# Check if the destination directory exists
if (Test-Path -Path "server") {
    # Remove the existing directory
    Remove-Item -Path "server" -Recurse -Force
}

# Create "server" directory if it doesn't exist
if (-Not (Test-Path -Path "server")) {
    New-Item -ItemType Directory -Path "server"
}

# Copy the forge jar file into the server directory
Copy-Item -Path $forgeJarFile -Destination "server/forge.jar"
Set-Location -Path "server"

# Execute java -jar TheForgeInstallerName.jar --installServer
& java -jar forge.jar --installServer

Set-Location -Path ".."

# Check if the temp directory exists
if (Test-Path -Path "temp") {
    # Remove the existing directory
    Remove-Item -Path "temp" -Recurse -Force
}

# Create temp directory
if (-Not (Test-Path -Path "temp")) {
    New-Item -ItemType Directory -Path "temp"
}

# Unzip the server zip file to the temp directory
Expand-Archive -Path $serverZipFile -DestinationPath "temp" -Force


# Move the contents of the overrides folder to the server directory
$subFolderList = Get-ChildItem -Path "temp/overrides" -Directory
for ($i = 0; $i -lt $subFolderList.Count; $i++) {
    $subFolder = $subFolderList[$i]
    Move-Item -Path "temp/overrides/$($subFolder.Name)/" -Destination "server" -Force
}

# Move-Item -Path "temp/overrides/*" -Destination "server" -Recurse -Force

# Remove temp directory
Remove-Item -Path "temp" -Recurse -Force

# Change to the server directory
Set-Location -Path "server"

# Accept the EULA
"eula=true" | Out-File -FilePath "eula.txt" -Encoding ASCII

Set-Location -Path ".."

# Check if the temp directory exists
if (Test-Path -Path "temp") {
    # Remove the existing directory
    Remove-Item -Path "temp" -Recurse -Force
}

# Create temp directory
if (-Not (Test-Path -Path "temp")) {
    New-Item -ItemType Directory -Path "temp"
}

# Find zip file in files-to-add/world
$worldZip = Get-ChildItem -Path "files-to-add/world-zip" -Filter "*.zip" -Recurse

# Check if a zip file was found
if ($worldZip) {
    # Unzip the world zip file to the temp directory
    Expand-Archive -Path $worldZip.FullName -DestinationPath "temp/world" -Force
} else {
    Write-Host "No zip file found in files-to-add/world-zip"
}

# Move the contents of the world folder to the server directory
$subFolderList = Get-ChildItem -Path "temp/world" -Directory
for ($i = 0; $i -lt $subFolderList.Count; $i++) {
    $subFolder = $subFolderList[$i]
    Move-Item -Path "temp/world/$($subFolder.Name)/" -Destination "server/world" -Force
}

# Remove temp directory
Remove-Item -Path "temp" -Recurse -Force

# Copy files from files-to-add/mods into server/mods
$mods = Get-ChildItem -Path "files-to-add/mods" -Recurse
foreach ($mod in $mods) {
    Copy-Item -Path $mod.FullName -Destination "server/mods" -Force
}

# Copy files from files-to-add/config into server/config
$configs = Get-ChildItem -Path "files-to-add/config" -Recurse
foreach ($config in $configs) {
    Copy-Item -Path $config.FullName -Destination "server/config" -Force
}

# Get name of original zip
$zipName = $serverZipFile | Split-Path -Leaf
$craftyZipName = $zipName -replace ".zip", "-crafty.zip"

# Remove $craftyZipName if it exists
if (Test-Path -Path $craftyZipName) {
    Remove-Item -Path $craftyZipName -Force
}

# Compress the contents of the temporary folder
Compress-Archive -Path server/* -DestinationPath $craftyZipName -CompressionLevel Optimal


# Print Finished
Write-Host "<] Crafty zip created: $craftyZipName"
Write-Host "<] Finished 💅"