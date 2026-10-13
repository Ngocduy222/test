import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class AppColors {
  static const purple = Color(0xFF5B2DDE);
  static const darkPurple = Color(0xFF3D1CA8);
  static const green = Color(0xFF19A974);
  static const red = Color(0xFFF04F5F);
  static const orange = Color(0xFFFF9E3D);
  static const ink = Color(0xFF17152A);
  static const muted = Color(0xFF77748A);
  static const line = Color(0xFFE9E7F1);
  static const background = Color(0xFFF8F7FC);
}

String money(num value) {
  final text = value.abs().round().toString();
  final output = StringBuffer();
  for (var i = 0; i < text.length; i++) {
    if (i > 0 && (text.length - i) % 3 == 0) output.write('.');
    output.write(text[i]);
  }
  return '$output₫';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyMate',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
      ),
      home: const MoneyMateShell(),
    );
  }
}

class TransactionData {
  const TransactionData(
    this.name,
    this.category,
    this.amount,
    this.icon,
    this.color,
    this.date,
  );
  final String name;
  final String category;
  final int amount;
  final IconData icon;
  final Color color;
  final String date;
}

class BudgetData {
  const BudgetData(this.name, this.spent, this.limit, this.icon, this.color);
  final String name;
  final int spent;
  final int limit;
  final IconData icon;
  final Color color;
}

const budgetData = [
  BudgetData(
    'Ăn uống & Cà phê',
    850000,
    1200000,
    Icons.restaurant_rounded,
    Color(0xFF6C4CE3),
  ),
  BudgetData(
    'Học tập & Đi lại',
    720000,
    1000000,
    Icons.directions_bus_rounded,
    AppColors.orange,
  ),
  BudgetData(
    'Giải trí & Bạn bè',
    560000,
    900000,
    Icons.sports_esports_rounded,
    Color(0xFFEE5B8E),
  ),
  BudgetData(
    'Đi lại & Xe cộ',
    400000,
    600000,
    Icons.two_wheeler_rounded,
    Color(0xFF2BA8A0),
  ),
];

class MoneyMateShell extends StatefulWidget {
  const MoneyMateShell({super.key});

  @override
  State<MoneyMateShell> createState() => _MoneyMateShellState();
}

class _MoneyMateShellState extends State<MoneyMateShell> {
  int currentIndex = 0;
  final transactions = <TransactionData>[
    const TransactionData(
      'Highlands Coffee',
      'Ăn uống',
      -55000,
      Icons.local_cafe_rounded,
      Color(0xFF6C4CE3),
      'Hôm nay, 08:45',
    ),
    const TransactionData(
      'Lương tháng 10',
      'Thu nhập',
      12000000,
      Icons.account_balance_wallet_rounded,
      AppColors.green,
      'Hôm nay, 07:30',
    ),
    const TransactionData(
      'Grab Bike',
      'Đi lại',
      -42000,
      Icons.two_wheeler_rounded,
      AppColors.orange,
      'Hôm qua, 18:20',
    ),
    const TransactionData(
      'Netflix',
      'Giải trí',
      -180000,
      Icons.tv_rounded,
      Color(0xFFEE5B8E),
      '12/10/2026',
    ),
    const TransactionData(
      'Siêu thị WinMart',
      'Mua sắm',
      -356000,
      Icons.shopping_cart_rounded,
      Color(0xFF2BA8A0),
      '11/10/2026',
    ),
  ];

  void openAddTransaction() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddTransactionSheet(
        onSave: (transaction) => setState(() {
          transactions.insert(0, transaction);
          currentIndex = 1;
        }),
      ),
    );
  }

  void openPage(Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            HomeScreen(
              onAdd: openAddTransaction,
              onBudget: () => openPage(const BudgetManagerScreen()),
              onAnalysis: () => openPage(const AnalysisScreen()),
              onSaving: () => setState(() => currentIndex = 2),
            ),
            TransactionsScreen(items: transactions),
            const GoalsScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: openAddTransaction,
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.background, width: 5),
        ),
        child: const Icon(Icons.add_rounded, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 76,
        padding: EdgeInsets.zero,
        color: Colors.white,
        notchMargin: 7,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            navItem(0, Icons.home_outlined, 'Tổng quan'),
            navItem(1, Icons.receipt_long_outlined, 'Giao dịch'),
            const SizedBox(width: 64),
            navItem(2, Icons.flag_outlined, 'Mục tiêu'),
            navItem(3, Icons.person_outline, 'Cá nhân'),
          ],
        ),
      ),
    );
  }

  Widget navItem(int index, IconData icon, String label) {
    final active = currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => currentIndex = index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? AppColors.purple : const Color(0xFF9B98A8),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                color: active ? AppColors.purple : const Color(0xFF9B98A8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader(this.title, {super.key, this.label});
  final String title;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              if (label != null) const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Color(0x1233256B), blurRadius: 14),
              ],
            ),
            child: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
    );
  }
}

class BubbleIcon extends StatelessWidget {
  const BubbleIcon(this.icon, this.color, {super.key, this.size = 44});
  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: size * .5),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onAdd,
    required this.onBudget,
    required this.onAnalysis,
    required this.onSaving,
  });
  final VoidCallback onAdd;
  final VoidCallback onBudget;
  final VoidCallback onAnalysis;
  final VoidCallback onSaving;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 125),
      children: [
        const ScreenHeader(
          'Ngân sách tháng 10/2026',
          label: 'XIN CHÀO, DUY 👋',
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
                '18.000.000₫',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Đã chi 6.550.000₫ · Còn lại 11.450.000₫',
                style: TextStyle(color: Color(0xFFDCD4FF), fontSize: 12),
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: const LinearProgressIndicator(
                  value: .36,
                  minHeight: 7,
                  color: Color(0xFF75E1B8),
                  backgroundColor: Colors.white24,
                ),
              ),
              const SizedBox(height: 18),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeroStat('ĐÃ CHI', '36%'),
                  HeroStat('CÒN LẠI', '64%'),
                  HeroStat('MỖI NGÀY', '636K'),
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

class HeroStat extends StatelessWidget {
  const HeroStat(this.label, this.value, {super.key});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFC9BEF8), fontSize: 9),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? AppColors.purple : const Color(0xFFEDEBFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: active ? Colors.white : AppColors.purple),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: active ? Colors.white : AppColors.ink,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.action,
  });
  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        actions: action == null ? null : [action!],
      ),
      body: child,
    );
  }
}

class BudgetManagerScreen extends StatefulWidget {
  const BudgetManagerScreen({super.key});

  @override
  State<BudgetManagerScreen> createState() => _BudgetManagerScreenState();
}

class _BudgetManagerScreenState extends State<BudgetManagerScreen> {
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

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action});
  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(
                color: AppColors.purple,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}

class BudgetCard extends StatelessWidget {
  const BudgetCard(this.item, {super.key});
  final BudgetData item;

  @override
  Widget build(BuildContext context) {
    final progress = item.spent / item.limit;
    return Container(
      margin: const EdgeInsets.only(top: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BubbleIcon(item.icon, item.color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        color: item.color,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đã chi ${money(item.spent)}',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Còn ${money(item.limit - item.spent)}',
                      style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
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
  }
}

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key, required this.items});
  final List<TransactionData> items;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
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
          const ScreenHeader('Giao dịch', label: 'THÁNG 10/2026'),
          const Row(
            children: [
              Expanded(
                child: SummaryCard(
                  'Thu nhập',
                  '+12.000.000₫',
                  AppColors.green,
                  Color(0xFFE9F9F2),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SummaryCard(
                  'Chi tiêu',
                  '-6.550.000₫',
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

class SummaryCard extends StatelessWidget {
  const SummaryCard(
    this.label,
    this.value,
    this.color,
    this.background, {
    super.key,
  });
  final String label;
  final String value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 11),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const goals = [
      (
        'Du lịch Đà Lạt',
        4200000,
        8000000,
        Icons.flight_takeoff_rounded,
        AppColors.purple,
      ),
      (
        'MacBook mới',
        12000000,
        30000000,
        Icons.laptop_mac_rounded,
        AppColors.orange,
      ),
      (
        'Quỹ khẩn cấp',
        18500000,
        20000000,
        Icons.verified_user_rounded,
        AppColors.green,
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
                    '34.700.000₫',
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
                'Ngọc Duy',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'duy.ngoc@moneymate.vn',
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
