# mewart-content-skill

Trợ lý AI cho nhân sự **Content social của Mew Art (Hiền Mew Makeup)**. Trợ lý làm theo đúng quy trình team đang dùng trên Lark:

| Việc | Làm ở đâu |
|---|---|
| Lên plan tuần/tháng | Sheet `MEWART-KLCV THÁNG MM.YYYY` |
| Viết caption hằng ngày (FB Hiền Mew Makeup, FB Mew Art Make Up, Instagram) | Doc `CONTENT SOCIAL dd/mm` |
| Nghiệm thu sau khi đăng, xem nhanh số liệu Facebook | Sheet KLCV + base theo dõi |
| Kịch bản teaser, kịch bản VJ, checklist VJ sự kiện | Sheet teaser / doc trong `05. VIDEO - KỊCH BẢN - DỰNG` |

Base **Quản lý CONTENT MEW ART MAKEUP** chỉ dùng để theo dõi tiến độ.
AI **luôn cho xem trước** và **chỉ ghi khi người dùng gõ `ok`**. AI không tự đăng bài, không thiết kế hay dựng video.

---

## Cài đặt: chỉ cần dán link cho AI

Mở **OpenCode** hoặc **Claude Code** trên máy, dán câu sau rồi bấm Enter:

```
Cài giúp tôi skill từ repo này, làm theo file INSTALL.md trong repo: <link repo này>
```

AI sẽ tự tải repo, cài skill và kiểm tra lark-cli trên máy đã vào được base content chưa.
Người dùng chỉ cần làm thêm một việc, nếu Lark chưa đăng nhập hoặc đã hết hạn: **bấm link đăng nhập** AI gửi, rồi chọn **Đồng ý**.

Xong thì **tắt và mở lại** OpenCode/Claude Code.

> Chi tiết từng bước cho AI: [`INSTALL.md`](INSTALL.md).
> Cách dùng hằng ngày: [`docs/huong-dan-su-dung.md`](docs/huong-dan-su-dung.md).

### Cần có trước
- Máy Windows 10/11 hoặc macOS, có mạng.
- Đã cài **OpenCode** hoặc **Claude Code** (AI dùng để cài).
- Đã có **lark-cli** đăng nhập tài khoản Lark Mewart.
- Tài khoản Lark của Mewart (`hienmewmakeup.sg.larksuite.com`) đã được share base **Quản lý CONTENT MEW ART MAKEUP** và wiki **MEWART - MARKETING 2026** với quyền chỉnh sửa.
- Tài khoản GitHub đã được mời vào repo (nếu repo private).

### Cài tay (không dùng AI)
```powershell
# Windows
git clone <link repo> "$HOME\mewart-content-skill"
powershell -ExecutionPolicy Bypass -File "$HOME\mewart-content-skill\scripts\install.ps1"
```
```bash
# macOS
git clone <link repo> ~/mewart-content-skill
bash ~/mewart-content-skill/scripts/install.sh
```
Nếu bộ cài báo cần đăng nhập Lark thì làm bước 3 trong [`INSTALL.md`](INSTALL.md).

---

## Cấu trúc repo

```
skills/mewart-content-agent/   Skill (copy vào ~/.claude/skills/)
  SKILL.md                     Quy tắc, hằng số base/wiki, routing
  references/
    len-plan.md                Lên plan vào sheet KLCV
    content-ngay.md            Viết doc CONTENT SOCIAL + dòng theo dõi
    nghiem-thu.md              Nghiệm thu + số liệu Facebook (bảng 6.1)
    teaser-vj.md               Kịch bản teaser, run sheet VJ, checklist VJ
    ky-thuat-viet.md           Hook, tránh văn AI, kịch bản video ngắn, carousel
scripts/install.ps1|.sh        Bộ cài (copy skill, kiểm tra lark-cli và quyền vào base)
docs/huong-dan-su-dung.md      Hướng dẫn cho nhân sự content
INSTALL.md                     Các bước cài dành cho AI agent
```

## Bảo mật
- Repo **không chứa** token hay mật khẩu. Repo có ID base/wiki nội bộ Mewart, nên **giữ repo ở chế độ private**.

## Trạng thái kiểm thử (17/11/2026)
- Các lệnh **đọc** (base, wiki, doc, sheet, bảng số liệu 6.1) đã chạy thật trên dữ liệu Mewart.
- Các lệnh **ghi** (tạo doc, ghi sheet, tạo/sửa dòng base) **chưa chạy thật**. Lần dùng đầu nên làm thử cùng người hướng dẫn.
- Bộ cài `install.ps1` đã chạy chế độ kiểm tra trên máy dev. `install.sh` chưa chạy trên macOS.

## Ghi nguồn
`references/ky-thuat-viet.md` có chắt lọc và Việt hoá từ [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) và [sergebulaev/instagram-skills](https://github.com/sergebulaev/instagram-skills) (cả hai dùng MIT License).
