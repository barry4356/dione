# Dione
**D**igital **I**ndex **o**f **N**early **E**verything
## Overview
Provides NAS services for local network, backing up important data and providing access to local media over Wifi as an SMB server.
## Specs
| | |
| ----------- | ----------- |
| Board | Orange pi 3 LTS |
| OS   | Armbian 23.02 Jammy CLI |
| Local SD | 36GB MicroSD |
| HDD | Seagate Portable 5TB (x2) |
| PS | Wenter 36W powered USB hub |
| | |

## Usage 
The primary purpose of this system is to provide redundant storage for any data that needs to be backed up. This includes **Lindsey's Photos**, **Barry's Android Files**, **Barry's old Google Drive Snapshot**, and any other data that needs to persist long term. Each individual function has been broken into a separate shell script, and any shared const vars are sourced from the `config.sh` script.

### Raw Photo Backup
Lindsey's Nikon camera creates pseudo-unique names for each image file by default. The `check_duplicates.sh` script can check all subdirectories to see if any filenames are shared. Once verified that the filenames are unique, the `RawIngest.sh` script pulls these files from the SD card into the Raw photo directory on the NAS. The `RawSort.sh` script creates a subdirectory named by the month/year of each image file, moves the files to these subdirectories, and deconflicts any matching filenames within the subdirectories. The filenames can be searched for the `.orig` string to find if any duplicate filenames that had to be renamed by the script. The `PerformBackup.sh` script will rsync the raw photo directory with its corresponding directory on the secondary drive.

``` mermaid
graph TD;
    SDCard --> CD1(check_duplicates.sh);
    CD1(check_duplicates.sh) --> SDCard;
    SDCard --> RI(RawIngest.sh);
    RI(RawIngest.sh) --> PrimaryRaw;
    PrimaryRaw --> RS(RawSort.sh);
    RS(RawSort.sh) --> PrimaryRaw;
    PrimaryRaw --> PB(PerformBackup.sh);
    PB(PerformBackup.sh) --> SecondaryRaw;
```

### Android and its SD Backup
The Android Backup samba share will contain any data backed up from Barry's Android phone. The share will be accessible to the phone remotely via SMB, and will include a directory for a full backup of the SD card. The SD card full backup can be created by connecting the SD card directly to Dione through an adapter. The full contents of the SD card will be compressed, and transferred to the Primary drive with the `AndroidIngest.sh` script using rsync. The `PerformBackup.sh` script will rsync the raw photo directory with its corresponding directory on the secondary drive.

``` mermaid
graph TD;
    SDCard --> AI(AndroidIngest.sh);
    AI(AndroidIngest.sh) --> PrimaryAndroid;
    PrimaryAndroid --> PB(PerformBackup.sh);
    PB(PerformBackup.sh) --> SecondaryAndroid;
```
