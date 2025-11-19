#!/bin/bash
# Compile MinCaml source with i8v1 profile and libraries

# このスクリプトのディレクトリ（min-camlプロジェクトのルート）を取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 現在のディレクトリを保存
ORIGINAL_DIR="$(pwd)"

# min-camlプロジェクトディレクトリに移動
cd "$SCRIPT_DIR" || exit 1

ASSEMBLE=true

if [ $# -eq 0 ]; then
    echo "Usage: $0 [-s] <source_file_without_extension> [additional_embed_files...]"
    echo "Options:"
    echo "  -s    Stop after assembly generation (do not assemble)"
    echo "Example: $0 test/fib"
    echo "Example: $0 -s test/fib"
    echo "Example: $0 sandbox/minrt sandbox/globals"
    exit 1
fi

# -s オプションをチェック
if [ "$1" = "-s" ]; then
    ASSEMBLE=false
    shift
fi

# 最初の引数がターゲットファイル（相対パスとして解釈）
# 元のディレクトリからの相対パスを、プロジェクトルートからの相対パスに変換
TARGET="$1"
shift

# 元のディレクトリがプロジェクトルートの下にあれば、相対パスはそのまま使う
# そうでなければ、元のディレクトリからのパスを計算
if [[ "$ORIGINAL_DIR" == "$SCRIPT_DIR"* ]]; then
    # プロジェクト内で実行された場合
    TARGET="$TARGET"
else
    # プロジェクト外で実行された場合、相対パスを元のディレクトリからの相対パスから変換
    TARGET="$ORIGINAL_DIR/$TARGET"
    # 絶対パスに統一
    TARGET="$(cd "$ORIGINAL_DIR" 2>/dev/null && echo "$TARGET" || echo "$TARGET")"
fi

# 残りの引数を埋め込みファイルとして追加
EMBED_ARGS=""
for file in "$@"; do
    # 相対パスをプロジェクトルートからの相対パスに変換
    if [[ "$ORIGINAL_DIR" == "$SCRIPT_DIR"* ]]; then
        # プロジェクト内で実行された場合
        resolved_file="$file"
    else
        # プロジェクト外で実行された場合
        resolved_file="$ORIGINAL_DIR/$file"
        # 絶対パスに統一
        resolved_file="$(cd "$ORIGINAL_DIR" 2>/dev/null && echo "$resolved_file" || echo "$resolved_file")"
    fi
    EMBED_ARGS="$EMBED_ARGS -embed $resolved_file"
done

dune exec --profile=i8v1 mincaml -- -link i8v1/libArray -embed i8v1/libmincaml $EMBED_ARGS "$TARGET"
STATUS=$?

if [ $STATUS -eq 0 ] && [ "$ASSEMBLE" = true ]; then
    assemble.sh v0.3.2b "$TARGET.s"
fi

exit $STATUS
