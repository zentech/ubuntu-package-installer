#!/bin/bash
#purpose: script to reinstall apps in Linux Mint
#author: George Louis
#date: 4/6/2017

#array containing all apps to be reinstalled
apps=(
	gimp
	dia
	darktable
	chromium-browser
	wireshark
	libreoffice
	kdenlive
	kazam
	cheese
	vlc
	simplescreenrecorder
	obs-studio
	ffmpeg
	tcpdump
	atom
	eclipse
	g++
	audacity
	ubuntu-restricted-extras
	inkscape
	git
	)


#update and upgrade system
update_upgrade() {
	sudo apt-get update && sudo apt-get upgrade
	check_status $?
}

#installing applications
install_apps() {
	for app in ${apps[@]}
	do
		#if app already installed, continue
		[ $(which $app) ] && continue
		#checking for ppa's 
		if [[ $app == "ppa"* ]]; then
			sudo add-apt-repository $app
			sudo apt-get update
			continue
		fi
		sudo apt-get install -y $app
		#check if app installed ok
		check_status $?	$app
	done
}

#checking for errors during install
check_status() {
	if [ $1 -ne 0 ]; then
		echo "$2 Exit with an error!"
	fi	
}


###############
#    MAIN     #		
###############

update_upgrade
install_apps

#END

