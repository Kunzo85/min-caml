#!/bin/bash
# Compile MinCaml source with i8v1 profile and libraries

if [ $# -eq 0 ]; then
    echo "Usage: $0 <source_file_without_extension> [additional_embed_files...]"
    echo "Example: $0 test/fib"
    echo "Example: $0 sandbox/minrt sandbox/globals"
    exit 1
fi

# 最初の引数がターゲットファイル
TARGET="$1"
shift

# 残りの引数を埋め込みファイルとして追加
EMBED_ARGS=""
for file in "$@"; do
    EMBED_ARGS="$EMBED_ARGS -embed $file"
done

dune exec --profile=i8v1 mincaml -- -link i8v1/libArray -embed i8v1/libmincaml $EMBED_ARGS "$TARGET"
