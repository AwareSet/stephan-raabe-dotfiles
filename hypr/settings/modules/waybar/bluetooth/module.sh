#!/bin/bash
_getHeader "$name" "$author"

echo "Hide the bluetooth icon in ML4W waybar themes."

# Define File
targetFile1="$HOME/dotfiles/waybar/themes/ml4w/config"
targetFile2="$HOME/dotfiles/waybar/themes/ml4w-blur/config"
targetFile3="$HOME/dotfiles/waybar/themes/ml4w-blur-bottom/config"
targetFile4="$HOME/dotfiles/waybar/themes/ml4w-bottom/config"

if [ ! -f $targetFile1 ] || [ ! -f $targetFile2 ] || [ ! -f $targetFile3 ] || [ ! -f $targetFile4 ] ;then
    echo "ERROR: Target file not found."
    sleep 2
    _goBack
fi

# Define Markers
startMarker="\/\/ START BT TOOGLE"
endMarker="\/\/ END BT TOOGLE"

# Define Replacement Template
customtemplate="VALUE\"bluetooth\","

# Select Value
customvalue=$(gum choose "SHOW" "HIDE")

if [ ! -z $customvalue ]; then

    if [ "$customvalue" == "SHOW" ] ;then
        customvalue=""
    else
        customvalue="//"
    fi
    # Replace in Template
    customtext="${customtemplate/VALUE/"$customvalue"}" 

    # Ensure that markers are in target file
    if grep -s "$startMarker" $targetFile1 && grep -s "$endMarker" $targetFile1 && grep -s "$startMarker" $targetFile2 && grep -s "$endMarker" $targetFile2 && grep -s "$startMarker" $targetFile3 && grep -s "$endMarker" $targetFile3 && grep -s "$startMarker" $targetFile4 && grep -s "$endMarker" $targetFile4; then 

        # Write into File
        sed -i '/'"$startMarker"'/,/'"$endMarker"'/ {
        //!d
        /'"$startMarker"'/a\
        '"$customtext"'
        }' $targetFile1

        # Write into File
        sed -i '/'"$startMarker"'/,/'"$endMarker"'/ {
        //!d
        /'"$startMarker"'/a\
        '"$customtext"'
        }' $targetFile2

        # Write into File
        sed -i '/'"$startMarker"'/,/'"$endMarker"'/ {
        //!d
        /'"$startMarker"'/a\
        '"$customtext"'
        }' $targetFile3

        # Write into File
        sed -i '/'"$startMarker"'/,/'"$endMarker"'/ {
        //!d
        /'"$startMarker"'/a\
        '"$customtext"'
        }' $targetFile4

        # Reload Waybar
        setsid $HOME/dotfiles/waybar/launch.sh 1>/dev/null 2>&1 &
        _goBack

    else 
        echo "ERROR: Marker not found."
        sleep 2
        _goBack
    fi
else 
    echo "ERROR: Define a value."
    sleep 2
    _goBack    
fi
