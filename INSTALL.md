# INSTALL: hướng dẫn cài đặt cho AI agent

> **Dành cho AI agent** (OpenCode, Claude Code, Codex…) khi người dùng dán link repo này và nói "cài giúp".
> Làm lần lượt từng bước. Báo tiến độ bằng **tiếng Việt, câu ngắn, không thuật ngữ**, vì người dùng là nhân sự mới.
> Chạy lại nhiều lần cũng không hỏng gì.

**Giả định:** máy đã có `lark-cli` **được cấu hình sẵn** cho Lark Mewart (`hienmewmakeup.sg.larksuite.com`).

## Quy tắc khi cài
1. Không đổi cấu hình lark-cli có sẵn (không đổi hay xoá profile).
2. Không in ra hay lưu token. Không yêu cầu người dùng dán mật khẩu hay mã vào ô chat.
3. Máy chưa có `lark-cli`: **dừng**, báo người dùng nhờ anh Nguyên cài và cấu hình. Không tự cấu hình app.
4. Cài xong thì nhắc người dùng **khởi động lại** OpenCode hoặc Claude Code.

## Bước 1. Lấy repo về máy
```bash
git clone https://github.com/diginno-net/mewart-content-skill.git "$HOME/mewart-content-skill"
```
- Đã có repo thì chạy `git -C "$HOME/mewart-content-skill" pull`.
- Chưa có `git`: Windows dùng `winget install --id Git.Git -e --silent`, macOS dùng `xcode-select --install`.
- Clone báo lỗi quyền (repo private): nhờ người dùng chạy `gh auth login` bằng tài khoản GitHub đã được mời vào repo. Nếu không có tài khoản, xin anh Nguyên file zip rồi giải nén vào `~/mewart-content-skill`.

## Bước 2. Chạy bộ cài
Bộ cài làm các việc sau:
- Sao lưu bản skill cũ, copy skill vào `~/.claude/skills/mewart-content-agent`.
- Kiểm tra `lark-cli` có sẵn.
- Tìm profile lark-cli vào được base content (ưu tiên profile mặc định).

Lệnh chạy:
- **Windows:** `powershell -ExecutionPolicy Bypass -File "$HOME\mewart-content-skill\scripts\install.ps1"`
- **macOS/Linux:** `bash "$HOME/mewart-content-skill/scripts/install.sh"`

| Tiền tố | Làm gì |
|---|---|
| `[OK]` | Không cần làm gì |
| `[CẦN LÀM] Đăng nhập Lark` | Sang bước 3 |
| `[CẦN LÀM] … chưa vào được base content` | Thử bước 3 (đăng nhập lại). Vẫn lỗi thì nhờ quản lý share base **Quản lý CONTENT MEW ART MAKEUP** và wiki **MEWART - MARKETING 2026** (quyền chỉnh sửa) |
| `[LỖI] …` | Báo nguyên văn cho người dùng, dừng |
| `[XONG]` | Sang bước 4 |

Skill ở `~/.claude/skills` dùng được cho OpenCode và Claude Code. Agent khác (ví dụ Codex đọc `~/.codex/skills` hoặc `~/.agents/skills`) thì copy thêm thư mục skill sang đó.

## Bước 3. Đăng nhập Lark (chỉ khi bộ cài yêu cầu)
Dùng lark-cli **đang có** trên máy:
```bash
lark-cli auth login --domain base,docs,wiki,sheets,drive --no-wait --json
```
- Gửi người dùng link xác thực (verification URL) trong kết quả: *"Em bấm link này, đăng nhập Lark Mewart, chọn Đồng ý, xong báo lại nhé."* Rồi kết thúc lượt chat và chờ.
- Khi người dùng báo xong, chạy `lark-cli auth login --device-code <device_code>`.
- Máy có nhiều profile thì thêm `--profile <tên profile của tenant Mewart>`. Xem bằng `lark-cli profile list` (profile đang đăng nhập tài khoản Lark Mewart).

Sau đó chạy lại bước 2.

## Bước 4. Bàn giao
1. Báo người dùng: "Cài xong rồi. Em **tắt và mở lại** OpenCode nhé."
2. Thử gõ: `Kiểm tra giúp chị đã vào được base content chưa`.
3. Đưa đường dẫn hướng dẫn sử dụng: `~/mewart-content-skill/docs/huong-dan-su-dung.md`.

## Cập nhật
Chạy `git -C "$HOME/mewart-content-skill" pull`, rồi chạy lại bước 2.

## Gỡ cài đặt
Xoá thư mục `~/.claude/skills/mewart-content-agent`. Không đụng lark-cli.
