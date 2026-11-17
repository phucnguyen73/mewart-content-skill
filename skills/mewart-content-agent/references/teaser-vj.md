Phần này thuộc skill mewart-content-agent. Hằng số và field xem §0 trong SKILL.md. Kỹ thuật viết hook và voice xem `ky-thuat-viet.md` §1, §5.

# Flow D: Kịch bản teaser và VJ sự kiện

Nhân sự content **viết kịch bản teaser** và **chạy VJ** (điều khiển hình ảnh và video trên màn LED/máy chiếu) tại sự kiện.
Phần quay, thiết kế và dựng là việc của người khác (Hiền quay, Quang design, Tâm/Sang edit). Skill chỉ viết **ghi chú yêu cầu** gửi họ.

Flow này gồm 4 việc con. Đọc câu chat để chọn đúng việc:

| Việc con | Tín hiệu chat | Output |
|---|---|---|
| D1. Kịch bản teaser | "kịch bản teaser", "teaser mở đầu live", "video giới thiệu sự kiện" | Bảng kịch bản STT/PHẦN/THỜI GIAN/VOICE/VISUAL/ÂM THANH, kèm ghi chú gửi quay/edit |
| D2. Kịch bản VJ (run sheet) | "lên kịch bản VJ", "list chiếu màn hình", "cue sheet" | Bảng chạy màn hình theo từng phân đoạn chương trình |
| D3. Checklist VJ trước giờ chạy | "chuẩn bị VJ", "checklist VJ", "mai chạy sự kiện" | Danh sách file + kiểm tra kỹ thuật + phương án dự phòng |
| D4. Rút kinh nghiệm sau sự kiện | "VJ hôm nay thế nào", "ghi lại sự cố VJ" | Ghi chú sự cố và bài học, gợi ý content tái sử dụng (`ky-thuat-viet.md` §6) |

## 1. Thu thông tin (chỉ đọc)
- **Sự kiện:** bảng `Sự kiện - Chương trình` (`tblauzVgEH20KNsW`). Các field: `Tên sự kiện`, `Ngày diễn ra`, `Địa điểm`, `Số lượng học viên`, `Trạng thái`, `Ghi chú`. Nếu khớp nhiều sự kiện thì hỏi user chọn.
- **Task của người chat:** bảng `Công việc điều hành` (`tblo9BUZ2DFZi7f8`). Lọc theo sự kiện và theo người phụ trách là người chat. Các field: `Công việc`, `Hạng mục`, `Giai đoạn` (Chuẩn bị trước chương trình / Thiết kế - In ấn - Vật phẩm / Ngày chạy / Sau chương trình), `Deadline`, `Trạng thái`, `Nghiệm thu`. **Các task khác trong cùng sự kiện** (MC, quà, minigame, nhà tài trợ) dùng để dựng thứ tự chương trình cho D2.
- **Mẫu teaser:** sheet `SHEET_TEASER`, tab mẫu sheet-id `1d8daa`, đọc bằng `+csv-get --range A1:F20`.
- **Kịch bản chương trình (MC/run-of-show)** nếu có thì hỏi user link doc hoặc sheet. D2 phải bám đúng thứ tự này.
- **Hỏi user nếu thiếu:**
  - Teaser: thời lượng, mục đích, nơi chiếu (màn LED 16:9 hay social 9:16), tư liệu đang có, đối tác/nhà tài trợ cần xuất hiện.
  - VJ: giờ bắt đầu, có MC không, loại màn (LED, máy chiếu, TV), phần mềm hoặc máy chạy (laptop + PowerPoint/Resolume/VLC…), có âm thanh qua bàn mixer không, ai bấm nhạc.

## 2. D1. Kịch bản teaser
Dùng đúng cột của mẫu: **STT | PHẦN | THỜI GIAN | VOICE ĐỌC | VISUAL | ÂM THANH**.
Đầu kịch bản ghi 3 dòng: **Thời lượng**, **Mục đích**, **Tone & Mood**.

Khung (co giãn theo thời lượng):
1. **Nỗi đau** (~15%): mua nhiều mỹ phẩm nhưng makeup chưa đẹp, nền mốc, xuống tone, thiếu tự tin.
2. **Bước ngoặt / giải pháp** (~25%): Hiền Mew và MEWART, makeup cá nhân hoá, "Giá trị thật - Ứng dụng thật - Đồng hành thật".
3. **Bằng chứng** (~25%): lớp học, before/after, feedback, báo chí (Afamily, Eva, Phunuvietnam), con số. **Chỉ dùng số user hoặc tài liệu đưa.**
4. **Sự kiện / CTA** (~25%): tên chương trình, ngày, địa điểm, quyền lợi, đối tác.
5. **Kết** (~10%): logo MEWART, slogan, lời cảm ơn.

Quy tắc:
- Voice theo `ky-thuat-viet.md` §5: câu ≤ 15 chữ, khoảng 3 chữ mỗi giây. **Mốc thời gian phải cộng đúng bằng tổng thời lượng.**
- Cột VISUAL ghi **ghi chú cho người quay/edit**: cảnh, góc, chữ trên màn, logo.
- Cam kết như "hoàn tiền 100%" chỉ đưa vào khi user xác nhận chương trình đó còn áp dụng.

Cuối kịch bản in thêm:
- **Danh sách tư liệu cần có**: cảnh quay, ảnh, logo đối tác, kèm người phụ trách gợi ý (Hiền quay / Quang design / Tâm edit).
- **Bản xuất cần cho VJ**: tên file, tỷ lệ 16:9, có hoặc không có nhạc. Ví dụ `01_teaser_sukien-1711_16x9_conhac.mp4`.

## 3. D2. Kịch bản VJ (run sheet)
Mỗi phân đoạn của chương trình là 1 dòng:

| STT | Giờ | Phân đoạn | Tín hiệu bắt đầu (cue) | Nội dung trên màn | Loại | Âm thanh | Thời lượng | Hết thì chuyển sang | Ghi chú |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 13:30 | Đón khách | Mở cửa | `00_loop_slide-nha-tai-tro.mp4` | Video loop | Nhạc nền nhỏ | đến 14:00 | 2 | Kiểm tra loop không giật |
| 2 | 14:00 | Teaser mở màn | MC nói "Xin mời cả hội trường cùng theo dõi…" | `01_teaser_…_16x9.mp4` | Video | Âm thanh video | 0:45 | 3 | Tắt nhạc nền trước khi bấm |
| 3 | 14:01 | MC khai mạc | Teaser hết | `02_key-visual.png` | Ảnh tĩnh | — | ~5' | 4 | |

Quy tắc:
- **Cột "Tín hiệu bắt đầu" là quan trọng nhất**: câu nói của MC, hành động trên sân khấu hoặc giờ cụ thể. VJ bấm theo tín hiệu, không bấm theo cảm giác.
- **Đặt tên file theo số thứ tự chạy** (`00_`, `01_`, `02_`…) để kéo vào playlist đúng thứ tự.
- Giữa các phân đoạn luôn có **màn chờ** (key visual hoặc logo) để màn không bao giờ đen hay hiện desktop.
- Minigame, quay số: ghi rõ màn hiển thị (vòng quay, đồng hồ đếm ngược, tên người trúng) và **ai nhập kết quả**.
- Phần chuyên môn hoặc demo makeup: nếu chiếu camera trực tiếp thì ghi nguồn (HDMI cam, OBS…) và cách chuyển qua lại giữa camera và slide.
- Không có kịch bản MC thì đề xuất thứ tự mặc định: đón khách → khai mạc → teaser → phát biểu → chia sẻ chuyên môn/demo → minigame/quay số → trao quà, cảm ơn nhà tài trợ → chụp ảnh chung → kết thúc (logo + nhạc). **Phải đánh dấu "cần xác nhận với MC/điều phối".**

## 4. D3. Checklist VJ trước giờ chạy
In checklist để người chat tick. Không ghi checklist vào base, trừ khi user yêu cầu lưu.

**Hôm trước:**
- [ ] Đủ toàn bộ file theo run sheet, đúng tên `NN_…`, đã xem hết từng file.
- [ ] Video đúng tỷ lệ của màn (16:9, hoặc độ phân giải màn LED được ban tổ chức báo).
- [ ] Copy **2 bản**: trên laptop VJ và trên USB dự phòng. Nếu có thể thì thêm một bản trên Drive.
- [ ] Playlist hoặc slide đã xếp đúng thứ tự, chuyển cảnh không lộ desktop.
- [ ] Gửi run sheet cho MC và người phụ trách âm thanh, thống nhất các câu cue.

**Tại địa điểm (trước giờ chạy 60–90 phút):**
- [ ] Cắm HDMI vào màn, chạy thử 3 file: đầu, giữa, cuối.
- [ ] Kiểm tra âm thanh video qua loa hội trường và mức âm lượng.
- [ ] Tắt thông báo, sleep, cập nhật hệ điều hành trên laptop. Cắm sạc.
- [ ] Chế độ màn hình **mở rộng (extend)**: màn LED chỉ hiện nội dung, laptop thấy playlist.
- [ ] Mở sẵn màn chờ (key visual) trước khi khách vào.
- [ ] Biết nút tắt màn khẩn cấp (chuyển về màn chờ).

**Dự phòng sự cố:**
| Sự cố | Xử lý |
|---|---|
| Video lỗi hoặc giật | Chuyển ngay về màn chờ, chạy lại từ USB dự phòng; nếu vẫn lỗi thì bỏ qua và báo MC |
| Mất âm thanh video | Báo âm thanh; MC đọc thay phần voice chính nếu cần |
| Laptop treo | Màn chờ dự phòng chạy từ máy hoặc USB thứ hai |
| Chương trình đổi thứ tự | Theo MC; đánh dấu phân đoạn bị đổi trên run sheet để rút kinh nghiệm |

## 5. D4. Sau sự kiện
- Hỏi user các sự cố, phân đoạn bị trễ, file thiếu. Ghi lại thành mục "Bài học VJ" ở cuối doc hoặc tab VJ của sự kiện (append, phải xác nhận).
- Gợi ý danh sách content tái sử dụng từ sự kiện (`ky-thuat-viet.md` §6) để đưa vào plan tuần sau (Flow A).
- Nếu có task VJ/teaser của người chat trong `Công việc điều hành` thì đề xuất cập nhật `Trạng thái = Hoàn thành` và `Nghiệm thu = <link>` (preview, chờ xác nhận).

## 6. Preview, xác nhận, lưu
- In toàn bộ kịch bản, run sheet hoặc checklist dạng bảng. Chờ `ok`. Cho phép `sửa dòng X`, `rút còn 45s`, `đổi thứ tự`, `thêm phân đoạn …`, `huỷ`.
- **Lưu nội dung** (không đưa vào base), hỏi user chọn:
  - **Sheet:** thêm tab mới trong `MEWART-TEASER LIVESTREAM 2026` (`SHEET_TEASER`): tab `Teaser <sự kiện> dd/mm` và/hoặc `VJ <sự kiện> dd/mm`. **Không ghi vào tab mẫu.** Đọc `lark-cli sheets --help` để tìm lệnh thêm tab (*chưa chạy thật*).
  - **Doc:** trong `05. VIDEO - KỊCH BẢN - DỰNG`:
    ```
    lark-cli docs +create --parent-token Su3ywgfUxixQyCkYBlxldtPigGe --title "KỊCH BẢN VJ <tên sự kiện> <dd/mm>" \
      --doc-format markdown --content @vj.md --as user --dry-run
    ```
    (*chưa chạy thật*)
- **Dòng theo dõi trong 01. Content:**
  - `HẠNG MỤC CÔNG VIỆC = Kịch bản teaser <sự kiện> dd/mm` hoặc `VJ <sự kiện> dd/mm`, `TIÊU ĐỀ NỘI DUNG = <tên sự kiện>`.
  - `NỀN TẢNG = ["Nội bộ"]`, `MỤC TIÊU = ["Nhận diện thương hiệu"]`.
  - `TIẾN ĐỘ = ["Chờ duyệt"]`, `LINK TEXT = <link sheet/doc>`, `NGÀY BẮT ĐẦU = ngày nhận việc`, `NGÀY ĐĂNG = ngày sự kiện`.
  - `NGƯỜI PHỤ TRÁCH = NGƯỜI YÊU CẦU = người chat`.

## 7. Giới hạn
- Bảng Sự kiện chỉ đọc. Task sự kiện chỉ sửa task của người chat, sau khi xác nhận.
- Không bịa đối tác, con số, cam kết, giờ chương trình.
- Không giao việc quay, thiết kế, dựng cho người chat. Chỉ ghi chú yêu cầu gửi người phụ trách.
