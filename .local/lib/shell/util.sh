# Append arguments with delimiter separated values
dsv_a() {

	local delimiter=,
	if [ "$1" = '-d' ]; then
		delimiter="$2"
		shift
		shift
	fi

	for val in "$@"; do
		printf "$delimiter"
		printf "$val"
	done | sed "s/^$delimiter//"
	echo
}

var_a() {
	local var="$1"
	shift

	local delimiter=:
	if [ "$1" = '-d' ]; then
		delimiter="$2"
		shift
		shift
	fi

	declare -g "$var=$(dsv_a -d "$delimiter" "${!var}" "$@")"
}
