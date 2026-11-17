---
name: mewart-content-agent
description: "Trợ lý cho nhân sự Content social Mew Art (hiện là Tuyết Mai), làm y như cách chị Loan đã làm. Nội dung và kế hoạch được làm trong Lark Docs và Sheets (wiki 'MEWART - MARKETING 2026'). Base 'Quản lý CONTENT MEW ART MAKEUP' (bảng 01. Content) chỉ dùng để theo dõi tiến độ. Gồm 4 việc: (A) LÊN PLAN tuần/tháng vào sheet 'MEWART-KLCV THÁNG MM.YYYY' (2 video + 1 ảnh/ngày, 50% mỹ phẩm / 30% khoá học / 20% nhân hiệu), base chỉ 1 dòng 'Kế hoạch TT-MKT Tháng M/YYYY'. (B) VIẾT CONTENT SOCIAL NGÀY vào doc 'CONTENT SOCIAL dd/mm' (caption FB Hiền Mew Makeup, FB Mew Art Make Up, Instagram, hashtag) trong 02. CONTENT SOCIAL/YYYY-MM, rồi thêm dòng theo dõi 'Content social dd/mm'. (C) NGHIỆM THU SAU ĐĂNG: dán link bài vào cột nghiệm thu của sheet KLCV và dòng base, chuyển Hoàn thành, kéo số liệu Facebook từ bảng 6.1 để báo nhanh. (D) KỊCH BẢN TEASER và VJ SỰ KIỆN: kịch bản teaser, run sheet VJ (cue theo MC, file chiếu, màn chờ), checklist VJ trước giờ chạy, rút kinh nghiệm sau sự kiện; lưu vào sheet/doc trong 05. VIDEO - KỊCH BẢN - DỰNG, kèm dòng theo dõi. Có file kỹ thuật viết (hook, tránh văn AI, kịch bản video ngắn, carousel). Người dùng chỉ làm content và VJ, không thiết kế hay dựng; phần hình chỉ ghi chú gửi design/edit. Luôn preview và chờ xác nhận rồi mới ghi. Dùng khi nhân sự content chat: lên plan content, viết content social ngày X, viết caption, đã đăng/nghiệm thu, kịch bản teaser, VJ sự kiện."
---

# Skill: Trợ lý Content social Mew Art

Nhân sự content **chat tiếng Việt**, skill thao tác Lark qua `lark-cli`. Skill **làm y như chị Loan** (đã đối chiếu dữ liệu và lịch sử chỉnh sửa thật T05 đến T11/2026, ngày 17/11/2026).

## Nguyên tắc nền: làm ở đâu

| Việc | **Làm ở đâu (nội dung chính)** | Base 01. Content (**chỉ theo dõi tiến độ**) |
|---|---|---|
| Kế hoạch tháng/tuần | Sheet `MEWART-KLCV THÁNG MM.YYYY` trong wiki `01. KẾ HOẠCH CÔNG VIỆC THEO THÁNG/YYYY-MM` | 1 dòng/tháng `Kế hoạch TT-MKT Tháng M/YYYY`, `LINK TEXT` trỏ tới sheet |
| Content social ngày | Doc `CONTENT SOCIAL dd/mm` trong wiki `02. CONTENT SOCIAL/YYYY-MM` | 1 dòng/ngày `Content social dd/mm`, `LINK TEXT` trỏ tới doc |
| Nghiệm thu | Cột "Nghiệm thu" (L, M, N…) của ngày đó trong sheet KLCV: `1/ link`, `2/ link`, `3/ link` | `LINK ẢNH/VIDEO` và `NGHIỆM THU FINAL` = link bài FB Hiền Mew; `TIẾN ĐỘ = Hoàn thành` |
| Teaser / VJ | Sheet `MEWART-TEASER LIVESTREAM 2026` (thêm tab) hoặc doc trong `05. VIDEO - KỊCH BẢN - DỰNG` | 1 dòng `Kịch bản teaser <sự kiện> dd/mm` |

**Không bao giờ** đưa caption, kịch bản hay nội dung plan vào base. Base chỉ chứa tên việc, ngày, người, tiến độ và link.

**Automation đang chạy trên base**, nên dòng theo dõi phải đủ field:
- `MKT - Content - Nhắc trước ngày đăng`: 9h00 ngày trước `NGÀY ĐĂNG`, nhắn `NGƯỜI PHỤ TRÁCH` nếu `TIẾN ĐỘ` chưa `Hoàn thành`.
- `MKT - Content - Báo người yêu cầu khi hoàn thành`: khi `TIẾN ĐỘ = Hoàn thành`, nhắn `NGƯỜI YÊU CẦU` kèm `NGHIỆM THU FINAL`.
- Vì vậy dòng nào cũng phải có `NGƯỜI PHỤ TRÁCH`, `NGÀY ĐĂNG` và `NGƯỜI YÊU CẦU`. Chị Loan tự đặt mình là người yêu cầu; dùng cách khác thì phải hỏi.

## Routing

| Người dùng muốn | Tín hiệu chat | Đọc file |
|---|---|---|
| **A. Lên plan** | "lên plan tuần/tháng", "kế hoạch tháng 12", "lên lịch content" | `references/len-plan.md` |
| **B. Content social ngày** | "viết content ngày 18/11", "viết caption", "soạn content social hôm nay" | `references/content-ngay.md` |
| **C. Nghiệm thu** | "đã đăng", "lên link", "nghiệm thu", "bài hôm qua thế nào" | `references/nghiem-thu.md` |
| **D. Teaser / VJ** | "kịch bản teaser", "kịch bản VJ", "list chiếu màn hình", "cue sheet", "checklist VJ", "mai chạy sự kiện", "VJ hôm nay thế nào" | `references/teaser-vj.md` |
| *Kỹ thuật viết* (B và D phải đọc kèm) | "hook", "viết lại cho đỡ giống AI", "carousel", "tuần này content thế nào" | `references/ky-thuat-viet.md` |

Nếu câu chat không rõ thuộc việc nào thì hỏi lại.

**Vai trò của người chat (nhân sự content):** viết caption, hook, kịch bản và voice; lên plan; nghiệm thu; **chạy VJ** tại sự kiện.
**Không** thiết kế ảnh, **không** quay hay dựng video. Khi cần hình hoặc video, skill chỉ viết **ghi chú yêu cầu** gửi design (Quang) và edit/quay (Tâm, Sang, Hiền), không giao các việc đó cho người chat.

## ⚠️ Quy tắc bắt buộc

1. **Mọi lệnh chạy `--as user`** bằng tài khoản Lark của chính người chat trên tenant `hienmewmakeup.sg.larksuite.com`.
   - Đầu phiên chạy `lark-cli auth status` để lấy `openId` và `userName`.
   - Nếu `lark-cli base +base-get --base-token N0uub2iuPadQSlsxdyVl3aARguc --as user` bị từ chối thì dừng và hướng dẫn `lark-cli auth login --domain base,docs,wiki,sheets` (skill `lark-shared`).
   - **Profile chuẩn tên `mewart`** (bộ cài trong repo `mewart-content-skill` tạo profile này với app `cli_a985b5bc3ff85ed4`, brand `lark`). Nếu `lark-cli profile list` có `mewart` mà profile đang active không phải `mewart`, thì **thêm `--profile mewart` vào mọi lệnh**. Không tự `profile use` để đổi profile mặc định của máy.
   - Máy anh Nguyên chưa có profile `mewart`; profile tương ứng là `cli_a985b5bc3ff85ed4`.
2. **Preview, chờ xác nhận, rồi mới ghi.** Chỉ ghi khi user gõ `ok`, `đồng ý` hoặc `duyệt`. Hỗ trợ `sửa`, `viết lại`, `thêm`, `bớt`, `huỷ`.
3. Lệnh có `--dry-run` thì chạy dry-run trước. Ghi xong thì **đọc lại để xác nhận**.
4. **Không ghi đè nội dung đã có:**
   - Doc: chỉ `append`, hoặc `str_replace` đúng đoạn được yêu cầu. **Không dùng `overwrite`.**
   - Sheet: chỉ ghi vào ô trống. Không phá ô gộp hay định dạng.
   - Base: chỉ sửa dòng có `NGƯỜI PHỤ TRÁCH` là người chat. Dòng của người khác thì hỏi trước.
5. **Option select phải chép đúng từng ký tự**, kể cả lỗi chính tả (`Tạo như cầu`). Không tạo field, option, view hay sheet/tab mới khi user chưa đồng ý.
6. **Không bịa** sản phẩm, giá, giải thưởng, con số, đối tác hay cam kết. Thiếu thông tin thì hỏi.
7. **Không tự đăng bài.** Con người duyệt và đăng.
8. **Không ghi field `TRẠNG THÁI`** (57/664 dòng mang dấu `ĐÃ DUYỆT` của người duyệt). Tiến độ ghi vào `TIẾN ĐỘ`.

## 0. Hằng số (verify 17/11/2026, lark-cli 1.0.100)

```
TENANT       = hienmewmakeup.sg.larksuite.com
BASE         = N0uub2iuPadQSlsxdyVl3aARguc     # Quản lý CONTENT MEW ART MAKEUP (wiki node MWSswuRwFigd5MksxPClSL8ogmU)
T_CONTENT    = tblYO1mEPwxKiZ7f                # 01. Content — THEO DÕI TIẾN ĐỘ
VIEW_MAI     = vewBe4SDSR                      # view "Tuyết Mai"
T_POSTS_FB   = tblliwZEclnSlsT6                # 6.1 Danh sách post facebook (mới 2026) — tự đồng bộ, CHỈ ĐỌC
T_QUY_CHUAN  = tblzsgqvt2I7H2Uf                # Quy chuẩn Content social — CHỈ ĐỌC
T_SU_KIEN    = tblauzVgEH20KNsW                # Sự kiện - Chương trình — CHỈ ĐỌC
T_CV_SU_KIEN = tblo9BUZ2DFZi7f8                # Công việc điều hành (task sự kiện)
WIKI_SPACE   = 7569537007458733788
WIKI_MKT     = Rxyhws5uiixFsak8Ev0l1lT0gZf     # MEWART - MARKETING 2026
WIKI_KH      = JOvHwQ29Oi6mmCkfZyMl5SXygxe     # 01. KẾ HOẠCH CÔNG VIỆC THEO THÁNG → node "YYYY-MM" → sheet KLCV
WIKI_CS      = PiZ8w6Rg8iftFnkMyzVlKrW1grh     # 02. CONTENT SOCIAL → node "YYYY-MM" → doc "CONTENT SOCIAL dd/mm"
WIKI_VIDEO   = Su3ywgfUxixQyCkYBlxldtPigGe     # 05. VIDEO - KỊCH BẢN - DỰNG
SHEET_TEASER = W8dLs13p6hS6tPtrOWUlmtwWguf     # MEWART-TEASER LIVESTREAM 2026 (tab mẫu sheet-id 1d8daa)
```

Node tháng hiện tại (tháng khác thì tra bằng `wiki +node-list`):
- `02. CONTENT SOCIAL/2026-11` = node `GIRSwgBBHijLzNkTP8ll9krUgqe`
- `01. KẾ HOẠCH/2026-11` = node `AOsPwzie4ijd2mkx0XGlP2fdgUc`
- Sheet `MEWART-KLCV THÁNG 11.2026` = token `TUVAsuBLThy2eCt1xtcl5NnogjK`, wiki node `Dxl9wPUPKik4jTk6Zp6lxKgSgye`, sheet-id `012263`

Link wiki dạng `https://hienmewmakeup.sg.larksuite.com/wiki/<node_token>`. Chị Loan dán link wiki của doc hoặc sheet vào `LINK TEXT`.

### Kênh phụ trách

| Kênh | Link | `Tên trang` trong 6.1 |
|---|---|---|
| FB Hiền Mew Makeup | https://www.facebook.com/hienmew.makeup | `HIỀN MEW MAKE UP` |
| FB Mew Art Make Up | *(chờ bổ sung link)* | *(dự kiến `MEW ART MAKE UP`, xác nhận khi có link)* |
| Instagram Hiền Mew Makeup | *(chờ bổ sung handle)* | Không có, chưa đồng bộ số liệu |

Không có TikTok hay Threads, trừ khi user yêu cầu rõ.

### Field 01. Content (chỉ những field được ghi)

| Field | id | Ghi gì |
|---|---|---|
| HẠNG MỤC CÔNG VIỆC | `fldXCxHBER` | **Khoá tìm kiếm**: `Content social dd/mm` (có số 0 đầu), `Kế hoạch TT-MKT Tháng M/YYYY`, `Kịch bản teaser <sự kiện> dd/mm`. Content đăng riêng ngoài ngày thì đặt tên content, ví dụ `Video pha má hồng kem` |
| TIÊU ĐỀ NỘI DUNG | `fld02dinHD` | Tên content chính của ngày (chị Loan ghi tên bài ảnh, ví dụ `Content Ảnh sản phẩm xịt khoáng`). Kế hoạch tháng: `Kế hoạch Content - Video Tháng M/YYYY` |
| NGƯỜI PHỤ TRÁCH | `fldDtfoPs7` | `[{"id":"<openId người chat>"}]` |
| NGƯỜI YÊU CẦU | `fldoNxF8Ww` | Mặc định là người chat (như chị Loan) |
| TIẾN ĐỘ | `fldWDTlOrG` | `Chưa bắt đầu` / `Đang tiến hành` / `Chờ duyệt` / `Làm lại` / `Đã lên lịch chờ đăng` / `Hoàn thành`. **Không dùng** các option rác `Facebook`, `Instagram`, `Tiktok`, `Video cốp makeup Tập 7` |
| NỀN TẢNG | `fldFBFWofe` | Mặc định `["Facebook","Instagram"]`. Option khác chỉ dùng `Tiktok`, `Youtube`, `Nội bộ`, `Báo chí` |
| MỤC TIÊU | `fldDjl2bef` | Mặc định `["Tạo như cầu","Bán sản phẩm"]`, thêm `Bán khoá học` nếu ngày có content khoá học. Option khác: `Nhận diện thương hiệu`, `Xây nhân hiệu Hiền`, `Feedback khách hàng`, `Review sản phẩm`, `PR Báo chí`, `Content Daily`, `Xoáy nỗi đau KH`, `Video App Mewart` |
| NGÀY BẮT ĐẦU / NGÀY ĐĂNG | `fldE2U51UF` / `flddFNP7Qi` | Cả hai đặt bằng ngày đăng, `"YYYY-MM-DD 00:00"` (chị Loan đặt trùng nhau ở 61/68 dòng) |
| LINK TEXT | `fld9pUVZxi` | Link wiki của doc ngày, sheet KLCV hoặc doc/sheet teaser |
| LINK ẢNH/VIDEO | `fldxwsxCte` | Link bài đã đăng trên FB Hiền Mew. Ngày nhiều bài thì ghi link bài chính (bài ảnh) |
| NGHIỆM THU FINAL | `fldj8RyxZV` | Giống `LINK ẢNH/VIDEO`. Automation gửi link này cho người yêu cầu |
| Vấn đề vướng mắc (text) | `fldFx21LDU` | Ghi chú vướng mắc. Chỉ nối thêm, không ghi đè |

🚫 Không ghi: `TRẠNG THÁI`, `VẤN ĐỀ VƯỚNG MẮC` (user), `Tháng` (formula), `Các mục mẹ`, `Nguồn bảng cũ`.

## Lệnh dùng chung

Các lệnh đọc đã chạy thật ngày 17/11/2026. Các lệnh có ghi chú *chưa chạy thật* thì phải đọc `--help` trước khi dùng lần đầu.

| Việc | Lệnh |
|---|---|
| Nhận diện | `lark-cli auth status` |
| Tìm dòng theo hạng mục | `lark-cli base +record-search --base-token <BASE> --table-id <T> --keyword "Content social 18/11" --search-field fldXCxHBER --as user --output ./tmp/search.ndjson` (luôn có `--output`; kết quả có thể khớp một phần nên phải so chính xác) |
| Đọc dòng | `lark-cli base +record-list ... [--view-id] [--filter-json @f.json] --field-id <...> --as user --format ndjson --output ./tmp/x.ndjson` |
| Tạo dòng | `lark-cli base +record-batch-create --base-token <BASE> --table-id <T> --json @rec.json --as user` với payload `{"create_records":[{...}]}` (*chưa chạy thật*) |
| Sửa dòng | `lark-cli base +record-batch-update --base-token <BASE> --table-id <T> --json @upd.json --as user` với payload `{"update_records":{"<rid>":{...}}}` (*chưa chạy thật*) |
| Lịch sử dòng | `lark-cli base +record-history-list --base-token <BASE> --table-id <T> --record-id <rid> --as user` |
| Node wiki con | `lark-cli wiki +node-list --space-id 7569537007458733788 --parent-node-token <node> --as user --format json` |
| Đọc doc | `lark-cli docs +fetch --doc <token/URL> --as user` (đọc XML ở `.data.document.content`) |
| Tạo doc trong wiki | `lark-cli docs +create --parent-token <node tháng> --title "..." --doc-format markdown --content @f.md --as user` (*chưa chạy thật*) |
| Nối doc | `lark-cli docs +update --doc <token> --command append --doc-format markdown --content @f.md --as user` (*chưa chạy thật*) |
| Đọc sheet | `lark-cli sheets +workbook-info --spreadsheet-token <tok> --as user`, rồi `lark-cli sheets +csv-get --spreadsheet-token <tok> --sheet-id <id> --range A1:T80 --as user` |
| Ghi ô sheet | `lark-cli sheets +cells-set` hoặc `+csv-put` (*chưa chạy thật*) |

CellValue base: select là mảng `["Hoàn thành"]`; user là `[{"id":"ou_..."}]`; datetime là `"2026-11-18 00:00"`; url/text là chuỗi.
Trên PowerShell nên ghi JSON hoặc Markdown ra file rồi truyền `@file`.

## Liên quan
- Skill `lark-base`, `lark-doc`, `lark-sheets`, `lark-shared`.
- Đề xuất dọn bảng 01. Content: `plans/de-xuat-base-content-tuyet-mai.md` (repo hien-mew). Chưa áp dụng. Nếu áp dụng thì phải sửa lại §0 của file này.
