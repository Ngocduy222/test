part of '../main.dart';

/// Hiển thị và tìm kiếm toàn bộ lịch sử giao dịch.
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    super.key,
    required this.items,
    required this.onDelete,
  });
  final List<TransactionData> items;
  final ValueChanged<TransactionData> onDelete;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  /// Từ khóa tìm kiếm theo tên hoặc danh mục giao dịch.
  String query = '';

  @override
  Widget build(BuildContext context) {
    final items = widget.items
        .where(
          (item) => '${item.name} ${item.category}'.toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          const ScreenHeader('Giao dịch', label: 'THÁNG 10/2024'),
          const Row(
            children: [
              Expanded(
                child: SummaryCard(
                  'Thu nhập',
                  '+8.000.000₫',
                  AppColors.green,
                  Color(0xFFE9F9F2),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  'Chi tiêu',
                  '-4.550.000₫',
                  AppColors.red,
                  Color(0xFFFFF0F2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: InputDecoration(
              hintText: 'Tìm kiếm giao dịch',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.tune, color: AppColors.purple),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 110),
              itemCount: items.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: AppColors.line),
              itemBuilder: (_, index) {
                final item = items[index];
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => TransactionDetailScreen(
                        transaction: item,
                        onDelete: () {
                          widget.onDelete(item);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  leading: BubbleIcon(item.icon, item.color, size: 46),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    '${item.category} · ${item.date}',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 10,
                    ),
                  ),
                  trailing: Text(
                    '${item.amount > 0 ? '+' : '-'}${money(item.amount)}',
                    style: TextStyle(
                      color: item.amount > 0 ? AppColors.green : AppColors.ink,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Hiển thị đầy đủ thông tin, chỉnh sửa và xóa một giao dịch.
class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({
    super.key,
    required this.transaction,
    required this.onDelete,
  });

  final TransactionData transaction;
  final VoidCallback onDelete;

  /// Hiện hộp thoại xác nhận trước khi xóa vĩnh viễn giao dịch.
  Future<void> confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Container(
          width: 54,
          height: 54,
          decoration: const BoxDecoration(
            color: Color(0xFFFFECEC),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.red,
            size: 30,
          ),
        ),
        title: const Text(
          'Xóa giao dịch này?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Text(
          'Khoản chi ${money(transaction.amount)} tại ${transaction.name} sẽ bị xóa khỏi lịch sử và ngân sách liên quan.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: FilledButton.styleFrom(backgroundColor: AppColors.red),
              child: const Text(
                'Xóa vĩnh viễn',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Giữ lại giao dịch'),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) onDelete();
  }

  @override
  Widget build(BuildContext context) {
    final expense = transaction.amount < 0;
    return PageScaffold(
      title: 'Chi tiết giao dịch',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                BubbleIcon(transaction.icon, transaction.color, size: 58),
                const SizedBox(height: 12),
                Text(
                  '${expense ? '-' : '+'}${money(transaction.amount)}',
                  style: TextStyle(
                    color: expense ? AppColors.red : AppColors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  transaction.name,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: const TextStyle(color: AppColors.muted, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                DetailRow(
                  icon: Icons.category_outlined,
                  label: 'Danh mục',
                  value: transaction.category,
                ),
                const Divider(height: 1, color: AppColors.line),
                const DetailRow(
                  icon: Icons.calendar_month_outlined,
                  label: 'Thời gian',
                  value: 'Hôm nay · 14:20',
                ),
                const Divider(height: 1, color: AppColors.line),
                const DetailRow(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Phương thức',
                  value: 'Ví MoMo cá nhân',
                ),
                const Divider(height: 1, color: AppColors.line),
                const DetailRow(
                  icon: Icons.person_outline,
                  label: 'Người ghi chép',
                  value: 'Minh Anh',
                ),
                const Divider(height: 1, color: AppColors.line),
                DetailRow(
                  icon: Icons.tag_rounded,
                  label: 'Mã giao dịch',
                  value:
                      'MM-${transaction.name.hashCode.abs().toString().padLeft(8, '0').substring(0, 8)}',
                ),
              ],
            ),
          ),
          const SectionTitle('Ghi chú & Chứng từ'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Giao dịch được ghi nhận trong MoneyMate. Bạn có thể chỉnh sửa thông tin hoặc xóa giao dịch bên dưới.',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Chức năng chỉnh sửa đã sẵn sàng')),
            ),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Chỉnh sửa giao dịch'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFEEE9FF),
              foregroundColor: AppColors.purple,
              padding: const EdgeInsets.all(15),
            ),
          ),
          const SizedBox(height: 9),
          FilledButton.icon(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Xóa giao dịch'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFFFE5E5),
              foregroundColor: AppColors.red,
              padding: const EdgeInsets.all(15),
            ),
          ),
        ],
      ),
    );
  }
}
