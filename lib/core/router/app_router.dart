import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/shell/main_shell.dart';
import '../../features/news_analysis/presentation/pages/news_feed_page.dart';
import '../../features/news_analysis/presentation/pages/scan_page.dart';
import '../../features/news_analysis/presentation/pages/analysis_detail_page.dart';
import '../../features/journal/presentation/pages/journal_list_page.dart';
import '../../features/journal/presentation/pages/journal_form_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  Map<String, PageFactory> get pagesMap => {
  ShellRoute.name:          (data) => AutoRoutePage(routeData: data, child: const ShellPage()),
  NewsFeedRoute.name:       (data) => AutoRoutePage(routeData: data, child: const NewsFeedPage()),
  ScanRoute.name:           (data) => AutoRoutePage(routeData: data, child: const ScanPage()),
  AnalysisDetailRoute.name: (data) {
    final args = data.argsAs<AnalysisDetailRouteArgs>();
    return AutoRoutePage(routeData: data, child: AnalysisDetailPage(id: args.id));
  },
  JournalListRoute.name:    (data) => AutoRoutePage(routeData: data, child: const JournalListPage()),
  JournalFormRoute.name:    (data) => AutoRoutePage(routeData: data, child: const JournalFormPage()),
  DashboardRoute.name:      (data) => AutoRoutePage(routeData: data, child: const DashboardPage()),
  SettingsRoute.name:       (data) => AutoRoutePage(routeData: data, child: const SettingsPage()),
};

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ShellRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: ScanRoute.page,
          path: '/scan',
        ),
        AutoRoute(
          page: AnalysisDetailRoute.page,
          path: '/detail/:id',
        ),
        AutoRoute(
          page: JournalFormRoute.page,
          path: '/journal/form',
        ),
      ];
}