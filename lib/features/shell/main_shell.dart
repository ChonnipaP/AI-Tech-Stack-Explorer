import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../dashboard/presentation/pages/dashboard_page.dart';
import '../journal/presentation/pages/journal_list_page.dart';
import '../news_analysis/presentation/pages/news_feed_page.dart';
import '../settings/presentation/pages/settings_page.dart';

@RoutePage()
class ShellPage extends StatefulWidget {   // ← เปลี่ยนชื่อเป็น ShellPage
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  final List<Widget> _pages = const [
    NewsFeedPage(),
    JournalListPage(),
    DashboardPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}