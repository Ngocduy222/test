# MoneyMate Flutter

Ứng dụng quản lý tài chính cá nhân dựng từ thiết kế Figma.

## Chạy dự án

```powershell
C:\Users\duyz1\flutter\bin\flutter.bat pub get
C:\Users\duyz1\flutter\bin\flutter.bat run
```

Ứng dụng gồm dashboard ngân sách, giao dịch, thêm khoản thu/chi,
mục tiêu tiết kiệm và hồ sơ cá nhân.

## Cấu trúc source code

```text
lib/
├── main.dart                         # Khởi động app và điều hướng chính
└── src/
    ├── core_models.dart              # Màu sắc, model và dữ liệu mẫu
    ├── shared_widgets.dart           # Widget dùng chung
    ├── home_screen.dart              # Dashboard
    ├── transactions_screens.dart     # Danh sách, chi tiết và xóa giao dịch
    ├── add_transaction_sheet.dart    # Form thêm khoản thu/chi
    ├── budget_analysis_screens.dart  # Ngân sách và phân tích
    ├── goals_screen.dart             # Mục tiêu tiết kiệm
    ├── notifications_screen.dart     # Trung tâm thông báo
    └── profile_screen.dart           # Hồ sơ, ví và cài đặt
```

Các file được chia theo chức năng để dễ trình bày, kiểm thử và review.
