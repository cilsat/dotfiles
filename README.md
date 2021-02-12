## Laptop/Desktop

### Home directory structure:
.
├── data
│   ├── maps
│   ├── speech
│   └── text
├── Desktop
├── etc
│   ├── music
│   ├── pics
│   └── roms
├── share
├── src
├── tmp
│   ├── doc
│   ├── pic
│   ├── sh
│   ├── snd
│   └── zip
├── prosa
└── agra


* *data* stores datasets and corpora
* *share* is the mounting point for cloud-based storage
* *dev* contains personal non-work related software development projects
* *src* contains other people's source code
* *tmp* is meant as a temporary place to store files downloaded from browser:
  + *doc* stores documents, spreadsheets, PDFs, CSVs, and plaintext files
  + *pic* stores pictures
  + *sh* stores bash, python, and perl scripts
  + *snd* stores audio files and songs
  + *ark* stores compressed archives
- *prosa* stores Prosa-related source code
- *agra* stores Agranara-related source code

The directories in *data* and *tmp* and may later be symlinked to the win10 
partition to save space and to share files.

### Setup

Setup uses `ansible`, and assumes a properly partitioned and bootloaded Arch 
Linux installation with `sudo` and a non-root user already configured. :e

