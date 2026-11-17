#!/usr/bin/env bash
# Bộ cài skill mewart-content-agent cho macOS / Linux.
# Chạy:  bash scripts/install.sh [--verify-only]
# Giả định máy ĐÃ có lark-cli được cấu hình sẵn cho Lark Mewart.
# Script không đổi cấu hình lark-cli.
set -u
VERIFY_ONLY=0; [ "${1:-}" = "--verify-only" ] && VERIFY_ONLY=1

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_NAME="mewart-content-agent"
SKILL_SRC="$REPO_ROOT/skills/$SKILL_NAME"
SKILLS_DIR="$HOME/.claude/skills"
SKILL_DST="$SKILLS_DIR/$SKILL_NAME"
BASE_TOKEN="N0uub2iuPadQSlsxdyVl3aARguc"
TODO=()
has() { command -v "$1" >/dev/null 2>&1; }

# 1. Copy skill
if [ $VERIFY_ONLY -eq 1 ]; then
  [ -f "$SKILL_DST/SKILL.md" ] && echo "[OK] Skill có tại $SKILL_DST" || { echo "[CẦN LÀM] Chưa cài skill"; TODO+=(skill); }
else
  mkdir -p "$SKILLS_DIR"
  if [ -d "$SKILL_DST" ]; then
    BK="$SKILLS_DIR/.backup/$SKILL_NAME-$(date +%Y%m%d-%H%M%S)"; mkdir -p "$(dirname "$BK")"; mv "$SKILL_DST" "$BK"
    echo "[OK] Đã sao lưu bản cũ vào $BK"
  fi
  cp -R "$SKILL_SRC" "$SKILLS_DIR/" && echo "[OK] Đã cài skill vào $SKILL_DST"
fi

# 2. lark-cli
if ! has lark-cli; then
  echo "[LỖI] Máy chưa có lark-cli. Bộ cài này giả định lark-cli đã được cấu hình sẵn cho Lark Mewart; nhờ anh Nguyên cài trước."
  exit 1
fi
echo "[OK] lark-cli $(lark-cli --version)"

# 3. Profile nào vào được base content (ưu tiên mặc định)
test_base() {
  if [ -n "$1" ]; then lark-cli --profile "$1" base +base-get --base-token "$BASE_TOKEN" --as user 2>&1 | grep -q '"ok": *true'
  else lark-cli base +base-get --base-token "$BASE_TOKEN" --as user 2>&1 | grep -q '"ok": *true'; fi
}
FOUND=""
if test_base ""; then FOUND="__default__"
else
  for n in $(lark-cli profile list 2>/dev/null | grep -o '"name": *"[^"]*"' | sed 's/.*: *"//;s/"$//'); do
    if test_base "$n"; then FOUND="$n"; break; fi
  done
fi

if [ "$FOUND" = "__default__" ]; then
  u=$(lark-cli auth status 2>/dev/null | grep -o '"userName": *"[^"]*"' | head -1 | sed 's/.*: *"//;s/"$//')
  echo "[OK] Profile mặc định vào được base content (user: ${u:-?})"
elif [ -n "$FOUND" ]; then
  echo "[OK] Profile '$FOUND' vào được base content. Skill sẽ tự thêm --profile $FOUND (không đổi profile mặc định)."
else
  if lark-cli auth status 2>/dev/null | grep -q '"userName"'; then
    echo "[CẦN LÀM] Đã đăng nhập nhưng chưa vào được base content. Nhờ quản lý share base + wiki (quyền chỉnh sửa), hoặc đăng nhập lại (INSTALL.md bước 3)."; TODO+=(permission)
  else
    echo "[CẦN LÀM] Đăng nhập Lark (INSTALL.md bước 3)"; TODO+=(login)
  fi
fi

if [ ${#TODO[@]} -eq 0 ]; then echo "[XONG] Cài đặt hoàn tất. Khởi động lại OpenCode / Claude Code để nạp skill."
else echo "[CÒN] ${TODO[*]}"; fi
