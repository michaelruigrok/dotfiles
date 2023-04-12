REPL_DIR="/tmp/$USER/repl/"

repl_start() {
	mkdir -p "$REPL_DIR"
	REPL_ID="${1:-$(ls "$REPL_DIR" | wc -l)}"
	REPL_FILE="$REPL_DIR/$REPL_ID.sh"
}

alias repl_last="history -p '!!'"

repl_save() {
	repl_last | tee -a "$REPL_FILE"
}

repl_save_var() {
	local var
	var="$(repl_last | sed 's/.*/'$1'="$(&)"/')"
	echo "$var" | tee -a "$REPL_FILE"
	eval "$var"
	history -s "$var"
}

repl_run() {
	. "$REPL_FILE"
}

repl_edit() {
	$EDITOR "$REPL_FILE"
	repl_run
}

repl_clear() {
	> "$REPL_FILE"
}

