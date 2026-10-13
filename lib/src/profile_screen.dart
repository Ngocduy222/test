part of '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const options = [
      (Icons.person_outline, 'Thông tin cá nhân'),
      (Icons.credit_card, 'Tài khoản & Ví'),
      (Icons.notifications_none, 'Thông báo'),
      (Icons.lock_outline, 'Bảo mật'),
      (Icons.palette_outlined, 'Giao diện'),
      (Icons.help_outline, 'Trợ giúp & Phản hồi'),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        const ScreenHeader('Cá nhân'),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            children: [
              Container(
                width: 78,
                height: 78,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'ND',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 11),
              const Text(
                'Nguyễn Minh Anh',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Kỳ thi: PRM · SE170492',
                style: TextStyle(color: AppColors.muted, fontSize: 12),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFEEE9FF),
                  foregroundColor: AppColors.purple,
                ),
                child: const Text('Chỉnh sửa hồ sơ'),
              ),
            ],
          ),
        ),
        const SectionTitle('Tài khoản & Ví thanh toán', action: '+ Thêm ví'),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.purple, AppColors.darkPurple],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TỔNG SỐ DƯ KHẢ DỤNG',
                style: TextStyle(color: Color(0xFFD8CEFF), fontSize: 10),
              ),
              SizedBox(height: 6),
              Text(
                '5.790.000₫',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const WalletTile(
          icon: Icons.account_balance_wallet_rounded,
          color: Color(0xFFB252D7),
          title: 'Ví MoMo cá nhân',
          value: '2.340.000₫',
        ),
        const WalletTile(
          icon: Icons.account_balance_rounded,
          color: AppColors.purple,
          title: 'TPBank · FPT',
          value: '3.450.000₫',
        ),
        const WalletTile(
          icon: Icons.payments_rounded,
          color: AppColors.green,
          title: 'Tiền mặt trong ví',
          value: '250.000₫',
        ),
        const SectionTitle('Tiện ích sinh viên FPTU'),
        Row(
          children: [
            Expanded(
              child: QuickAction(
                icon: Icons.restaurant_menu_rounded,
                label: 'Xem lịch ăn',
                onTap: () {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: QuickAction(
                icon: Icons.picture_as_pdf_outlined,
                label: 'Xuất báo cáo PDF',
                onTap: () {},
              ),
            ),
          ],
        ),
        const SectionTitle('Bảo mật & Ứng dụng'),
        const SettingsSwitch(
          title: 'Bảo mật sinh trắc học',
          subtitle: 'Dùng vân tay hoặc khuôn mặt',
        ),
        const SettingsSwitch(
          title: 'Chế độ Thư viện Học tập',
          subtitle: 'Tự động giảm âm thanh thông báo',
        ),
        const SectionTitle('Cài đặt'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Column(
            children: options
                .map(
                  (option) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: BubbleIcon(option.$1, AppColors.purple, size: 38),
                    title: Text(
                      option.$2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.muted,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout),
          label: const Text('Đăng xuất'),
          style: TextButton.styleFrom(foregroundColor: AppColors.red),
        ),
        const Text(
          'MoneyMate phiên bản 1.0.0',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.muted, fontSize: 10),
        ),
      ],
    );
  }
}
