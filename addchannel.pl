#!/usr/bin/perl

use strict;
use warnings;

print "Channel id: ";
my $channelid=<>;
chomp $channelid;
print "Channel name: ";
my $channelname=<>;
chomp $channelname;

print "Id: '$channelid' Name: '$channelname'\n";

my $dir = "/home/username/Videos/$channelname";
mkdir( $dir ) or die "Unable to create the directory:$!";
open(FH, ">", "$dir/.$channelname") or die "Unable to create dotfile for youtube-dl:$!";
close FH;

my $countid = `grep channelid.= cronytdl | sort -t: -u -k1,1 | wc -l`;
my $number = $countid + 1;

my $countname = `grep channelname.= cronytdl | sort -t: -k1,1 | wc -l`;
my $number2 = $countname + 1;

open(FH, ">>", "cronytdl") or
die "File coudn't be opened";

(my $stuff = qq{

\#$channelname
cd ~/Videos/$channelname
channelid$number=$channelid
channelname$number2=$channelname
youtube-dl -f bestvideo+bestaudio --download-archive ~/Videos/$channelname/.$channelname --merge-output-format mkv https://www.youtube.com/channel/\$channelid$number || \$(
curl https://www.youtube.com/feeds/videos.xml?channel_id=\$channelid$number | grep yt:videoId | sed -e 's/<\\/*yt:videoId>//g' -e 's/ //g' > .ids.txt
find * | sed 's/....\$//g' | grep -o '.\\{11\\}\$' > .local.txt
missing=\$(comm -23 <(sort .ids.txt) <(sort .local.txt))
for dlvideo in \$missing; do
	ytdl -a -o audio \$dlvideo
	ytdl -b -o video \$dlvideo
	ffmpeg -i video.mp4 -i audio.mp4 -c:v copy -c:a copy output.mp4
	title=\$(youtube-dl -e \$dlvideo | sed -e 's/ /_/g' -e 's/\\///g')
	mv output.mp4 \$title-\$dlvideo.mp4
	rm video.mp4 && rm audio.mp4
	echo "youtube \$dlvideo" >> .\$channelname$number2
done
rm .ids.txt && rm .local.txt)
});
print FH $stuff;

close FH;
print "Successfully added a channel\n";