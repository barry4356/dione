# Dione
Local Network NAS
## Specs
| | |
| ----------- | ----------- |
| Board | Orange pi 3 LTS |
| OS   | Armbian 23.02 Jammy CLI |
| Local SD | 36GB MicroSD |
| HDD | Seagate Portable 5TB (x2) |
| PS | Wenter 36W powered USB hub |
| | |

## Functionality 
The primary purpose of this system is to provide redundant storage for any data that needs to be backed up. This includes **Lindsey's Photos**, **Barry's Android Files**, **Barry's old Google Drive Snapshot**, and any other data that needs to persist long term.

### Raw Photo Backup
Lindsey's Nikon camera creates pseudo-unique names for each image file by default. The `RawIngest.sh` script pulls these files from the SD card into the Raw photo directory on the NAS. The `RawSort.sh` script creates a subdirectory named by the month/year of each image file, moves the files to these subdirectories, and deconflicts any matching filenames within the subdirectories. The `PerformBackup.sh` script will rsync the raw photo directory with its corresponding directory on the secondary drive.

``` mermaid
graph TD;
    SDCard --> RI(RawIngest.sh);
    RI(RawIngest.sh) --> PrimaryRaw;
    PrimaryRaw --> RS(PrimarySort.sh);
    RS(PrimarySort.sh) --> PrimaryRaw;
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
