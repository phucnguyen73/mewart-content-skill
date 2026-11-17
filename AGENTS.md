# Hướng dẫn cho AI agent

- **Người dùng nhờ cài đặt hoặc cập nhật:** làm theo [`INSTALL.md`](INSTALL.md) từng bước. Không bỏ qua các quy tắc về App Secret.
- **Người dùng nhờ làm content** (plan, caption, nghiệm thu, teaser, VJ): dùng skill `mewart-content-agent` đã cài ở `~/.claude/skills/`. Nếu chưa cài thì đọc trực tiếp `skills/mewart-content-agent/SKILL.md` trong repo này.
- **Sửa skill:** sửa trong `skills/mewart-content-agent/`, cập nhật `CHANGELOG.md`, rồi chạy lại bộ cài để copy sang `~/.claude/skills/`.
- Không commit secret, token hay dữ liệu khách hàng. Repo phải private.
