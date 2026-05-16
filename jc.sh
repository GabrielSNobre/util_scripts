#!/bin/sh

SRC_DIR="src"
OUT_DIR="bin"
MAIN_FILE=$(grep -rl "public static void main" "$SRC_DIR")
MAIN_CLASS=$(echo "$MAIN_FILE" | sed "s|$SRC_DIR/||" | sed 's|/|.|g' | sed 's|.java||')


case "$1" in 
	build)
		echo "Compiling..."
		mkdir -p "$OUT_DIR"
		javac -d "$OUT_DIR" $(find "$SRC_DIR" -name "*.java")
		;;
	run)
		java -cp "$OUT_DIR" "$MAIN_CLASS"
		;;
	help)
		echo "Commands: help, run"
		;;
	*)
		echo "Unknown argument"
		exit 1
		;;
esac
