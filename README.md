
# GratefulDeadArchiveDownload
Powershell script for downloading concerts of The Grateful Dead and possibly others from the Internet Archive.

## Usage
```
.\download.ps1  
    [archiveID]
    [directory] (optional)
   ```

**archiveID** is the part after /details/ in the archive.org url, for example:
``gd78-01-22.sbd.popi.4974.sbeok.shnf`` in ``https://archive.org/details/gd78-01-22.sbd.popi.4974.sbeok.shnf``

**directory** is the directory where you want to download the files to. 
If not supplied it will use the title of the concert.

It will create a new folder for the concert and all songs, numbers them, and puts them in the directory.
