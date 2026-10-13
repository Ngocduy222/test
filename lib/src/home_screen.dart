part of '../main.dart';

/// Dashboard tổng hợp ngân sách và các thao tác nhanh.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onAdd,
    required this.onBudget,
    required this.onAnalysis,
    required this.onSaving,
  });
  final VoidCallback onAdd; // Mở form ghi chi tiêu.
  final VoidCallback onBudget; // Mở màn quản lý ngân sách.
  final VoidCallback onAnalysis; // Mở màn phân tích chi tiêu.
  final VoidCallback onSaving; // Chuyển sang tab mục tiêu tiết kiệm.

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 125),
      children: [
        const ScreenHeader(
          'Ngân sách tháng 10/2024',
          label: 'QUẢN LÝ PHÒNG BỊ CHI TIÊU',
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6337E7), AppColors.darkPurple],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x445B2DDE),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TỔNG NGÂN SÁCH THÁNG',
                    style: TextStyle(
                      color: Color(0xFFD8CEFF),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '✓ Đúng kế hoạch',
                    style: TextStyle(
                      color: Color(0xFFA8F3D6),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '8.000.000₫',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Đã chi 4.550.000₫ · Còn lại 3.450.000₫',
                style: TextStyle(color: Color(0xFFDCD4FF), fontSize: 12),
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: const LinearProgressIndicator(
                  value: .57,
                  minHeight: 7,
                  color: Color(0xFF75E1B8),
                  backgroundColor: Colors.white24,
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeroStat('ĐÃ CHI', '4.550.000₫'),
                  HeroStat('CÒN LẠI', '3.450.000₫'),
                  HeroStat('MỖI NGÀY', '265K'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F0FF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BubbleIcon(
                Icons.lightbulb_outline_rounded,
                AppColors.green,
                size: 40,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Góc nhỏ thông thái  ·  Đúng lộ trình',
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Giữ mức ăn uống dưới 80.000₫/ngày sẽ giúp bạn cán đích quỹ mua Laptop sớm hơn 1 tuần đấy!',
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SectionTitle('Thao tác nhanh'),
        Row(
          children: [
            Expanded(
              child: QuickAction(
                icon: Icons.add_circle_outline,
                label: 'Ghi chi tiêu',
                active: true,
                onTap: onAdd,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickAction(
                icon: Icons.tune_rounded,
                label: 'Đặt ngân sách',
                onTap: onBudget,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickAction(
                icon: Icons.query_stats_rounded,
                label: 'Phân tích',
                onTap: onAnalysis,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickAction(
                icon: Icons.savings_outlined,
                label: 'Hũ tiết kiệm',
                onTap: onSaving,
              ),
            ),
          ],
        ),
        const SectionTitle('Hạng mục tháng này', action: 'Xem tất cả'),
        SizedBox(
          height: 34,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['Tất cả', 'Đã chi', 'Sắp hết', 'Tiết kiệm']
                .asMap()
                .entries
                .map((entry) {
                  final active = entry.key == 0;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? AppColors.purple : Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: active ? AppColors.purple : AppColors.line,
                      ),
                    ),
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: active ? Colors.white : AppColors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                })
                .toList(),
          ),
        ),
        ...budgetData.map(BudgetCard.new),
        const SizedBox(height: 14),
        OutlinedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Thêm giao dịch mới'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.purple,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
