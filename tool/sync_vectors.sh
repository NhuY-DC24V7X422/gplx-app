#!/usr/bin/env bash
# Chép test vector từ gplx-api sang gplx-app.
# gplx-api là bản gốc: muốn sửa vector thì sửa bên api rồi chạy lại script này.
#
# Cách chạy (đứng ở thư mục gplx-app):
#   bash tool/sync_vectors.sh ../gplx-api
set -euo pipefail  # có lỗi là dừng ngay

API_DIR="${1:-../gplx-api}"
SRC="$API_DIR/test/vectors"
DEST="$(dirname "$0")/../test/vectors"

if [ ! -d "$SRC" ]; then
  echo "Không tìm thấy thư mục $SRC"
  exit 1
fi

mkdir -p "$DEST"
cp "$SRC"/*.json "$DEST"/

# ghi mã kiểm tra (checksum) của các file để biết bản sao có đúng bản mới nhất không
( cd "$DEST" && cat $(ls *.json | sort) | shasum | cut -d' ' -f1 > vectors.sha1 )

echo "Đã chép test vector từ $SRC (sha1: $(cat "$DEST/vectors.sha1"))"
