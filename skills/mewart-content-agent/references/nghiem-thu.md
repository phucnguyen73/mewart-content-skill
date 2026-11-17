Phần này thuộc skill mewart-content-agent. Hằng số, field id và option xem §0 trong SKILL.md.

# Flow C: Nghiệm thu sau đăng và số liệu nhanh

User chat kiểu "đã đăng content 17/11: <link1> <link2> <link3>", "nghiệm thu hôm qua" hoặc "bài hôm qua chạy thế nào". Làm như chị Loan, theo thứ tự:
1. **Sheet KLCV (nơi nghiệm thu chính):** dán `1/ link`, `2/ link`, `3/ link` vào cột L, M, N của hàng ngày đó.
2. **Base (theo dõi):** dòng `Content social dd/mm` gồm `LINK ẢNH/VIDEO` = `NGHIỆM THU FINAL` = link bài FB Hiền Mew (bài số 1), và `TIẾN ĐỘ = Hoàn thành`. Automation sẽ báo người yêu cầu.
3. Kéo số liệu Facebook từ bảng **6.1** để báo nhanh trong chat.

Cả 3 bước đều phải preview và chờ xác nhận.

## 1. Parse
- **Ngày:** `dd/mm`. Nếu user không nói ngày thì hỏi. "Hôm qua" tính theo giờ Việt Nam.
- **Link:** giữ đúng thứ tự `1/ 2/ 3/` khớp với CONTENT 1/2/3 trong doc ngày và ô D của sheet. Thiếu link nào thì hỏi. Content nào chưa đăng thì giữ ô đó là `n/`.

## 2. Đọc hiện trạng
- **Sheet:** tìm sheet tháng (`len-plan.md` §2), `+csv-get` hàng của ngày đó (cột A–N), đọc ô L, M, N.
- **Base:**
  ```
  lark-cli base +record-search --base-token N0uub2iuPadQSlsxdyVl3aARguc --table-id tblYO1mEPwxKiZ7f \
    --keyword "Content social 17/11" --search-field fldXCxHBER --as user --output ./tmp/search.ndjson
  ```
  So khớp chính xác. Nếu khớp nhiều dòng thì hỏi. Dòng không phải của người chat thì hỏi trước khi sửa. Nếu chưa có dòng thì đề xuất tạo theo mẫu ở `content-ngay.md` §6b.

## 3. Preview
```
SHEET KLCV THÁNG 11 — hàng 26 (Thứ 3, 17/11)
  L26: "1/"  →  "1/ https://www.facebook.com/hienmew.makeup/posts/..."
  M26: "2/ https://..." (đã có, giữ nguyên)
  N26: "3/"  →  "3/ https://www.facebook.com/reel/..."
BASE — Content social 17/11
  TIẾN ĐỘ:          Đã lên lịch chờ đăng → Hoàn thành   (automation sẽ báo người yêu cầu)
  LINK ẢNH/VIDEO:   (trống) → https://www.facebook.com/hienmew.makeup/posts/...
  NGHIỆM THU FINAL: (trống) → (giống trên)
```
- Ô sheet nào đã có link thì giữ nguyên. Chỉ ghi ô còn là placeholder (`1/`, `2/`, `3/`).
- Nếu phát hiện dòng bẩn (`Hoàn thành` mà không có link, hoặc TIẾN ĐỘ là option rác như `Facebook` hay `Video cốp makeup Tập 7`) thì nêu ra và **hỏi**. Không tự sửa hàng loạt.
- Chỉ chuyển `Hoàn thành` khi **đã đủ link cho các content đã đăng**. Nếu thiếu link thì hỏi user muốn để `Đã lên lịch chờ đăng` hay chuyển luôn.

## 4. Ghi (sau khi user gõ `ok`)
**Sheet:** ghi các ô L/M/N trong danh sách đã preview (đọc `lark-cli sheets +cells-set --help` trước; *chưa chạy thật*). Ghi xong thì `+csv-get` lại hàng đó.

**Base:**
```json
{"update_records":{"<rid>":{
  "TIẾN ĐỘ":["Hoàn thành"],
  "LINK ẢNH/VIDEO":"https://www.facebook.com/hienmew.makeup/posts/...",
  "NGHIỆM THU FINAL":"https://www.facebook.com/hienmew.makeup/posts/..."
}}}
```
```
lark-cli base +record-batch-update --base-token N0uub2iuPadQSlsxdyVl3aARguc --table-id tblYO1mEPwxKiZ7f --json @nt.json --as user
```
Ghi xong thì đọc lại dòng để xác nhận.

## 5. Số liệu nhanh từ 6.1 (chỉ đọc)
Bảng `6.1 Danh sách post facebook (mới 2026)` (`tblliwZEclnSlsT6`) tự đồng bộ bài của **các fanpage Facebook**. Field chính:
- `Link bài viết`, `ID` (`<pageId>_<postId>`), `Mã video`, `Tên trang` (`HIỀN MEW MAKE UP`, `MEW ART MAKE UP`…)
- `Ngày đăng (ms)`, `Nội dung bài viết`, `Nhóm bài` (Video/Ảnh/Live)
- `Lượt xem`, `Tiếp cận`, `Tổng tương tác`, `Cảm xúc`, `Bình luận`, `Chia sẻ`, `Lượt click`, `Thời gian xem TB (giây)`
- `Trạng thái` (HOT/GOOD/Normal), `Nên boost`, `Cập nhật lúc (ms)`

Cách khớp link với dòng trong 6.1:
- Link reel hoặc video (`/reel/<id>`, `/videos/<id>`): khớp `Mã video` = `<id>`.
- Link post `pfbid…`: không suy ra được ID. Lọc `Ngày đăng (ms)` trong ngày đó và `Tên trang`, rồi khớp 40 ký tự đầu của `Nội dung bài viết` với caption trong doc ngày.

```
lark-cli base +record-list --base-token N0uub2iuPadQSlsxdyVl3aARguc --table-id tblliwZEclnSlsT6 --as user \
  --filter-json '{"logic":"and","conditions":[["Ngày đăng (ms)",">","ExactDate(<ngày trước> 23:59:59.999)"],["Ngày đăng (ms)","<","ExactDate(<ngày sau> 00:00:00)"]]}' \
  --field-id "Link bài viết" --field-id "Mã video" --field-id "Tên trang" --field-id "Nội dung bài viết" --field-id "Nhóm bài" \
  --field-id "Lượt xem" --field-id "Tiếp cận" --field-id "Tổng tương tác" --field-id "Bình luận" --field-id "Chia sẻ" --field-id "Lượt click" \
  --field-id "Trạng thái" --field-id "Cập nhật lúc (ms)" --format ndjson --output ./posts-day.ndjson
```

Báo dạng bảng:

| # | Content | Trang | Xem | Tiếp cận | Tương tác | BL | Share | Click | Nhãn |
|---|---|---|---|---|---|---|---|---|---|

- Ngưỡng nhãn mặc định (bảng `6.2 Config - Posts Monitor`, config Default, 30 ngày):
  - **GOOD:** xem ≥1.000 hoặc share ≥5, cảm xúc ≥100, bình luận ≥10, click ≥20.
  - **HOT:** xem ≥10.000 hoặc share ≥30, cảm xúc ≥500, bình luận ≥50, click ≥100.
- `Trạng thái` trong 6.1 có cả giá trị kỹ thuật (`added_photos`, `added_video`, `mobile_status_update`, `shared_story`). Đó là **loại bài, không phải nhãn hiệu suất**. Chỉ báo nhãn khi giá trị là `HOT` hoặc `GOOD`. Các trường hợp khác thì tự so số với ngưỡng ở trên.
- Chỉ lấy dòng có `Tên trang` thuộc kênh của người chat: `HIỀN MEW MAKE UP` và trang FB Mew Art Make Up (xem §0 SKILL.md). Bảng 6.1 còn nhiều trang khác (Huệ Vương, Học Viện…), phải loại ra.
- Ghi rõ **thời điểm đồng bộ** (`Cập nhật lúc`). Bài mới đăng dưới 24 giờ thì số liệu còn thấp và có thể chưa có trong 6.1. Khi đó nói rõ là "chưa có số", **không đoán số**.
- **Instagram: hiện chưa có nguồn số liệu tự động trong base.** Nếu user muốn thì ghi số tay vào phần vướng mắc hoặc ghi chú, hoặc chờ đề xuất thêm cột chỉ số (`plans/de-xuat-base-content-tuyet-mai.md`).
- Bảng 01. Content **chưa có cột chỉ số**. Hiện chỉ báo số liệu trong chat, **không ghi số vào base**.

## 5b. Kiểm tra việc tồn đọng (chỉ đọc)
Khi user hỏi "tuần này content nào chưa nghiệm thu":
- Đọc các dòng của người chat có `NGÀY ĐĂNG` trong khoảng được hỏi mà `TIẾN ĐỘ` khác `Hoàn thành`.
- Đối chiếu ô L, M, N của sheet KLCV xem còn placeholder `n/` không.

Liệt kê theo ngày: ngày nào còn thiếu link nào, dòng nào chưa `Hoàn thành`. Sau đó gợi ý user gửi link để nghiệm thu.

## 6. Giới hạn
- Chỉ ghi vào ô nghiệm thu L, M, N của sheet KLCV và dòng theo dõi trong 01. Content. 6.1 và 6.2 là bảng tự động, **chỉ đọc**.
- Số liệu chỉ báo trong chat, không ghi vào base hay sheet, trừ khi user yêu cầu.
- Không tạo field hoặc option. Dòng bẩn chỉ sửa khi user đồng ý.

