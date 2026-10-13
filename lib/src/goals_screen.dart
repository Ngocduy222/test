part of '../main.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const goals = [
      (
        'Laptop đồ họa & PRM323',
        13500000,
        20000000,
        Icons.laptop_mac_rounded,
        AppColors.purple,
      ),
      (
        'Quỹ dự phòng khẩn cấp',
        4200000,
        5000000,
        Icons.verified_user_rounded,
        AppColors.green,
      ),
      (
        'Lệ phí thi AWS Cloud & IELTS',
        900000,
        3000000,
        Icons.school_rounded,
        AppColors.orange,
      ),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
      children: [
        const ScreenHeader('Mục tiêu tiết kiệm', label: 'TƯƠNG LAI CỦA BẠN'),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkPurple,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TỔNG ĐÃ TIẾT KIỆM',
                    style: TextStyle(
                      color: Color(0xFFCFC4F8),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '18.600.000₫',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '+2.500.000₫ trong tháng này',
                    style: TextStyle(color: Color(0xFF8FE6C4), fontSize: 11),
                  ),
                ],
              ),
              Icon(Icons.savings_rounded, color: Colors.white, size: 42),
            ],
          ),
        ),
        const SectionTitle('Mục tiêu của bạn', action: '+ Tạo mới'),
        ...goals.map((goal) {
          final progress = goal.$2 / goal.$3;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    BubbleIcon(goal.$4, goal.$5),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                goal.$1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '${(progress * 100).round()}%',
                                style: TextStyle(
                                  color: goal.$5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${money(goal.$2)} / ${money(goal.$3)}',
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    color: goal.$5,
                    backgroundColor: AppColors.line,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Còn thiếu ${money(goal.$3 - goal.$2)}',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      'Nạp thêm',
                      style: TextStyle(
                        color: AppColors.purple,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
