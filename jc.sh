#!/bin/sh

SRC_DIR="src"
OUT_DIR="bin"

find_main_class() {
    MAIN_FILE=$(find "$SRC_DIR" -name "*.java" -exec grep -l "public static void main" {} \; | head -1)
    
    if [ -z "$MAIN_FILE" ]; then
        echo "Error: Could not find a class with main method"
        exit 1
    fi
    
    MAIN_CLASS=$(echo "$MAIN_FILE" | sed "s|$SRC_DIR/||" | sed 's|/|.|g' | sed 's|.java||')
    echo "$MAIN_CLASS"
}

compile(){
    echo "Compiling..."
    mkdir -p "$OUT_DIR"
    javac -d "$OUT_DIR" $(find "$SRC_DIR" -name "*.java")
    
    if [ $? -eq 0 ]; then
        echo "Compilation successful!"
    else
        echo "Compilation failed!"
        exit 1
    fi
}

case "$1" in 
    build | -b)
        compile
        ;;
    run | -r)
        MAIN_CLASS=$(find_main_class)
        if [ -n "$MAIN_CLASS" ]; then
            echo "Running: $MAIN_CLASS"
            java -cp "$OUT_DIR" "$MAIN_CLASS"
        fi
        ;;
    clean | -c)
        echo "Cleaning bin directory..."
        rm -rf "$OUT_DIR"
        echo "Done!"
        ;;
    help | -h)
        echo "Java Compilation Utility"
        echo "Commands:"
        echo "  help    | -h     - Show this help message"
        echo "  run     | -r     - Run the main class"
        echo "  build   | -b     - Compile the project"
        echo "  clean   | -c     - Clean the bin directory"
        ;;
    *)
        echo "Unknown argument: $1"
        echo "Use 'help' or '-h' for available commands"
        exit 1
        ;;
esac
