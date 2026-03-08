import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

@RoutePage()
class AnalysisDetailPage extends StatelessWidget {
  final int id;
  const AnalysisDetailPage({super.key, @pathParam required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('รายละเอียด')),
      body: Center(
        child: Hero(        // ✅ Hero รับจาก NewsCard
          tag: 'news_icon_$id',
          child: const Icon(
            Icons.trending_up,
            size: 64,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}