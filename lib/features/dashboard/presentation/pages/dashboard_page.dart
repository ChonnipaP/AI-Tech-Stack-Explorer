import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../news_analysis/presentation/bloc/news_bloc.dart';
import '../../../news_analysis/domain/entities/news_analysis_entity.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>()..add(LoadAnalysesEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Dashboard')),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is NewsLoaded) {
              return _DashboardBody(analyses: state.analyses);
            }
            return const Center(
              child: Text('ยังไม่มีข้อมูล',
                  style: TextStyle(color: AppColors.textSecond)),
            );
          },
        ),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  final List<NewsAnalysisEntity> analyses;
  const _DashboardBody({required this.analyses});

  @override
  Widget build(BuildContext context) {
    final stockCount = analyses.where((a) => a.analysisType == 'stock_news').length;
    final codeCount  = analyses.where((a) => a.analysisType == 'code').length;
    final favoriteCount = analyses.where((a) => a.isFavorite).length;

    // กลุ่มตาม 7 วันล่าสุด
    final now = DateTime.now();
    final dailyCounts = List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      return analyses.where((a) =>
        a.createdAt.year == day.year &&
        a.createdAt.month == day.month &&
        a.createdAt.day == day.day
      ).length.toDouble();
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Summary Cards ──
          Row(
            children: [
              _StatCard(
                label: 'ทั้งหมด',
                value: '${analyses.length}',
                icon: Icons.analytics,
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'ข่าวหุ้น',
                value: '$stockCount',
                icon: Icons.trending_up,
                color: AppColors.positive,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'โค้ด',
                value: '$codeCount',
                icon: Icons.code,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'Favorite',
                value: '$favoriteCount',
                icon: Icons.star,
                color: AppColors.warning,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Bar Chart: 7 วันล่าสุด ──
          _SectionTitle(title: 'การวิเคราะห์ 7 วันล่าสุด'),
          const SizedBox(height: 12),
          _BarChartCard(dailyCounts: dailyCounts),
          const SizedBox(height: 24),

          // ── Pie Chart: สัดส่วนประเภท ──
          if (analyses.isNotEmpty) ...[
            _SectionTitle(title: 'สัดส่วนประเภทการวิเคราะห์'),
            const SizedBox(height: 12),
            _PieChartCard(stockCount: stockCount, codeCount: codeCount),
            const SizedBox(height: 24),
          ],

          // ── Recent List ──
          _SectionTitle(title: 'รายการล่าสุด'),
          const SizedBox(height: 12),
          if (analyses.isEmpty)
            const Center(
              child: Text('ยังไม่มีการวิเคราะห์',
                  style: TextStyle(color: AppColors.textSecond)),
            )
          else
            ...analyses.take(5).map((a) => _RecentItem(analysis: a)),
        ],
      ),
    );
  }
}

// ── Stat Card ─────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textSecond, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

// ── Section Title ─────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// ── Bar Chart ─────────────────────────────────────────
class _BarChartCard extends StatelessWidget {
  final List<double> dailyCounts;
  const _BarChartCard({required this.dailyCounts});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = List.generate(7, (i) {
      final d = now.subtract(Duration(days: 6 - i));
      return '${d.day}/${d.month}';
    });

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (dailyCounts.reduce((a, b) => a > b ? a : b) + 2).clamp(4, double.infinity),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (v, _) => Text(
                  v.toInt().toString(),
                  style: const TextStyle(
                      color: AppColors.textSecond, fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => Text(
                  days[v.toInt()],
                  style: const TextStyle(
                      color: AppColors.textSecond, fontSize: 9),
                ),
              ),
            ),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (_) => const FlLine(
              color: AppColors.divider,
              strokeWidth: 0.5,
            ),
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            7,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: dailyCounts[i],
                  color: AppColors.primary,
                  width: 16,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Pie Chart ─────────────────────────────────────────
class _PieChartCard extends StatelessWidget {
  final int stockCount;
  final int codeCount;
  const _PieChartCard({required this.stockCount, required this.codeCount});

  @override
  Widget build(BuildContext context) {
    final total = stockCount + codeCount;
    if (total == 0) return const SizedBox.shrink();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: stockCount.toDouble(),
                    color: AppColors.positive,
                    title: '${(stockCount / total * 100).toStringAsFixed(0)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  PieChartSectionData(
                    value: codeCount.toDouble(),
                    color: AppColors.secondary,
                    title: '${(codeCount / total * 100).toStringAsFixed(0)}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Legend(color: AppColors.positive, label: 'ข่าวหุ้น ($stockCount)'),
              const SizedBox(height: 8),
              _Legend(color: AppColors.secondary, label: 'โค้ด ($codeCount)'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                color: AppColors.textSecond, fontSize: 12)),
      ],
    );
  }
}

// ── Recent Item ───────────────────────────────────────
class _RecentItem extends StatelessWidget {
  final NewsAnalysisEntity analysis;
  const _RecentItem({required this.analysis});

  @override
  Widget build(BuildContext context) {
    final isStock = analysis.analysisType == 'stock_news';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(
            isStock ? Icons.trending_up : Icons.code,
            color: isStock ? AppColors.positive : AppColors.secondary,
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              analysis.title,
              style: const TextStyle(
                  color: AppColors.textPrimary, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${analysis.createdAt.day}/${analysis.createdAt.month}',
            style: const TextStyle(
                color: AppColors.textSecond, fontSize: 11),
          ),
        ],
      ),
    );
  }
}