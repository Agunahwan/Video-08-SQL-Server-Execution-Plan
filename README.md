# Video #08 — SQL Server Execution Plan Deep Dive

Repository: `Video-08-SQL-Server-Execution-Plan`

Kumpulan SQL script untuk praktik Video #08 AA Programming.

## Persyaratan
- Microsoft SQL Server dan SSMS
- Database lab berisi `dbo.Tasks`
- Kolom `TaskID`, `Title`, `Status`
- `TaskID` merupakan clustered primary key, sesuai environment demo

> Script mengikuti tabel `dbo.Tasks` pada rekaman. Tidak membuat database/tabel baru atau mengisi data dummy.

## Isi
- `01_Data_Distribution.sql` — jumlah data per Status
- `02_Execution_Plan_Queries.sql` — query Pending dan Done
- `03_Statistics_IO_TIME.sql` — Logical Reads, CPU Time, Elapsed Time
- `04_Index_Experiments.sql` — baseline, Nonclustered Index, Covering Index
- `05_Estimated_vs_Actual_Rows.sql` — pemeriksaan estimasi dan baris aktual

## Urutan praktik
1. Periksa distribusi data dengan script 01.
2. Jalankan baseline dari script 02 sebelum membuat index tambahan.
3. Ukur dengan script 03 dan simpan output tab Messages.
4. Ikuti tahap A, B, C pada script 04 secara berurutan.
5. Gunakan script 05 untuk memeriksa Properties operator.

## Distribusi data pada rekaman
- Done: 195.000 rows
- InProgress: 75.000 rows
- Review: 29.100 rows
- Pending: 900 rows
- Total: 300.000 rows

Hasil database lain dapat berbeda. Gunakan hasil query aktual.

## Catatan
- Aktifkan Include Actual Execution Plan di SSMS (Ctrl+M).
- Jalankan baseline sebelum membuat index.
- Eksperimen index hanya untuk database lab/testing.
- DROP INDEX hanya menargetkan index demo `IX_Tasks_Status` dan `IX_Tasks_Status_Title`. Pastikan index tersebut memang dibuat untuk eksperimen ini sebelum menghapusnya.
- Jangan menghapus index yang digunakan aplikasi.
- Jangan membersihkan cache pada production untuk benchmark.
- Operator, estimasi, Logical Reads, CPU Time, dan Elapsed Time bergantung pada data, statistik, versi SQL Server, dan kondisi server.
- Index Seek tidak otomatis berarti query lebih cepat.

AA PROGRAMMING — Real Code. Real Problems. Practical Solutions.
