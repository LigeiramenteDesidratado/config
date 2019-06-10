#!/usr/bin/env bash

currentPath=$(pwd)

pathThumb="/home/machine/.cache/thumbnails/sxivThumbs"

folderStruct=$(echo "${currentPath}" | sha1sum | head -c40)

dir="${pathThumb}/${folderStruct}"

dbFile="${dir}/.dbthumb__"

declare -A keyValuePair

function checkIfExists() {

    if [[ ! -d "${pathThumb}" ]]; then
        mkdir "${pathThumb}"
    fi

    if [[ ! -d "${dir}" ]]; then
        mkdir "${dir}"
    fi

    if [[ ! -L "${currentPath}/.thumb__" ]]; then
        ln -fs "${dir}" "${currentPath}/.thumb__"
    fi

    if [[ ! -f "${dbFile}" ]]; then
        touch "${dbFile}"
    fi
}


checkIfExists

function loadDB() {

    while read line; do
        keyValuePair["${line:0:44}"]="${line:45}"
    done < "${dbFile}"

}

loadDB

function closeDB() {
    echo "" > "${dbFile}"

    for kv in "${!keyValuePair[@]}"; do
        echo "${kv} ${keyValuePair[${kv}]}" >> "${dbFile}"
    done

}


for FILE in "${currentPath}/"*; do

    testFile=$(file --mime-type -b -h "${FILE}")

    if [[ "${testFile: 0:5}" == "video" ]]; then


        FILESHA=$(echo "${FILE}" | sha1sum | head -c40 | sed 's/$/.png/')
        PATHFILESHA="${pathThumb}/${folderStruct}/${FILESHA}"

        test "${keyValuePair[${FILESHA}]+_}" || keyValuePair["${FILESHA}"]="${FILE}"

        if [[ ! -f "${PATHFILESHA}" ]]; then
            ffmpegthumbnailer -f -i "${FILE}" -o "${PATHFILESHA}" &> /dev/null &
        fi
    fi
done

closeDB

