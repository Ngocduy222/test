part of '../main.dart';

/// Cho phép xem và điều chỉnh hạn mức của từng nhóm ngân sách.
class BudgetManagerScreen extends StatefulWidget {
  const BudgetManagerScreen({super.key});

  @override
  State<BudgetManagerScreen> createState() => _BudgetManagerScreenState();
}

class _BudgetManagerScreenState extends State<BudgetManagerScreen> {
  /// Danh sách hạn mức có thể thay đổi bằng thanh Slider.
  late final List<double> limits = budgetData
      .map((item) => item.limit.toDouble())
      .toList();

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Đặt ngân sách',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NGÂN SÁCH THÁNG 10',
                  style: TextStyle(color: Color(0xFFD8CEFF), fontSize: 10),
                ),
                SizedBox(height: 6),
                Text(
                  '8.000.000₫',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Kéo thanh để thay đổi hạn mức từng danh mục',
                  style: TextStyle(color: Color(0xFFD8CEFF), fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...budgetData.asMap().entries.map((entry) {
            final item = entry.value;
            final i = entry.key;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      BubbleIcon(item.icon, item.color),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Hạn mức ${money(limits[i])}',
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${(item.spent / limits[i] * 100).round()}%',
                        style: TextStyle(
                          color: item.color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: limits[i],
                    min: 300000,
                    max: 3000000,
                    divisions: 27,
                    activeColor: item.color,
                    onChanged: (value) => setState(() => limits[i] = value),
                  ),
                ],
              ),
            );
          }),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã lưu ngân sách tháng này')),
              );
            },
            icon: const Icon(Icons.check_rounded),
            label: const Text('Lưu ngân sách'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.purple,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tổng hợp thu/chi, biểu đồ theo ngày và tỷ trọng từng danh mục.
class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final values = [55.0, 82.0, 42.0, 95.0, 68.0, 76.0, 48.0];
    return PageScaffold(
      title: 'Phân tích chi tiêu',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          const Row(
            children: [
              Expanded(
                child: SummaryCard(
                  'Tổng thu',
                  '+8.000.000₫',
                  AppColors.green,
                  Color(0xFFE9F9F2),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  'Tổng chi',
                  '-4.550.000₫',
                  AppColors.red,
                  Color(0xFFFFF0F2),
                ),
              ),
            ],
          ),
          const SectionTitle('Chi tiêu 7 ngày gần đây'),
          Container(
            height: 220,
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: values.asMap().entries.map((entry) {
                const labels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 20,
                        height: entry.value * 1.5,
                        decoration: BoxDecoration(
                          color: entry.key == 3
                              ? AppColors.purple
                              : const Color(0xFFCEC5F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        labels[entry.key],
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SectionTitle('Chi theo danh mục'),
          ...budgetData.map((item) {
            final share = item.spent / 4550000;
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  BubbleIcon(item.icon, item.color, size: 40),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              money(item.spent),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: LinearProgressIndicator(
                            value: share,
                            minHeight: 6,
                            color: item.color,
                            backgroundColor: AppColors.line,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
