#!/bin/bash

# Menu titles go here, in reverse order
MENUS=(
    rpg
    news
    entertainment
    dev
)

# Menu contents go here, in reverse order
# Unlisted menus or menus without contents are empty on the page but the item is created
# Usage: "<link name>|<link URL>"
dev=(
    "GitHub|http://github.com/edicatad"
    "AWS|http://console.aws.amazon.com/"
    "StackSPACEOverflow|http://stackoverflow.com"
    "Asana|http://app.asana.com"
    "Flaticon|http://flaticon.com"
    "CommandlineFu|http://commandlinefu.com"
    "TravisSPACECI|https://travis-ci.org/profile/Edicatad"
)
entertainment=(
    "TableSPACETitans|http://tabletitans.com/"
    "Reddit|http://reddit.com"
    "YouTube|http://youtube.com"
    "UnixSPACEPorn|http://unixporn.reddit.com"
    "AvE|https://www.youtube.com/user/arduinoversusevil/videos"
    "Let'sSPACEPlay|https://www.youtube.com/user/LetsPlay/videos"
    "AchievementSPACEHunter|https://www.youtube.com/user/AchievementHunter/videos"
    "ArtisanSPACEVideos|http://artisanvideos.reddit.com"
)
news=(
    "Bloomberg|http://bloomberg.com"
    "HackerSPACENews|http://news.ycombinator.com"
    "TorrentFreak|http://torrentfreak.com"
    "Tweakers|http://tweakers.net"
    "FedoraSPACEMagazine|http://fedoramagazine.org"
    "FedoraSPACESubreddit|http://fedora.reddit.com"
    "LinuxSPACESubreddit|http://linux.reddit.com"
    "FOSSSPACEPost|http://fosspost.org"
)
rpg=(
    "Roll20|http://roll20.net"
    "RPGSPACESubreddit|http://rpg.reddit.com"
    "4chanSPACETrove|https://rpg.rem.uz/"
    "Donjon'sSPACEGenerators|https://donjon.bin.sh/"
    "ChaoticSPACEShinySPACEGenerators|http://chaoticshiny.com"
)

# Copy the empty index file from the html folder
cp -v html/index.html index.html
for i in "${MENUS[@]}"
do
    # Add the menu columns
    sed -i.bak '
        /menus/ a\
\        <div class="column">\
\            <span class="menu" data-menu-type="'$i'"></span>\
\            <ul class="sub '$i'">\
\            </ul>\
\        </div>
    ' index.html
    PLACEHOLDER="$i[@]"
    for j in "${!PLACEHOLDER}"
    do
        IFS='|' read -r -a CURRENTLINK <<< "$j"
        sed -i.bak '
            /sub '$i'/ a\
\                <a href="'${CURRENTLINK[1]}'">'${CURRENTLINK[0]}'</a>
        ' index.html
    done
done
# sed doesn't like spaces when adding lines or something, this gets around that
sed -i.bak 's/SPACE/ /g' index.html
