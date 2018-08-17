Home directory structure:
.
├── data
│   ├── maps
│   ├── speech
│   └── text
├── Desktop
├── dev
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
└── www

* *data* stores datasets and corpora
* *share* is the mounting point for cloud-based storage
* *dev* contains personal software development projects
* *src* contains source code from other people's projects
* *www* stores and serves web-related software projects
* *tmp* is meant as a temporary place to store files downloaded from browser:
  + *doc* stores documents, spreadsheets, PDFs, CSVs, and plaintext files
  + *pic* stores temporary pictures
  + *sh* stores temporary bash, python, perl scripts
  + *snd* stores audio files and songs
  + *zip* stores temporary archives
* *etc* stores permanent files unrelated to programming:
  + *music* contains albums and is read by MPD
  + *pics* contains wallpapers and other permanent pictures
  + *roms* stores emulator roms

The directories in *data*, *tmp* and *etc* may later be symlinked to the win10 
partition to save space and to share files.
