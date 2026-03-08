import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/news_analysis_entity.dart';
import '../bloc/news_bloc.dart';
import '../../../../core/router/app_router.dart';

@RoutePage()
class NewsFeedPage extends StatelessWidget {
  const NewsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>()..add(LoadAnalysesEvent()),
      child: Builder(
        builder: (ctx) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('AI Tech-Stack Explorer'),
          ),
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (state is NewsLoaded) {
                if (state.analyses.isEmpty) {
                  return const _EmptyState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.analyses.length,
                  itemBuilder: (context, i) =>
                      _NewsCard(analysis: state.analyses[i]),
                );
              }
              if (state is NewsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppColors.negative),
                  ),
                );
              }
              return const _EmptyState();
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'news_fab',
            onPressed: () async {
              final bloc = ctx.read<NewsBloc>();
              await ctx.router.push(const ScanRoute());
              bloc.add(LoadAnalysesEvent());
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.black,
            icon: const Icon(Icons.camera_alt),
            label: const Text('สแกนใหม่'),
          ),
        ),
      ),
    );
  }
}

// ── Card แต่ละรายการ ──────────────────────────────────
class _NewsCard extends StatefulWidget {
  final NewsAnalysisEntity analysis;
  const _NewsCard({required this.analysis});

  @override
  State<_NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<_NewsCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(_expanded ? 20 : 14),
        decoration: BoxDecoration(
          color: _expanded ? AppColors.surfaceVar : AppColors.surface,
          borderRadius: BorderRadius.circular(_expanded ? 16 : 10),
          border: Border.all(
            color: _expanded ? AppColors.primary : AppColors.divider,
            width: _expanded ? 1.5 : 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'news_icon_${widget.analysis.id}',
                  child: _TypeBadge(type: widget.analysis.analysisType),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.analysis.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: _expanded ? null : 1,
                    overflow: _expanded ? null : TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.textSecond,
                  size: 18,
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 10),
              Text(
                widget.analysis.aiSummary,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecond,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.router.push(
                    AnalysisDetailRoute(id: widget.analysis.id!),
                  ),
                  child: const Text(
                    'ดูรายละเอียด →',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Badge แสดงประเภท ──────────────────────────────────
class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isStock = type == 'stock_news';
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isStock
            ? AppColors.positive.withOpacity(0.15)
            : AppColors.secondary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        isStock ? Icons.trending_up : Icons.code,
        color: isStock ? AppColors.positive : AppColors.secondary,
        size: 18,
      ),
    );
  }
}

// ── หน้าว่าง ──────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, size: 64, color: AppColors.textSecond),
          SizedBox(height: 16),
          Text(
            'ยังไม่มีการวิเคราะห์',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'กดปุ่ม "สแกนใหม่" เพื่อเริ่มต้น',
            style: TextStyle(color: AppColors.textSecond),
          ),
        ],
      ),
    );
  }
}