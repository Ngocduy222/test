part of '../main.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int filter = 0;

  @override
  Widget build(BuildContext context) {
    const notifications = [
      (
        Icons.warning_amber_rounded,
        AppColors.orange,
        'Cảnh báo phòng bị Giải trí',
        'Phòng bị Giải trí & Bạn bè đã chạm 71% hạn mức. Hãy cân nhắc các khoản chi sắp tới.',
        '10 phút trước',
      ),
      (
        Icons.receipt_long_rounded,
        AppColors.red,
        'Ghi chi tiêu giống MoMo',
        'Xác nhận giao dịch Highlands Coffee 45.000₫ được ghi nhận từ ví MoMo.',
        '1 giờ trước',
      ),
      (
        Icons.savings_rounded,
        AppColors.green,
        'Tuyệt vời! Mục tiêu đạt 84%',
        'Quỹ dự phòng khẩn cấp chỉ còn một chút nữa là hoàn thành.',
        'Hôm nay',
      ),
      (
        Icons.school_rounded,
        AppColors.purple,
        'Góc FPTU: Tiết kiệm có chiến lược',
        'Duy trì ngân sách học tập giúp bạn chủ động hơn cho học kỳ mới.',
        'Hôm qua',
      ),
      (
        Icons.auto_awesome_rounded,
        Color(0xFF6A78D1),
        'Phân tích tổng kết tuần',
        'Bạn đã chi ít hơn tuần trước 12%. Tiếp tục giữ nhịp nhé!',
        '2 ngày trước',
      ),
    ];
    return PageScaffold(
      title: 'Trung tâm thông báo',
      action: TextButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã đánh dấu tất cả là đã đọc')),
        ),
        child: const Text('Đọc hết'),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Row(
            children: ['Tất cả', 'Cảnh báo ngân sách', 'Của bạn']
                .asMap()
                .entries
                .map(
                  (entry) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(
                          entry.value,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10),
                        ),
                        selected: filter == entry.key,
                        selectedColor: AppColors.purple,
                        labelStyle: TextStyle(
                          color: filter == entry.key
                              ? Colors.white
                              : AppColors.muted,
                        ),
                        onSelected: (_) => setState(() => filter = entry.key),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SectionTitle('Hôm nay'),
          ...notifications.map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BubbleIcon(item.$1, item.$2, size: 42),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.$3,
                                style: const TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: AppColors.purple,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.$4,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          item.$5,
                          style: const TextStyle(
                            color: AppColors.purple,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SectionTitle('Tùy chỉnh thông báo'),
          const SettingsSwitch(
            title: 'Cảnh báo hạn mức an toàn',
            subtitle: 'Thông báo khi ngân sách sắp hết',
          ),
          const SettingsSwitch(
            title: 'Nhắc ghi chép',
            subtitle: 'Nhắc cập nhật chi tiêu cuối ngày',
          ),
        ],
      ),
    );
  }
}
