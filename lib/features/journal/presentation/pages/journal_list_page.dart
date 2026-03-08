import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/journal_entity.dart';
import '../bloc/journal_bloc.dart';

@RoutePage()
class JournalListPage extends StatelessWidget {
  const JournalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<JournalBloc>()..add(LoadJournalEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Journal')),
        body: BlocBuilder<JournalBloc, JournalState>(
          builder: (context, state) {
            if (state is JournalLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is JournalLoaded) {
              if (state.entries.isEmpty) return const _EmptyState();
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.entries.length,
                itemBuilder: (ctx, i) => _JournalCard(entry: state.entries[i]),
              );
            }
            if (state is JournalError) {
              return Center(
                child: Text(state.message,
                    style: const TextStyle(color: AppColors.negative)),
              );
            }
            return const _EmptyState();
          },
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            heroTag: 'journal_fab',
            onPressed: () async {
              final bloc = ctx.read<JournalBloc>();
              await ctx.router.push(const JournalFormRoute());
              bloc.add(LoadJournalEvent());
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _JournalCard extends StatelessWidget {
  final JournalEntity entry;
  const _JournalCard({required this.entry});

  Color _moodColor(String mood) {
    switch (mood) {
      case 'bullish': return AppColors.positive;
      case 'bearish': return AppColors.negative;
      default:        return AppColors.textSecond;
    }
  }

  String _moodEmoji(String mood) {
    switch (mood) {
      case 'bullish': return '🟢';
      case 'bearish': return '🔴';
      default:        return '⚪';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(_moodEmoji(entry.mood),
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Text(
                '${entry.createdAt.day}/${entry.createdAt.month}/${entry.createdAt.year}',
                style: TextStyle(color: _moodColor(entry.mood), fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecond,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, size: 64, color: AppColors.textSecond),
          SizedBox(height: 16),
          Text(
            'ยังไม่มีบันทึก',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'กดปุ่ม + เพื่อเพิ่มบันทึกใหม่',
            style: TextStyle(color: AppColors.textSecond),
          ),
        ],
      ),
    );
  }
}