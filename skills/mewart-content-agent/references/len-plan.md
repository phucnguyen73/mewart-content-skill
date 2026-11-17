Phần này thuộc skill mewart-content-agent. Hằng số và field xem §0 trong SKILL.md.

# Flow A: Lên plan tuần/tháng (làm trong SHEET KLCV)

Kế hoạch nằm trong sheet `MEWART-KLCV THÁNG MM.YYYY` (wiki `01. KẾ HOẠCH CÔNG VIỆC THEO THÁNG/YYYY-MM`), như chị Loan làm.
Base chỉ có **1 dòng theo dõi mỗi tháng**: `Kế hoạch TT-MKT Tháng M/YYYY`.

## 1. Cấu trúc sheet KLCV (đọc từ sheet tháng 11/2026)
- **Hàng 1:** `MEWART - KẾ HOẠCH CÔNG VIỆC THÁNG MM/YYYY`.
- **Hàng 2–3: khung tháng.**
  - Header hàng 2: `STT | Nội dung phân bổ theo Tỷ trọng Doanh thu ngành hàng | Khách hàng mục tiêu | Mục tiêu | | Chủ đề chính | | Số lượng | Kênh | Nhân sự | Chi phí sản xuất`.
  - Hàng 3 là nội dung: tỷ trọng **50% mỹ phẩm / 30% khoá học / 20% nhân hiệu-brand-lifestyle**; khách hàng 21–30 và 31–45; mục tiêu (sự kiện phường, nhân hiệu Hiền, thương hiệu Mewart, khoá 1:1 và khoá video qua App); chủ đề chính; sản lượng **2 video + 1 ảnh/text mỗi ngày** (60 video + 30 ảnh/tháng); kênh; nhân sự.
- **Khối tuần**, lặp lại cho từng tuần:
  - Hàng tiêu đề: `TUẦN N (TỪ NGÀY dd/mm - dd/mm)`.
  - Hàng header: `Thứ | Ngành hàng | Loại content | Tiêu đề/Chủ đề | … | Kênh | Thời gian đăng | Nhân sự | Chi phí sản xuất (VNĐ) | Nghiệm thu`.
  - Mỗi ngày 1 hàng:

| Cột | Nội dung | Ví dụ |
|---|---|---|
| A | Thứ | `2`…`7`, `CN` |
| B | Ngành hàng | `Mỹ phẩm + Khoá học` |
| C | Loại content | `Video\nẢnh + Text` |
| D (gộp D:G) | Tiêu đề/Chủ đề | `1/ …\n2/ …\n3/ …` |
| H | Kênh | `Facebook\nTiktok\nInstagram\nYoutube Shorts` |
| I | Thời gian đăng | `10h00\n16h00\n20h00` |
| J | Nhân sự | `Loan\nQuang Design\nTâm Edit` |
| K | Chi phí sản xuất | |
| L, M, N | Nghiệm thu | `1/ link`, `2/ link`, `3/ link` (Flow C điền) |

- **Khung tuần đã kẻ sẵn từ đầu tháng.** Ngày chưa plan thì ô D là `1/ \n2/ \n3/` (trống sau dấu `/`), ô L/M/N là `1/`, `2/`, `3/`. **Lên plan nghĩa là điền vào các ô đó**, không chèn thêm hàng.
- Content số 1 thường là **ảnh**, số 2 và 3 là **video** (khớp với 10h ảnh, 16h và 20h video).

## 2. Đọc bối cảnh (chỉ đọc)
1. `lark-cli auth status`.
2. Tìm sheet tháng: `wiki +node-list` dưới `WIKI_KH`, lấy node `YYYY-MM`, rồi lấy sheet `MEWART-KLCV THÁNG ...` (dùng `obj_token`). Tiếp theo `sheets +workbook-info` để lấy sheet-id, và `+csv-get --range A1:N60`.
3. Xác định các hàng ngày cần plan và ô D nào còn trống. **Ô D đã có nội dung thì không đổi**, trừ khi user yêu cầu sửa đúng ngày đó.
4. Đọc bảng `Sự kiện - Chương trình` để chèn content sự kiện (ảnh sự kiện, recap, phỏng vấn, cảm ơn nhà tài trợ) vào đúng ngày.
5. Xem 1–2 tuần trước trong sheet để nối mạch series (ví dụ `Video cốp makeup Tập 8` thì tập tiếp theo là 9) và tránh lặp sản phẩm.

## 3. Hỏi phạm vi nếu chưa rõ
- Plan tuần nào hoặc những ngày nào.
- Có đổi khung tháng không (mặc định theo hàng 3).
- Sản phẩm, chiến dịch hay chương trình cần đẩy (vòng quay may mắn, webinar, khoá E-learning, sản phẩm mới).
- Cột Nhân sự (J) ghi tên ai. Mặc định thay `Loan` bằng tên người chat, giữ nguyên design và edit như hàng 3 (ví dụ `Mai\nQuang Design\nTâm Edit`).

## 4. Bộ não sinh plan
Các tuyến đang chạy thật trong T10–T11/2026:
- **Ảnh mỹ phẩm:** `Ảnh sản phẩm <tên SP>`. Ví dụ đã đăng: cushion DERMASHARE, phấn phủ JUNGSEAMMOOL, bông phấn/dao cạo AMORTALS, chì kẻ mày PINKPUNK, kem nâng tone KyungLab, xịt khoáng, bảng mắt hồng.
- **Video tutorial tone/độ tuổi:** `Video tone hồng đỏ trẻ tuổi/trung tuổi`, `Video tone cam sữa`, `Video tone hồng cam Douyin`, `Video Hàn áo dài lễ tân`.
- **Series:** `Video cốp makeup Tập N`, `Video N sự kiện trang điểm cộng đồng`.
- **Sự kiện cộng đồng:** `Ảnh sự kiện <địa điểm> <ngày>`, `Recap video sự kiện`, `Lời cảm ơn của Hội phụ nữ phường`, `Ảnh nhà tài trợ sự kiện <tên>`.
- **Khoá học / app:** `Ảnh banner khoá video 44 video`, `Video makeup QC E-learning`, `Ảnh zoom giảng viên`, feedback học viên.
- **Nhân hiệu / chương trình:** chúc mừng khách trúng giải vòng quay, `Ảnh có hẹn với MEWART`, share link báo chí, banner kêu gọi hợp tác.

Quy tắc:
- Mỗi ngày 3 content: `1/` ảnh, `2/` và `3/` video.
- Tỷ trọng cả kỳ gần 50/30/20. Không lặp một sản phẩm trong 3 ngày liền.
- **Không bịa** sản phẩm hay chương trình. Nếu chưa chắc thì ghi `[SP cần xác nhận]` và hỏi.

## 5. Preview (bắt buộc)
In bảng đúng như sẽ hiện trong sheet:

| Hàng sheet | Ngày | Thứ | B Ngành hàng | D Tiêu đề/Chủ đề | H Kênh | I Giờ | J Nhân sự |
|---|---|---|---|---|---|---|---|
| 28 | 19/11 | 5 | Mỹ phẩm + Khoá học | 1/ Ảnh sản phẩm … / 2/ Video … / 3/ Video … | Facebook, Instagram… | 10h00, 16h00, 20h00 | Mai, Quang Design, Tâm Edit |

Kèm phần tổng kết:
- Số ngày, số ảnh và số video.
- Tỷ trọng ngành hàng so với 50/30/20.
- Các ngày bỏ qua vì đã có nội dung.
- Danh sách **ô sẽ ghi** (ví dụ `D28, B28, C28, H28, I28, J28`).

## 6. Cổng xác nhận
Hỗ trợ: `sửa 19/11 2/ thành …`, `bớt ngày …`, `đổi tỷ lệ …`, `huỷ`. Sửa xong thì in lại. Chỉ ghi khi user gõ `ok`, `đồng ý` hoặc `duyệt`.

## 7. Ghi
**(a) Sheet:** chỉ ghi các ô B, C, D, H, I, J của hàng ngày cần plan, mà ô đó đang trống hoặc chỉ có placeholder `1/ 2/ 3/`. Không đụng L, M, N (cột nghiệm thu) và không đụng ô gộp.
- Đọc `lark-cli sheets +cells-set --help` trước (*chưa chạy thật*) để đúng cú pháp ghi nhiều ô, hoặc dùng `+batch-update` khi ghi nhiều vùng.
- Ghi xong thì `+csv-get` lại đúng các hàng đó để xác nhận.

**(b) Base, chỉ khi tháng chưa có dòng theo dõi:** tìm `Kế hoạch TT-MKT Tháng M/YYYY` trong `HẠNG MỤC`. Nếu chưa có thì tạo:
```json
{"create_records":[{
  "HẠNG MỤC CÔNG VIỆC":"Kế hoạch TT-MKT Tháng 12/2026",
  "TIÊU ĐỀ NỘI DUNG":"Kế hoạch Content - Video Tháng 12/2026",
  "NGƯỜI PHỤ TRÁCH":[{"id":"<openId>"}], "NGƯỜI YÊU CẦU":[{"id":"<openId>"}],
  "TIẾN ĐỘ":["Đang tiến hành"], "NỀN TẢNG":["Facebook","Instagram"],
  "NGÀY BẮT ĐẦU":"<ngày lập>", "NGÀY ĐĂNG":"<hạn chốt plan>",
  "LINK TEXT":"https://hienmewmakeup.sg.larksuite.com/wiki/<node sheet KLCV>"
}]}
```
Khi plan cả tháng đã chốt thì chuyển `TIẾN ĐỘ` sang `Hoàn thành` (user xác nhận). Lưu ý automation sẽ báo cho người yêu cầu.

## 8. Tháng mới chưa có sheet
Chị Loan tạo **mỗi tháng 1 sheet**, nằm dưới node tháng `YYYY-MM` của `01. KẾ HOẠCH`. Nếu chưa có:
1. Báo user và đề xuất: tạo node tháng (nếu thiếu), rồi **copy sheet tháng trước** bằng `lark-cli wiki +node-copy` vào node tháng mới (*chưa chạy thật*; đọc `--help` trước). Sau đó đổi tiêu đề sheet và hàng 1 thành tháng mới.
2. Trên bản copy: cập nhật hàng 3 (khung tháng, cần hỏi user mục tiêu và chủ đề tháng mới), kẻ lại khối tuần theo lịch tháng mới. **Xoá nội dung cũ trong các khối tuần chỉ trên bản copy**, và chỉ sau khi user xác nhận danh sách vùng sẽ xoá.
3. Mỗi bước tạo hoặc copy đều phải preview và chờ xác nhận. **Không bao giờ sửa sheet của tháng cũ.**

## 9. Giới hạn
- Nội dung plan **chỉ ghi vào sheet**. Base chỉ có 1 dòng theo dõi mỗi tháng.
- Không ghi đè ô đã có nội dung, không đổi định dạng hay ô gộp, không đụng cột nghiệm thu.
