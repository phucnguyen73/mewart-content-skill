#!/usr/bin/env bash
# Bộ cài skill mewart-content-agent cho macOS / Linux.
# Chạy:  bash scripts/install.sh [--skip-deps] [--verify-only]
# Script KHÔNG xử lý App Secret. Bước nhập secret và đăng nhập Lark nằm trong INSTALL.md (bước 4–5).
set -u
SKIP_DEPS=0; VERIFY_ONLY=0
for a in "$@"; do case "$a" in --skip-deps) SKIP_DEPS=1;; --verify-only) VERIFY_ONLY=1;; esac; done

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_NAME="mewart-content-agent"
SKILL_SRC="$REPO_ROOT/skills/$SKILL_NAME"
SKILLS_DIR="$HOME/.claude/skills"
SKILL_DST="$SKILLS_DIR/$SKILL_NAME"
APP_ID="cli_a985b5bc3ff85ed4"
PROFILE="mewart"
BASE_TOKEN="N0uub2iuPadQSlsxdyVl3aARguc"
TODO=()
has() { command -v "$1" >/dev/null 2>&1; }

# 1. Node >= 18
node_ok=0
if has node; then major=$(node -v | sed 's/^v//' | cut -d. -f1); [ "$major" -ge 18 ] && node_ok=1; fi
if [ $node_ok -eq 1 ]; then echo "[OK] Node $(node -v)"
elif [ $VERIFY_ONLY -eq 1 ] || [ $SKIP_DEPS -eq 1 ]; then echo "[CẦN LÀM] Cài Node.js >= 18"; TODO+=(node)
else
  if has brew; then echo "[CÀI] Node qua Homebrew..."; brew install node >/dev/null
  else echo "[LỖI] Chưa có Homebrew. Cài Node LTS tại https://nodejs.org rồi chạy lại."; exit 1; fi
  has node && echo "[OK] Node $(node -v)" || { echo "[LỖI] Cài Node thất bại"; exit 1; }
fi

# 2. lark-cli
if has lark-cli; then echo "[OK] lark-cli $(lark-cli --version)"
elif [ $VERIFY_ONLY -eq 1 ] || [ $SKIP_DEPS -eq 1 ]; then echo "[CẦN LÀM] Cài lark-cli: npm install -g @larksuite/cli"; TODO+=(lark-cli)
else
  echo "[CÀI] lark-cli..."; npm install -g @larksuite/cli >/dev/null 2>&1 || sudo npm install -g @larksuite/cli >/dev/null
  has lark-cli && echo "[OK] lark-cli $(lark-cli --version)" || { echo "[LỖI] Cài lark-cli thất bại"; exit 1; }
fi

# 3. Copy skill
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

# 4. Profile
has_profile=0
if has lark-cli && lark-cli profile list 2>/dev/null | grep -q "\"name\": *\"$PROFILE\""; then has_profile=1; fi
if [ $has_profile -eq 1 ]; then echo "[OK] Có profile Lark '$PROFILE'"
else echo "[CẦN LÀM] Tạo profile Lark '$PROFILE' (INSTALL.md bước 4, cần App Secret của $APP_ID)"; TODO+=(profile); fi

# 5. Đăng nhập + quyền
if [ $has_profile -eq 1 ]; then
  st=$(lark-cli --profile "$PROFILE" auth status 2>/dev/null)
  user=$(printf '%s' "$st" | grep -o '"userName": *"[^"]*"' | head -1 | sed 's/.*: *"//;s/"$//')
  if [ -n "$user" ]; then
    echo "[OK] Đã đăng nhập Lark: $user"
    if lark-cli --profile "$PROFILE" base +base-get --base-token "$BASE_TOKEN" --as user 2>&1 | grep -q '"ok": *true'; then
      echo "[OK] Truy cập được base 'Quản lý CONTENT MEW ART MAKEUP'"
    else echo "[CẦN LÀM] Tài khoản chưa có quyền vào base content. Nhờ quản lý share base + wiki."; TODO+=(permission); fi
  else echo "[CẦN LÀM] Đăng nhập Lark (INSTALL.md bước 5)"; TODO+=(login); fi
fi

if [ ${#TODO[@]} -eq 0 ]; then echo "[XONG] Cài đặt hoàn tất. Khởi động lại OpenCode / Claude Code để nạp skill."
else echo "[CÒN] ${TODO[*]}"; fi
