param(
	[Parameter(Mandatory=$true)][string]$archiveID
)
# Dont show download progress
$progressPreference = 'silentlyContinue'

# Urls for downloading
$m3uUrl = "https://archive.org/download/"+$archiveID+"/"+$archiveID+"_vbr.m3u"
$metaUrl = "https://archive.org/metadata/"+$archiveID

# Get m3u file for file index
Invoke-WebRequest -Uri $m3uUrl -OutFile data.m3u

# Get metadata
$allMeta = Invoke-RestMethod -Uri $metaUrl
$files = $allMeta.files
$metadata = $allMeta.metadata
$title = $metadata.title
echo $title

# Create folder for concert silently
New-Item -ItemType directory -Path $title -ErrorAction SilentlyContinue | Out-Null

# Loop through all files 
$counter = 1
foreach($line in Get-Content .\data.m3u) {
	# Determine title and extension for saving
	$fname = Split-Path $line -leaf
	$oName = ($files | where {$_.name -eq $fname}).title
	$extn = [IO.Path]::GetExtension(($files | where {$_.name -eq $fname}).name)
	echo $oName$extn
	
	# Download file
	$output = "$title/$counter. $oname$extn"# + $title+"/"+$oname+$extn
	Invoke-WebRequest -Uri $line -OutFile $output
	$counter++;
}

# Remove m3u
Remove-Item data.m3u