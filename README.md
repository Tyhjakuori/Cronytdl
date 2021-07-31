## Table of contents
* [Initial setup](#initial-setup)
* [Usage](#usage)
* [Sources](#sources)


## Initial setup

You will need the following to use this properly :
* curl
* ffmpeg
* base-devel
* coreutils
* youtube-dl
* pafy

Youtube-dl you can find here:   
https://github.com/ytdl-org/youtube-dl   
Pafy here:   
https://github.com/mps-youtube/pafy   

On linux you can install youtube-dl via command line or package manager.   
I prefer first aproach
```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```
OR
```
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```
(source youtube-dl github page)

And pafy i got from AUR
```
https://aur.archlinux.org/packages/python-pafy-git/
```

Reason i'm using both is that pafy is there as a failsafe option. Sometimes youtube-dl fails to download due to error or content behind age-gate, but pafy seems to be able to download those videos most of the time.

## Usage

The initial bash script serves only as an example.   
To make it work you will need to create the folders and change "channelid" + "channelname" to ones you want.   
Or you can use the perl script, more info about that below.   
    
I use this with cron as the name suggest.   
Cronjob looks like this 
```
 @hourly /bin/sh /home/username/Documents/Bash/cronytdl >> /home/username/Documents/Bash/logs/cronytdl.log
```
I make it keep a log for me, so i can regularly check everything is working correctly.   
But it works well using it via command line too.
    
I have added a perl script to make adding new channels to the file easier.   
You will need to provide it channelname and channelid.   
You will need to replace following:
```
my $dir = "/home/_username_/Videos/$channelname";
```
To include your username and they need to be in same directory to work properly

## Sources

youtube-dl https://github.com/ytdl-org/youtube-dl    
pafy https://github.com/mps-youtube/pafy, https://aur.archlinux.org/packages/python-pafy-git/

