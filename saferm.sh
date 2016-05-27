# ---------- Gets an absolute path to a file ----------
function myreadlink() {
    (
    cd $(dirname $1)
    echo $PWD/$(basename $1)
    )
}


# ---------- Instead of removing files, just move them to a trash folder ----------
export MY_TRASH_DIR="$HOME/.mytrash"
function saferm {
    # Make sure ~/.mytrash exists, if it doesn't, then create it
    if [[ ! -e "$MY_TRASH_DIR" ]]; then
        mkdir "$MY_TRASH_DIR"
    fi

    # remove a trailing slash from each arg if there is one
    args=()
    for arg in "$@"
    do
        args+=("${arg%/}")
    done

    # Get the current time to name the directory to hold the deleted stuff
    currentTime=$(date +"%Y-%m-%d %H:%M:%S")

    # Create the directory in the trash named with the timestamp
    mkdir "$MY_TRASH_DIR/$currentTime"

    # Move the stuff to the trash
    for target in "${args[@]}"
    do
        mv "$target" "$MY_TRASH_DIR/$currentTime"
    done

    # Add a new file to the trash folder containing the old location of the stuff
    # Hopefully there is nothing named ".trash_old_location"
    echo "$(dirname $(myreadlink $1))" >> "$MY_TRASH_DIR/$currentTime/.trash_old_location"
}

# ---------- Used to restore a file/directory deleted with saferm ----------
# Note: If dotfiles are not being restored, then add `shopt -s dotglob nullglob`
# to your bashrc to include dotfiles in glob patterns.
function rstr {
    # Remove a trailing slash if there is one
    target="${1%/}"

    # Make sure dotfiles are included in globs so no files are left behind.
    if [[ $(shopt -s) != *"dotglob"* ]]; then
        echo ""
        echo "Dotfiles will not be copied and will be removed from the trash.  In order"
        echo "to copy dot files, add the following command to your .bashrc:"
        echo ""
        echo "    shopt -s dotglob nullglob"
        echo ""

        # Ask the user if they want to continue without setting dotglob
        while true; do
            read -p "Would you like to continue anyways? (y/n) " yn
            case $yn in
                [Yy]* )
                    break
                    ;;
                [Nn]* )
                    return
                    ;;
                * )
                    echo "Please answer y or n"
                    ;;
            esac
        done
    fi

    # Make sure there is an old location file to read from
    if [[ -e "$target/.trash_old_location" ]]; then
        # Read the first line of the old location file.. aka the old location
        location=$(head -n 1 "$target/.trash_old_location")

        # Make sure the old location still exists
        if [[ -d "$location" ]]; then
            # Move everything to the old location
            mv "$target"/* "$location"

            # Remove the .trash_old_location file from the restored stuff and
            # remove the folder from the trash that used to contain the restored
            # stuff.
            \rm "$location/.trash_old_location"
            \rm -rf "$target"
        else
            echo "The containing directory no longer exists."
            return
        fi
    else
        echo "The file/directory cannot be restored."
        return
    fi
}

# ---------- Set aliases for safe removal and retrieval ----------
alias emtr="\rm -rf $MY_TRASH_DIR/*"
alias lstr="ls -al $MY_TRASH_DIR"