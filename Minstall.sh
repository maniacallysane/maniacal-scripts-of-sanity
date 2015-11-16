#!/bin/bash

updatePackages() {
    echo "Do you want to update your packages? [y/n]: "

    read var

    if [ $var == "y" ] || [ $var == "Y" ]
        then sudo pacman -Syu -y
        echo "Package Update Finished"
    elif [ $var == "n" ]
        then return
    else
        echo "Do you want to continue? [y/n]: "
        read ans1
        if [ $ans1 == "y" ] || [ $ans1 == "Y" ]
            then return
        else
            exit
        fi
    fi
}

aurSupport() {
    echo "Do you want AUR support? [y/n]: "
    
    read ans3

    path=/etc/pacman.conf

    if [ $ans3 == "y" ] || [ $ans3 == "Y" ]
        then echo "[archlinuxfr]" | sudo tee -a $path
        echo "SigLevel = Never" | sudo tee -a $path
        echo "Server = http://repo.archlinux.fr/\$arch" | sudo tee -a $path
        sudo pacman -Syy -y
        sudo pacman -S yaourt -y
    else
        return
    fi
}

printSupport() {
    echo "Would you like printer support? [y/n]: "
    read ans2
    
    if [ $ans2 == "y" ] || [ $ans2 == "Y" ]
        then sudo pacman -S cups ghostscript gsfonts cups-pdf -y
        sudo systemctl start org.cups.cupsd.service
        sudo systemctl enable org.cups.cupsd.service
    else
        return
    fi 

}

serverSupport() {
    echo "Do you want server support? [y/n]: "
    read ans4

    if [ $ans4 == "y" ] || [ $ans4 == "Y" ]
        then sudo pacman -S samba apache -y
    else
        return
    fi
}

codecsSupport() {
    echo "Do you want media codecs support? [y/n]: "
    read ans5

    if [ $ans5 == "y" ] || [ $ans5 == "Y" ]
        then sudo pacman -S ffmpeg gstreamer gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly jre8-openjdk jre8-openjdk-headless flashplugin -y
        yaourt -S libde265 -y
    else
        return
    fi
}

commonApps(){
    echo "Would You Like to Install Common Apps? [y/n]: "

    read var2
    
    if [ $var2 == "y" ] || [ $var2 == "Y" ]
        then sudo pacman -S vim gimp blender vlc inkscape openshot audacity libreoffice-fresh libreoffice-fresh-en-GB htop screenfetch tk kodi plank calligra-krita firefox gnome-disk-utility gparted gnome gnome-extra transmission-gtk steam -y
    yaourt -S google-chrome gtk-theme-arc-git spotify-stable minecraft compiz-manjaro fusion-icon0.9 -y

    echo "[antergos]" | sudo tee -a $path
    echo "SigLevel = Never" | sudo tee -a $path
    echo "Server = http://mirror.us.leaseweb.net/antergos/\$repo/\$arch" | sudo tee -a $path

    sudo pacman -Syy -y
    sudo pacman -S numix-icon-theme-square -y   

    else
        exit
    fi
}

updatePackages
aurSupport
printSupport
serverSupport
codecsSupport
commonApps
