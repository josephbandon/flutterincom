import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

// ======================================================
// THEME & COLORS
// ======================================================

class AppColors {
  static const primary = Color(0xFF6C5CE7);
  static const primaryLight = Color(0xFF8B7FF5);
  static const accent = Color(0xFF00D2D3);
  static const income = Color(0xFF00B894);
  static const expense = Color(0xFFFF6B6B);
  static const surface = Color(0xFF1E1E2E);
  static const surfaceLight = Color(0xFF2A2A3E);
  static const surfaceCard = Color(0xFF252540);
  static const background = Color(0xFF14142B);
  static const textPrimary = Color(0xFFF5F5F7);
  static const textSecondary = Color(0xFF9898B0);
  static const muted = Color(0xFF3A3A50);
}

// ======================================================
// MODEL
// ======================================================

class TransactionItem {
  String title;
  double amount;
  bool isIncome;
  DateTime date;
  IconData icon;

  TransactionItem({
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
    this.icon = Icons.receipt_long,
  });
}

// ======================================================
// APP
// ======================================================

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
        fontFamily: 'SF Pro Display',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: const SplashPage(),
    );
  }
}

// ======================================================
// SPLASH PAGE
// ======================================================

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              Color(0xFF1A1A3E),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    borderRadius: BorderRadius.circular(36),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Expense Tracker',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'บันทึกรายรับ - รายจ่าย\nจัดการเงินได้ง่ายขึ้น',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'เริ่มใช้งาน',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// LOGIN PAGE
// ======================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('กรุณากรอกอีเมลและรหัสผ่าน'),
          backgroundColor: AppColors.surfaceCard,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      hintStyle: TextStyle(
        color: AppColors.textSecondary.withValues(alpha: 0.5),
      ),
      prefixIcon: Icon(icon, color: AppColors.textSecondary),
      filled: true,
      fillColor: AppColors.surfaceCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A3E), AppColors.background],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'ยินดีต้อนรับ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'เข้าสู่ระบบเพื่อเริ่มบันทึกรายรับ - รายจ่าย',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _inputDecoration(
                    'อีเมล',
                    'example@gmail.com',
                    Icons.email_outlined,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: _inputDecoration(
                    'รหัสผ่าน',
                    '',
                    Icons.lock_outline,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'สำหรับต้นแบบ กรอกอีเมลและรหัสผ่านใดก็ได้',
                  style: TextStyle(
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// HOME PAGE
// ======================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<TransactionItem> transactions = [
    TransactionItem(
      title: 'เงินเดือน',
      amount: 10000,
      isIncome: true,
      date: DateTime.now(),
      icon: Icons.work_rounded,
    ),
    TransactionItem(
      title: 'ค่าอาหาร',
      amount: 150,
      isIncome: false,
      date: DateTime.now(),
      icon: Icons.restaurant_rounded,
    ),
    TransactionItem(
      title: 'ค่าเดินทาง',
      amount: 50,
      isIncome: false,
      date: DateTime.now(),
      icon: Icons.directions_car_rounded,
    ),
  ];

  double get totalIncome =>
      transactions.where((i) => i.isIncome).fold(0, (s, i) => s + i.amount);

  double get totalExpense =>
      transactions.where((i) => !i.isIncome).fold(0, (s, i) => s + i.amount);

  double get balance => totalIncome - totalExpense;

  Future<void> addTransaction() async {
    final result = await Navigator.push<TransactionItem>(
      context,
      MaterialPageRoute(builder: (_) => const AddTransactionPage()),
    );
    if (result != null) {
      setState(() => transactions.insert(0, result));
    }
  }

  Future<void> editTransaction(int index) async {
    final result = await Navigator.push<TransactionItem>(
      context,
      MaterialPageRoute(
        builder: (_) => AddTransactionPage(transaction: transactions[index]),
      ),
    );
    if (result != null) {
      setState(() => transactions[index] = result);
    }
  }

  void deleteTransaction(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'ลบรายการ',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'คุณต้องการลบรายการนี้หรือไม่?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'ยกเลิก',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => transactions.removeAt(index));
              Navigator.pop(ctx);
            },
            child: const Text('ลบ', style: TextStyle(color: AppColors.expense)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildDashboard(),
      buildTransactionList(),
      buildStatistics(),
      buildSettings(),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      floatingActionButton: selectedIndex <= 1
          ? Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: addTransaction,
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.add_rounded, size: 28),
              ),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.muted, width: 0.5)),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.primary.withValues(alpha: 0.15),
          selectedIndex: selectedIndex,
          onDestinationSelected: (i) => setState(() => selectedIndex = i),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: AppColors.textSecondary),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
              label: 'หน้าหลัก',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.receipt_long_outlined,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.receipt_long_rounded,
                color: AppColors.primary,
              ),
              label: 'รายการ',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bar_chart_outlined,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.bar_chart_rounded,
                color: AppColors.primary,
              ),
              label: 'สถิติ',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.settings_rounded,
                color: AppColors.primary,
              ),
              label: 'ตั้งค่า',
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  // DASHBOARD
  // ====================================================

  Widget buildDashboard() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          title: const Text(
            'รายรับ - รายจ่าย',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          centerTitle: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Balance card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, Color(0xFF4834D4)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'ยอดคงเหลือ',
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '฿ ${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _miniStat(
                            'รายรับ',
                            totalIncome,
                            Icons.arrow_downward_rounded,
                            AppColors.income,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _miniStat(
                            'รายจ่าย',
                            totalExpense,
                            Icons.arrow_upward_rounded,
                            AppColors.expense,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'รายการล่าสุด',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => selectedIndex = 1),
                    child: const Text(
                      'ดูทั้งหมด',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (transactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      'ยังไม่มีรายการ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ...transactions
                  .take(5)
                  .toList()
                  .asMap()
                  .entries
                  .map((e) => _transactionTile(e.value, e.key)),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _miniStat(String title, double amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  '฿${amount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // TRANSACTION LIST
  // ====================================================

  Widget buildTransactionList() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          title: Text(
            'รายการทั้งหมด',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: false,
        ),
        if (transactions.isEmpty)
          const SliverFillRemaining(
            child: Center(
              child: Text(
                'ยังไม่มีรายการ',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _transactionTile(transactions[i], i),
                childCount: transactions.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _transactionTile(TransactionItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: (item.isIncome ? AppColors.income : AppColors.expense)
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            color: item.isIncome ? AppColors.income : AppColors.expense,
            size: 22,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          _formatDate(item.date),
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${item.isIncome ? '+' : '-'} ฿${item.amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: item.isIncome ? AppColors.income : AppColors.expense,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert_rounded,
                color: AppColors.textSecondary,
                size: 20,
              ),
              color: AppColors.surfaceCard,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onSelected: (v) {
                if (v == 'edit') editTransaction(index);
                if (v == 'delete') deleteTransaction(index);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('แก้ไข')),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('ลบ', style: TextStyle(color: AppColors.expense)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ====================================================
  // STATISTICS
  // ====================================================

  Widget buildStatistics() {
    final total = totalIncome + totalExpense;
    final incPct = total == 0 ? 0.0 : totalIncome / total;
    final expPct = total == 0 ? 0.0 : totalExpense / total;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          title: Text(
            'สรุปข้อมูล',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Balance highlight
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ยอดเงินคงเหลือ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '฿ ${balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: balance >= 0
                            ? AppColors.income
                            : AppColors.expense,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _progressBar('สัดส่วนรายรับ', incPct, AppColors.income),
              const SizedBox(height: 20),
              _progressBar('สัดส่วนรายจ่าย', expPct, AppColors.expense),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _statRow(
                      Icons.arrow_downward_rounded,
                      'รายรับทั้งหมด',
                      '฿ ${totalIncome.toStringAsFixed(2)}',
                      AppColors.income,
                    ),
                    Divider(
                      color: AppColors.muted.withValues(alpha: 0.5),
                      height: 1,
                      indent: 56,
                    ),
                    _statRow(
                      Icons.arrow_upward_rounded,
                      'รายจ่ายทั้งหมด',
                      '฿ ${totalExpense.toStringAsFixed(2)}',
                      AppColors.expense,
                    ),
                    Divider(
                      color: AppColors.muted.withValues(alpha: 0.5),
                      height: 1,
                      indent: 56,
                    ),
                    _statRow(
                      Icons.receipt_long_rounded,
                      'จำนวนรายการ',
                      '${transactions.length} รายการ',
                      AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _progressBar(String label, double pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${(pct * 100).toStringAsFixed(1)}%',
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 10,
            color: color,
            backgroundColor: AppColors.surfaceCard,
          ),
        ),
      ],
    );
  }

  Widget _statRow(IconData icon, String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: color,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // ====================================================
  // SETTINGS
  // ====================================================

  Widget buildSettings() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          title: Text(
            'ตั้งค่า',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'ผู้ใช้งาน',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _settingsTile(
                      Icons.person_outline_rounded,
                      'ข้อมูลผู้ใช้งาน',
                      true,
                    ),
                    Divider(
                      color: AppColors.muted.withValues(alpha: 0.5),
                      height: 1,
                      indent: 56,
                    ),
                    _settingsTile(
                      Icons.notifications_outlined,
                      'การแจ้งเตือน',
                      true,
                    ),
                    Divider(
                      color: AppColors.muted.withValues(alpha: 0.5),
                      height: 1,
                      indent: 56,
                    ),
                    _settingsTile(
                      Icons.info_outline_rounded,
                      'เกี่ยวกับแอปพลิเคชัน',
                      false,
                      subtitle: 'Version 1.0',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.expense.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.expense,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                      color: AppColors.expense,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title,
    bool hasChevron, {
    String? subtitle,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: hasChevron
          ? const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            )
          : null,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ======================================================
// ADD / EDIT TRANSACTION PAGE
// ======================================================

class AddTransactionPage extends StatefulWidget {
  final TransactionItem? transaction;

  const AddTransactionPage({super.key, this.transaction});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  bool isIncome = false;
  DateTime selectedDate = DateTime.now();

  bool get isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.transaction?.title ?? '',
    );
    amountController = TextEditingController(
      text: widget.transaction == null
          ? ''
          : widget.transaction!.amount.toString(),
    );
    if (widget.transaction != null) {
      isIncome = widget.transaction!.isIncome;
      selectedDate = widget.transaction!.date;
    }
  }

  void saveTransaction() {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text.trim());
    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('กรุณากรอกชื่อรายการและจำนวนเงินให้ถูกต้อง'),
          backgroundColor: AppColors.surfaceCard,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }
    Navigator.pop(
      context,
      TransactionItem(
        title: title,
        amount: amount,
        isIncome: isIncome,
        date: selectedDate,
      ),
    );
  }

  Future<void> selectDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.surfaceCard,
            ),
          ),
          child: child!,
        );
      },
    );
    if (result != null) setState(() => selectedDate = result);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint, {String? prefix}) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefix,
      hintStyle: TextStyle(
        color: AppColors.textSecondary.withValues(alpha: 0.5),
      ),
      filled: true,
      fillColor: AppColors.surfaceCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'แก้ไขรายการ' : 'เพิ่มรายการ',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ชื่อรายการ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _fieldDecoration('เช่น ค่าอาหาร, เงินเดือน'),
            ),
            const SizedBox(height: 20),
            const Text(
              'จำนวนเงิน',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: _fieldDecoration('0.00', prefix: '฿ '),
            ),
            const SizedBox(height: 24),
            const Text(
              'ประเภท',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isIncome = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: !isIncome
                            ? AppColors.expense.withValues(alpha: 0.15)
                            : AppColors.surfaceCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: !isIncome
                              ? AppColors.expense
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'รายจ่าย',
                          style: TextStyle(
                            color: !isIncome
                                ? AppColors.expense
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isIncome = true),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: isIncome
                            ? AppColors.income.withValues(alpha: 0.15)
                            : AppColors.surfaceCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isIncome
                              ? AppColors.income
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'รายรับ',
                          style: TextStyle(
                            color: isIncome
                                ? AppColors.income
                                : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'วันที่',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: selectDate,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: saveTransaction,
                icon: const Icon(Icons.check_rounded),
                label: Text(
                  isEditing ? 'บันทึกการแก้ไข' : 'บันทึก',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
