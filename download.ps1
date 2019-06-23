param(
	[Parameter(Mandatory=$true)][string]$archiveID,
	[string]$directory
)
# Dont show download progress
$progressPreference = 'silentlyContinue'

# Urls for downloading
$m3uUrl = "https://archive.org/download/"+$archiveID+"/"+$archiveID+"_vbr.m3u"
$metaUrl = "https://archive.org/metadata/"+$archiveID

# Get m3u and metadata
$m3u = Invoke-RestMethod -Uri $m3uUrl
$allMeta = Invoke-RestMethod -Uri $metaUrl
$files = $allMeta.files
$title = $allMeta.metadata.title

# If no custom directory, use title
if(!$directory) {
	$directory = $title
}
echo $title

# Create folder for concert silently
New-Item -ItemType directory -Path $directory -ErrorAction SilentlyContinue | Out-Null

# Loop through all files 
$counter = 1
foreach($line in $m3u.Split([Environment]::NewLine)) {
	# Determine title and extension for saving
	$fileName = Split-Path $line -leaf
	$fileTitle = ($files | where {$_.name -eq $fileName}).title
	$extension = [IO.Path]::GetExtension(($files | where {$_.name -eq $fileName}).name)
	echo $fileTitle$extension
	
	# Download file
	$output = "$directory/$counter. $fileTitle$extension"
	Invoke-WebRequest -Uri $line -OutFile $output
	$counter++;
}