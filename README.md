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

``` mermaid
graph TD;
    SDCard --> RI(RawIngest.sh);
    RI(RawIngest.sh) --> PrimaryRaw;
    PrimaryRaw --> PB(PerformBackup.sh);
    PB(PerformBackup.sh) --> SecondaryRaw;
```
