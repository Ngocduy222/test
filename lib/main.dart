import 'package:flutter/material.dart';

part 'src/core_models.dart';
part 'src/shared_widgets.dart';
part 'src/home_screen.dart';
part 'src/budget_analysis_screens.dart';
part 'src/transactions_screens.dart';
part 'src/goals_screen.dart';
part 'src/notifications_screen.dart';
part 'src/profile_screen.dart';
part 'src/add_transaction_sheet.dart';

void main() => runApp(const MyApp());

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
      8000000,
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
      '12/10/2024',
    ),
    const TransactionData(
      'Siêu thị WinMart',
      'Mua sắm',
      -356000,
      Icons.shopping_cart_rounded,
      Color(0xFF2BA8A0),
      '11/10/2024',
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
            TransactionsScreen(
              items: transactions,
              onDelete: (transaction) =>
                  setState(() => transactions.remove(transaction)),
            ),
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
