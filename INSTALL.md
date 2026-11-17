# INSTALL: hướng dẫn cài đặt cho AI agent

> **Dành cho AI agent** (OpenCode, Claude Code, Codex…) khi người dùng dán link repo này và nói "cài giúp".
> Làm **lần lượt từng bước**. Báo tiến độ cho người dùng bằng **tiếng Việt, câu ngắn, không thuật ngữ**. Người dùng có thể là nhân sự mới, không rành kỹ thuật.
> Mọi bước đều idempotent: chạy lại không hỏng gì.

## Quy tắc khi cài
1. **Không bao giờ** in ra, lưu vào file, commit hay gửi App Secret, token, OTP. Không yêu cầu người dùng dán secret vào ô chat. Secret chỉ được nhập ở **bước 4**, trong cửa sổ terminal của chính người dùng.
2. **Không** đổi hoặc xoá profile `lark-cli` có sẵn của máy. Không chạy `lark-cli profile use` hay `profile remove`. Chỉ thêm profile tên `mewart`.
3. Lệnh cần quyền admin (winget, sudo) bị từ chối thì dừng và nói rõ cần ai làm gì. Không lặp lại lệnh.
4. Cài xong thì nhắc người dùng **khởi động lại** OpenCode hoặc Claude Code.

## Bước 1. Lấy repo về máy
Nếu chưa có repo:
```bash
git clone <URL repo này> "$HOME/mewart-content-skill"
```
- Máy chưa có `git`: Windows dùng `winget install --id Git.Git -e --silent`, macOS dùng `xcode-select --install` hoặc `brew install git`.
- Repo private mà clone báo lỗi quyền: nhờ người dùng đăng nhập GitHub (`gh auth login`) bằng tài khoản đã được mời vào repo. Nếu không có tài khoản thì xin bản zip từ anh Nguyên rồi giải nén vào `~/mewart-content-skill`.
- Đã có repo thì chạy `git -C "$HOME/mewart-content-skill" pull` để cập nhật.

## Bước 2. Chạy bộ cài
Bộ cài tự cài Node.js ≥ 18 và `lark-cli` nếu thiếu, sao lưu bản skill cũ, copy skill vào `~/.claude/skills/mewart-content-agent`, rồi kiểm tra đăng nhập.

- **Windows (PowerShell):**
  ```powershell
  powershell -ExecutionPolicy Bypass -File "$HOME\mewart-content-skill\scripts\install.ps1"
  ```
- **macOS / Linux:**
  ```bash
  bash "$HOME/mewart-content-skill/scripts/install.sh"
  ```

Đọc các dòng kết quả:

| Tiền tố | Nghĩa |
|---|---|
| `[OK]` | Đã có hoặc đã xong |
| `[CÀI]` | Đang cài |
| `[CẦN LÀM] …` | Làm bước tương ứng bên dưới |
| `[LỖI] …` | Báo người dùng đúng nội dung lỗi, dừng |
| `[XONG]` | Hoàn tất, sang bước 6 |
| `[CÒN] …` | Danh sách việc còn thiếu |

Nếu Node vừa được cài mà vẫn báo không thấy, thì **mở terminal mới** (PATH chưa cập nhật) rồi chạy lại bước 2.

## Bước 3. Skill có được agent đọc không
Skill nằm ở `~/.claude/skills/mewart-content-agent/SKILL.md`. OpenCode và Claude Code đều đọc thư mục này.
Nếu agent đang dùng **chỉ** đọc chỗ khác (ví dụ Codex đọc `~/.codex/skills` hoặc `~/.agents/skills`), thì copy thêm thư mục skill sang đó. Không xoá bản ở `~/.claude/skills`.

## Bước 4. Tạo profile Lark `mewart` (cần App Secret, người dùng tự nhập)
Chỉ làm khi bộ cài báo `[CẦN LÀM] Tạo profile Lark 'mewart'`.

1. Nói với người dùng: *"Em cần mã bí mật (App Secret) của app Lark Mewart. Em xin anh Nguyên qua tin nhắn riêng, đừng dán vào đây nhé."*
2. Đưa người dùng **một lệnh** để **tự mở terminal mới và dán vào**. Agent không tự chạy lệnh này, vì nó chờ nhập secret.
   - **Windows:** bấm Start, gõ `PowerShell`, mở, dán:
     ```powershell
     $s = Read-Host "Dan App Secret roi bam Enter" -AsSecureString; [Net.NetworkCredential]::new('', $s).Password | lark-cli config init --name mewart --app-id cli_a985b5bc3ff85ed4 --brand lark --app-secret-stdin; Remove-Variable s
     ```
   - **macOS:** mở Terminal, dán:
     ```bash
     read -s -p "Dan App Secret roi bam Enter: " S; echo; printf %s "$S" | lark-cli config init --name mewart --app-id cli_a985b5bc3ff85ed4 --brand lark --app-secret-stdin; unset S
     ```
3. Khi người dùng báo xong, kiểm tra bằng `lark-cli profile list`: phải có `"name": "mewart"`. Chỉ đọc kết quả, không in secret.

## Bước 5. Đăng nhập Lark bằng tài khoản của người dùng
Chỉ làm khi bộ cài báo `[CẦN LÀM] Đăng nhập Lark`.
```bash
lark-cli --profile mewart auth login --domain base,docs,wiki,sheets,drive --no-wait --json
```
- Lấy link xác thực (verification URL) trong kết quả và gửi cho người dùng: *"Em bấm link này, đăng nhập Lark Mewart, bấm Đồng ý / Authorize, xong báo lại nhé."*
- Kết thúc lượt chat và chờ. Khi người dùng báo xong, chạy:
  ```bash
  lark-cli --profile mewart auth login --device-code <device_code từ kết quả trên>
  ```
- Báo lỗi app chưa khả dụng, hoặc người dùng không thấy app: nhờ quản trị Lark Mewart thêm người dùng vào **phạm vi khả dụng (availability)** của app `cli_a985b5bc3ff85ed4`.

## Bước 6. Kiểm tra lần cuối
Chạy lại bộ cài ở chế độ chỉ kiểm tra:
- Windows: `powershell -ExecutionPolicy Bypass -File "$HOME\mewart-content-skill\scripts\install.ps1" -VerifyOnly`
- macOS/Linux: `bash "$HOME/mewart-content-skill/scripts/install.sh" --verify-only`

Phải ra `[XONG]`. Nếu ra `[CẦN LÀM] … chưa có quyền vào base content`: nhờ quản lý (chị Hà / anh Nguyên) share cho tài khoản này base **Quản lý CONTENT MEW ART MAKEUP** và wiki **MEWART - MARKETING 2026** với quyền **chỉnh sửa**.

## Bước 7. Bàn giao cho người dùng
Nói ngắn gọn:
1. Cài xong. **Tắt rồi mở lại** OpenCode hoặc Claude Code.
2. Thử gõ: `Kiểm tra giúp chị đã vào được base content chưa`.
3. Hướng dẫn sử dụng: `docs/huong-dan-su-dung.md` trong repo. Đưa đường dẫn đầy đủ trên máy.

## Cập nhật phiên bản mới
```bash
git -C "$HOME/mewart-content-skill" pull
```
Sau đó chạy lại bước 2. Bộ cài tự sao lưu bản cũ vào `~/.claude/skills/.backup/`. Profile và đăng nhập đã có thì giữ nguyên.

## Gỡ cài đặt
- Xoá thư mục `~/.claude/skills/mewart-content-agent`.
- Nếu muốn xoá cả profile Lark: `lark-cli profile remove mewart`. **Chỉ làm khi người dùng yêu cầu rõ.**
