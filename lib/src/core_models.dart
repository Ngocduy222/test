part of '../main.dart';

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
    2100000,
    3500000,
    Icons.restaurant_rounded,
    Color(0xFF6C4CE3),
  ),
  BudgetData(
    'Học tập & Giáo trình',
    650000,
    1200000,
    Icons.menu_book_rounded,
    AppColors.orange,
  ),
  BudgetData(
    'Giải trí & Bạn bè',
    1420000,
    2000000,
    Icons.sports_esports_rounded,
    Color(0xFFEE5B8E),
  ),
  BudgetData(
    'Đi lại & Xe cộ',
    380000,
    800000,
    Icons.two_wheeler_rounded,
    Color(0xFF2BA8A0),
  ),
  BudgetData(
    'Mua sắm cá nhân',
    0,
    500000,
    Icons.shopping_bag_rounded,
    Color(0xFF5368E8),
  ),
];
