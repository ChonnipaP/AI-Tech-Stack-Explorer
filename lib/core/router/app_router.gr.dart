// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

class AnalysisDetailRoute extends PageRouteInfo<AnalysisDetailRouteArgs> {
  AnalysisDetailRoute({
    Key? key,
    required int id,
    List<PageRouteInfo>? children,
  }) : super(
         AnalysisDetailRoute.name,
         args: AnalysisDetailRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'AnalysisDetailRoute';
  static const PageInfo<AnalysisDetailRouteArgs> page =
      PageInfo<AnalysisDetailRouteArgs>(name);
}

class AnalysisDetailRouteArgs {
  const AnalysisDetailRouteArgs({this.key, required this.id});
  final Key? key;
  final int id;
}

class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class JournalFormRoute extends PageRouteInfo<void> {
  const JournalFormRoute({List<PageRouteInfo>? children})
    : super(JournalFormRoute.name, initialChildren: children);

  static const String name = 'JournalFormRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class JournalListRoute extends PageRouteInfo<void> {
  const JournalListRoute({List<PageRouteInfo>? children})
    : super(JournalListRoute.name, initialChildren: children);

  static const String name = 'JournalListRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class NewsFeedRoute extends PageRouteInfo<void> {
  const NewsFeedRoute({List<PageRouteInfo>? children})
    : super(NewsFeedRoute.name, initialChildren: children);

  static const String name = 'NewsFeedRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class ScanRoute extends PageRouteInfo<void> {
  const ScanRoute({List<PageRouteInfo>? children})
    : super(ScanRoute.name, initialChildren: children);

  static const String name = 'ScanRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class ShellRoute extends PageRouteInfo<void> {
  const ShellRoute({List<PageRouteInfo>? children})
    : super(ShellRoute.name, initialChildren: children);

  static const String name = 'ShellRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}