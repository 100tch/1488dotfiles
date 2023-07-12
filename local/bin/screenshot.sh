#!/usr/bin/env bash
function help_message {
	if [ -n "${1}" ]; then
		echo "${1}"
	fi

	cat <<-E0F
	Usage: screenshot [-h|-s] [<screenshots_dir>]
	Take screenshot of a specified screen region,
	save it to a specified directory.

		-h - print help
		-s - take a screenshot of a screen region
	E0F

	if [ -n "${1}" ]; then
		exit 1
	fi
	exit 0
}

if [ "${1}" == '-h' ]; then
	help_message
elif [ "${1}" != '-s' ]; then
	help_message "Error: unknown option: ${1}"
else
	params="-border"
	dir="${2}"
fi

import ${params} ${dir}Screenshot_$( date '+%Y-%m-%d_%H-%M-%S' ).png
