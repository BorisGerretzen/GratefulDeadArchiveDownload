# GratefulDeadArchiveDownload
Powershell script for downloading concerts of The Grateful Dead and possibly others from the Internet Archive.

## Usage
``.\download.ps1 -archiveID archiveID``

archiveID is the part after /details/ in the archive.org url, for example:
``gd78-01-22.sbd.popi.4974.sbeok.shnf`` in ``https://archive.org/details/gd78-01-22.sbd.popi.4974.sbeok.shnf``

It will create a new folder for the concert with the title as you see it on the archive.org website. After this it downloads all songs, numbers them, and puts them in the directory.
