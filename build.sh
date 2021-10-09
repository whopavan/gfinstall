curVer=0
fullCurVer=0
updateDebVersion() {
    oldVer=`head -1 debian/changelog | cut -d '(' -f2 | cut -d ')' -f1`
    echo Old Version: $oldVer
    read -p "New Version: " ver
    dch -v $ver
}

currentVersion() {
    fullCurVer=`head -1 debian/changelog | cut -d '(' -f2 | cut -d ')' -f1`
    curVer=`head -1 debian/changelog | cut -d '(' -f2 | cut -d ')' -f1 | cut -d '-' -f1`
}

makeDeb () {
    echo "Running make"
    clean
    read -p "Have you updated version? (Y/N): " verUpdate
    case $verUpdate in
        [Yy]* ) echo "Continuing....";;
        [Nn]* ) read -p "Do you want to update version now? (Y/N): " verUpdate;
                case $verUpdate in
                    [Yy]* ) updateDebVersion;;
                    [Nn]* ) echo "You have to update version to continue";
                            exit;;
                        * ) echo "Invalid input";
                            exit;;
                esac;;
            * ) exit;;
    esac
    currentVersion
    dh_make -p gfinstall_$curVer --indep --createorig -c gpl3 -e realpvn@gmail.com
}

buildDebSource () {
    updateGFList
    makeDeb
    debuild -S
    read -p "Do you want to upload Package to PPA? (Y/N): " wantUpload
    case $wantUpload in
        [Yy]* ) uploadPPA;;
    esac
}

buildDebBinary () {
    echo "[!] Binary file cannot be uploaded to PPA"
    read -p "This will delete any deb source files, do you want to proceed? (Y/N): " cleanNow
    case $cleanNow in
        [Yy]* ) echo "Continuing....";;
        [Nn]* ) echo "You must clean to build binary, exiting..."
                exit;;
            * ) exit;;
    esac
    updateGFList
    makeDeb
    debuild
}

debug() {
    if [[ -e ../gfinstall_$fullCurVer.dsc ]]
    then
        echo "Debugging .dsc file"
        lintian ../gfinstall_$fullCurVer.dsc
        echo "----------------------"
        lintian ../gfinstall_${fullCurVer}_all.deb
    else
        echo "You need to build before debugging"
    fi
}

clean () {
    echo "Cleaning build"
    rm -f ../gfinstall_*
}

fetchLatestGF() {
    # This function updates gflist with all google fonts available
    # To use this you must set GOOGLE_API_KEY env variable

    # In the first time `apiData=` we get data from the api
    # Then we parse api data and copy it to gflist file
    #       - `echo ${apiData,,}` will convert everything to lowercase
    #       - `jq -r` is responsible for parsing api data (keep in mind that all data have been lowered before parsing,
    #         might be bad but it stays till I find better solution)
    #       - `tr -d ' '` will get rid of all the spaces in between names and write the output to gflist file

    apiData=`curl -s "https://www.googleapis.com/webfonts/v1/webfonts?key=$GOOGLE_API_KEY&sort=alpha"`
    echo ${apiData,,} | jq -r '.items[].family' | tr -d ' ' > fonts_list/gflist

    if [ $? != 0 ]
	then
		return 1
	fi
    return 0
}

updateGFList() {
	echo "Updating google fonts list"
    fetchLatestGF

    if [ $? != 0 ]
	then
		printFailed "Failed to fetch latest google fonts"
		return 1
	fi

	newFontsList=`echo $(cat fonts_list/gflist)`
	sed -i '/^fontsList=*/c\fontsList="'"$newFontsList"'"' 'gfinstall.bash'
	
	if [ $? != 0 ]
	then
		printFailed "Failed to update google fonts list"
		return 1
	fi

	echo "Updated Google Fonts List"
	return 0
}

uploadPPA () {
    echo "Current version: $fullCurVer"
    read -p "Is the current version correct? (Y/N): " verCheck
    case $verCheck in
        [Yy]* ) echo "Starting Upload"
                cd ..
                dput ppa:realpvn/gfinstall gfinstall_${fullCurVer}_source.changes;;
        [Nn]* ) echo "Terminating upload";;
            * ) echo "Wrong input";;
    esac
}

if [ "$1" != "" ]
then
    currentVersion
    PARAM=$1
    case $PARAM in
        -ds | --debSource   ) buildDebSource;
                                exit;;
        -db | --debBinary   ) buildDebBinary;
                                exit;;
        -c  | --clean       ) clean;
                                exit;;
        -d  | --debug       ) debug;
                                exit;;
        -ul | --update-list ) updateGFList;
                                exit;;
        -u | --uploadPPA    ) uploadPPA;
                                exit;;
                          * ) echo -e "Usage:\n-ds | --debSource:\t Generates debian source file\n-db | --debBinary:\t Generates debian binary file\n-sn | --snap:\t\t Generates Snap Package\n-c | --clean:\t\t Cleans directory, removes all build files etc\n-u | --uploadPPA:\t Uploads source file to PPA";
                                exit;;
    esac
fi
echo -e "Usage:\n-ds | --debSource:\t Generates debian source file\n-db | --debBinary:\t Generates debian binary file\n-sn | --snap:\t Generates Snap Package\n-c | --clean:\t\t Cleans directory, removes all build files etc\n-u | --uploadPPA:\t Uploads source file to PPA";