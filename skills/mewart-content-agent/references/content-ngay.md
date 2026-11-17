Phần này thuộc skill mewart-content-agent. Hằng số, field id và option xem §0 trong SKILL.md.

# Flow B: Viết CONTENT SOCIAL ngày

User chat "viết content social 18/11" hoặc "viết caption cho ảnh cushion ngày mai". Skill:
1. Lấy danh sách content của ngày.
2. Viết caption riêng cho từng kênh: FB Hiền Mew Makeup, FB Mew Art Make Up, Instagram.
3. Preview và chờ xác nhận.
4. Tạo doc `CONTENT SOCIAL dd/mm` trong wiki `02. CONTENT SOCIAL/YYYY-MM`.
5. Tạo hoặc cập nhật dòng `Content social dd/mm` trong 01. Content, với `LINK TEXT` trỏ tới doc và `TIẾN ĐỘ = Đã lên lịch chờ đăng`.

## 1. Xác định ngày và danh sách content
- Đổi ngày về dạng `dd/mm` (có số 0 đứng đầu) và `YYYY-MM-DD`. "Hôm nay" và "mai" tính theo giờ Việt Nam.
- **Danh sách content lấy từ sheet KLCV tháng**: đọc ô D (`1/ … 2/ … 3/ …`) của hàng ngày đó (cách tìm sheet ở `len-plan.md` §2). Nếu ô còn trống thì **hỏi user** ngày đó gồm những content nào, rồi đề xuất điền luôn vào ô D (preview riêng, theo `len-plan.md` §7a).
- Kiểm tra dòng theo dõi trong base đã có chưa:
  ```
  lark-cli base +record-search --base-token N0uub2iuPadQSlsxdyVl3aARguc --table-id tblYO1mEPwxKiZ7f \
    --keyword "Content social 18/11" --search-field fldXCxHBER --as user --output ./tmp/search.ndjson
  ```
  So khớp chính xác `HẠNG MỤC`. Nếu khớp nhiều dòng thì liệt kê để user chọn. Ưu tiên dòng có `NGƯỜI PHỤ TRÁCH` là người chat.
- **Doc ngày đã tồn tại chưa?** Liệt kê con của node tháng (§0) và tìm tiêu đề `CONTENT SOCIAL dd/mm`. Nếu đã có thì đọc doc đó. Content nào đã có caption thì không viết lại, trừ khi user yêu cầu. Phần mới sẽ được **append**.
- Với mỗi content, hỏi thêm thông tin còn thiếu mà caption cần, ví dụ tên khách trúng giải, địa điểm sự kiện, tên sản phẩm chính xác. **Không bịa.**

## 2. Tham khảo trước khi viết (chỉ đọc)
- Đọc 1–2 doc CONTENT SOCIAL gần nhất để giữ đúng giọng: `docs +fetch --doc <obj_token>`.
- Nếu content thuộc series (ví dụ "cốp makeup tập 8") thì tìm doc tập trước để giữ mạch.

## 3. Bộ não viết caption
> **Đọc `ky-thuat-viet.md` §1–§4 trước khi viết** (hook, thân bài, tránh văn AI, hashtag). Trước khi preview phải tự rà danh sách "văn AI" ở §3 của file đó.

### 3.1 Giọng từng kênh (theo bảng Quy chuẩn Content social và doc thật của chị Loan)
- **FB Hiền Mew Makeup:**
  - Xưng **"em Hiền"**, gọi người đọc là **"chị em"** hoặc **"các chị"**. Giọng tâm sự, kể trải nghiệm thật.
  - Công thức: **hook cảm xúc hoặc vấn đề thật** (thường là câu hỏi "Có chị nào… không ạ?" hoặc "Chị em có bao giờ…") → chia sẻ hoặc giải pháp → giới thiệu sản phẩm/video → kết thúc ấm, có thể hỏi ý kiến.
  - Dài 3–5 đoạn ngắn. Bài chúc mừng hoặc thông báo thì **mở bằng 1 dòng IN HOA**. Có thể dùng emoji đầu dòng cho danh sách quà hoặc ưu đãi (🎁👜💛🛵).
- **FB Mew Art Make Up:**
  - Giọng **thương hiệu, chuyên môn**: xưng "MEWART", không xưng "em Hiền".
  - **Mở bằng 1 dòng tiêu đề IN HOA**, sau đó là các ý ngắn dùng 👉 (dẫn ý) và ✔️ (lợi ích). Súc tích và hướng giá trị. Với khoá học thì nhấn vào kết quả học viên.
- **Instagram:**
  - **Ngắn** (1–3 câu), có thể là một câu quote truyền cảm hứng, chú trọng giá trị thẩm mỹ và lifestyle.
  - Theo quy chuẩn, hashtag IG **đặt trong comment**, nên in riêng thành dòng "Hashtag (comment)".
- **Viết cả 3 kênh khác nhau thật sự**, không copy cùng một caption.

### 3.2 Hashtag (theo bảng Quy chuẩn)
- **FB Hiền Mew và FB Mew Art:** 3–5 tag. Cố định `#HienMewMakeup #MEWART` (chị Loan dùng) cộng 2–3 tag chủ đề viết liền không dấu (ví dụ `#CopMakeup #MakeupTrungNien`). Bài khoá học thì thêm `#MewartAcademy #HocMakeup`.
- **Instagram:** 5–7 tag, đặt trong comment. Gồm `#MewartAcademy #MakeupArtist #BeautyTips #MakeupHanoi` cộng tag chủ đề.

### 3.3 Nội dung
- Bám đúng sản phẩm, chương trình và con số user đưa. Thiếu thì để `[cần bổ sung: ...]` trong preview và hỏi.
- Mỹ phẩm: nhấn vào lợi ích thực tế, có CTA mềm. Khoá học: nhấn vào kết quả học viên và CTA đăng ký hoặc nhắn tin. Sự kiện: kể lại khoảnh khắc và cảm ơn đối tác hoặc địa phương.
- Nếu content cần ảnh mới thì **chỉ viết ghi chú gửi design (Quang)**: chữ trên ảnh, tỷ lệ 1:1 hoặc 4:5, ảnh before/after phải rõ nét và không làm mất độ thật. Người chat không tự thiết kế.

## 4. Preview (bắt buộc), theo đúng cấu trúc doc của chị Loan
```
CONTENT SOCIAL 18/11   (→ doc mới trong 02. CONTENT SOCIAL/2026-11 | hoặc: append vào doc đã có)

CONTENT 1: <Tiêu đề content>
Caption Facebook
  Facebook Hiền Mew Makeup
  <toàn văn>
  <hashtag FB>
  Facebook Mew Art Make Up
  <toàn văn>
  <hashtag FB>
Caption Instagram
  <toàn văn>
  Hashtag (comment): <hashtag IG>

CONTENT 2: ...
```
Kèm phần "Sẽ ghi":
- **Doc:** tạo mới `CONTENT SOCIAL 18/11` hoặc append vào doc đã có.
- **Base (chỉ theo dõi):** tạo mới hoặc cập nhật dòng `Content social 18/11` với `TIÊU ĐỀ NỘI DUNG = <tên content 1>`, `LINK TEXT = <link wiki doc>`, `TIẾN ĐỘ = Đã lên lịch chờ đăng`, `NGÀY ĐĂNG = NGÀY BẮT ĐẦU = 2026-11-18`. Caption **không** đưa vào base.

## 5. Cổng xác nhận
Các lệnh hỗ trợ: `viết lại content 2 FB Mew Art`, `ngắn hơn`, `thêm CTA ...`, `đổi hashtag ...`, `bỏ content 3`, `huỷ`. Sau mỗi lần sửa thì in lại phần bị sửa. Chỉ ghi khi user gõ `ok`, `đồng ý` hoặc `duyệt`.

## 6. Ghi
**(a) Doc.** Ghi nội dung ra file `cs.md` theo Markdown:
- `**CONTENT 1: ...**` in đậm.
- Các nhãn `**Caption Facebook**`, `**Facebook Hiền Mew Makeup**`, `**Facebook Mew Art Make Up**`, `**Caption Instagram**` in đậm.
- Mỗi đoạn caption là 1 đoạn văn.

Doc **chưa có** thì tạo mới:
```
lark-cli docs +create --parent-token <node tháng 02. CONTENT SOCIAL> --title "CONTENT SOCIAL 18/11" \
  --doc-format markdown --content @cs.md --as user --dry-run
# OK thì bỏ --dry-run. Kết quả trả về token/URL doc; lưu lại để ghi vào LINK TEXT
```
- Nếu **chưa có node tháng** (ví dụ `2026-12`) thì dừng, báo user và hỏi có tạo node `YYYY-MM` dưới `WIKI_CS` không. Tạo bằng `lark-cli wiki +node-create` (đọc `--help` trước; *chưa chạy thật*).

Doc **đã có** thì chỉ append, **không overwrite**:
```
lark-cli docs +update --doc <token> --command append --doc-format markdown --content @cs.md --as user
```

**(b) Base, dòng theo dõi.** Chị Loan làm mỗi ngày 1 dòng: nhân bản dòng hôm trước rồi sửa hạng mục, ngày và link. Skill tạo dòng mới có cùng bộ giá trị:
```json
{"create_records":[{
  "HẠNG MỤC CÔNG VIỆC":"Content social 18/11",
  "TIÊU ĐỀ NỘI DUNG":"<tên content 1, ví dụ Content Ảnh sản phẩm xịt khoáng>",
  "NGƯỜI PHỤ TRÁCH":[{"id":"<openId>"}],
  "NGƯỜI YÊU CẦU":[{"id":"<openId>"}],
  "TIẾN ĐỘ":["Đã lên lịch chờ đăng"],
  "NỀN TẢNG":["Facebook","Instagram"],
  "MỤC TIÊU":["Tạo như cầu","Bán sản phẩm"],
  "NGÀY BẮT ĐẦU":"2026-11-18 00:00",
  "NGÀY ĐĂNG":"2026-11-18 00:00",
  "LINK TEXT":"https://hienmewmakeup.sg.larksuite.com/wiki/<node doc>"
}]}
```
- Thêm `"Bán khoá học"` vào MỤC TIÊU nếu ngày đó có content khoá học. Thêm `"Tiktok"` vào NỀN TẢNG chỉ khi user nói có đăng TikTok.
- Dòng **đã có** thì dùng `+record-batch-update` và chỉ gửi các field thay đổi (thường là `LINK TEXT`, `TIÊU ĐỀ NỘI DUNG`, `TIẾN ĐỘ`).
- Một content đăng riêng ngoài lịch ngày (ví dụ video lẻ) thì chị Loan tạo dòng riêng, `HẠNG MỤC` = tên content. Chỉ tạo khi user yêu cầu.

## 7. Xác nhận
- `docs +fetch` doc vừa ghi để chắc nội dung đã vào. `+record-search` dòng vừa ghi để chắc `LINK TEXT` và `TIẾN ĐỘ` đã đúng.
- Báo ngắn gọn: link doc, link dòng (`+record-share-link-create`). Nhắc user rằng sau khi đăng thì chat "đã đăng content 18/11 + link" để chạy Flow C.

## 8. Giới hạn
- Chỉ tạo doc hoặc append vào doc ngày. Không sửa doc ngày khác, không xoá nội dung.
- Caption là bản nháp, con người duyệt và đăng.
- Không bịa thông tin. Thiếu thì hỏi.

