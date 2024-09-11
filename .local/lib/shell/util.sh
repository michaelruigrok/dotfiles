# shellcheck disable=SC2317
now() { date +%S.%N; }

quiet() { "$@" >/dev/null 2>/dev/null; }
stderr() { "$@" >&2; }
error() {
	local prefix
	if funcname -p 1 -q; then
		prefix="$(funcname -p 1): "
	fi
	echo "Error: $prefix$*" >&2
}

item() {
	function usage() {
		echo "perform a check or operation of a single value against a given list"
	}

	local item="$1" operator="$2"
	if ! shift 2; then
		stderr usage
		return 1
	fi

	case "$operator" in
		not)
			item "$item" "$@"
			local exit="$?"
			case $exit in
				9) return 9;;
				0) return 1;;
				*) return 0;;
			esac
			;;
		in)
			for element in "$@"; do
				if [[ "$element" = "$item" ]]; then
					return 0
				fi
			done
			;;
		*)
			error "operator '$operator' not supported"
			echo >&2 "  Inside function '$(funcname -p 1 )'"
			return 9
	esac
	return 1 # If ya wanted tuh succeed ya shoulda done it earlia!!
}

# Append arguments with delimiter separated values
dsv_a() {

	local delimiter=,
	if [ "$1" = '-d' ]; then
		delimiter="$2"
		shift
		shift
	fi

	for val in "$@"; do
		printf %s "$delimiter"
		printf %s "$val"
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
