part of '../main.dart';

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key, required this.onSave});
  final ValueChanged<TransactionData> onSave;

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  bool isExpense = true;
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void save() {
    final value = int.tryParse(
      amountController.text.replaceAll(RegExp('[^0-9]'), ''),
    );
    if (value == null || value == 0) return;
    widget.onSave(
      TransactionData(
        noteController.text.trim().isEmpty
            ? (isExpense ? 'Khoản chi mới' : 'Khoản thu mới')
            : noteController.text.trim(),
        isExpense ? 'Chi tiêu' : 'Thu nhập',
        isExpense ? -value : value,
        isExpense ? Icons.receipt : Icons.account_balance_wallet,
        isExpense ? AppColors.purple : AppColors.green,
        'Vừa xong',
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.line,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                  const Text(
                    'Thêm giao dịch',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    segment('Khoản chi', true),
                    segment('Khoản thu', false),
                  ],
                ),
              ),
              inputLabel('SỐ TIỀN'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                      decoration: const InputDecoration(
                        hintText: '0',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Text(
                    '₫',
                    style: TextStyle(
                      color: AppColors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.line),
              inputLabel('GHI CHÚ'),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  hintText: 'Bạn đã chi tiêu cho việc gì?',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              inputLabel('DANH MỤC'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: budgetData
                    .map(
                      (item) => Column(
                        children: [
                          BubbleIcon(item.icon, item.color, size: 46),
                          Text(
                            item.name.split(' & ').first,
                            style: const TextStyle(
                              color: AppColors.muted,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: save,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'Lưu giao dịch',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget segment(String text, bool value) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => isExpense = value),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isExpense == value ? AppColors.purple : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isExpense == value ? Colors.white : AppColors.muted,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  Widget inputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
