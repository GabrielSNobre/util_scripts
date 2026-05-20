#!/bin/sh

SRC_DIR="src"
OUT_DIR="bin"

compile(){
	MAIN_FILE=$(grep -rl "public static void main" "$SRC_DIR")
	MAIN_CLASS=$(echo "$MAIN_FILE" | sed "s|$SRC_DIR/||" | sed 's|/|.|g' | sed 's|.java||')

	echo "Compiling..."
	mkdir -p "$OUT_DIR"
	javac -d "$OUT_DIR" $(find "$SRC_DIR" -name "*.java")
}

case "$1" in 
	build | -b)
		compile
		;;
	run | -r)
		java -cp "$OUT_DIR" "$MAIN_CLASS"
		;;
	help | -h)
		echo "Java Compilation Utility"
		echo "Commands:\nhelp	| -h\nrun	| -r\nbuild	| -b"
		;;
	*)
		echo "Unknown argument"
		exit 1
		;;
esac
