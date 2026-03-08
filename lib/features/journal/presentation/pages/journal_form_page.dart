import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/journal_entity.dart';
import '../bloc/journal_bloc.dart';

@RoutePage()
class JournalFormPage extends StatefulWidget {
  const JournalFormPage({super.key});

  @override
  State<JournalFormPage> createState() => _JournalFormPageState();
}

class _JournalFormPageState extends State<JournalFormPage> {
  final _formKey     = GlobalKey<FormState>();
  final _titleCtrl   = TextEditingController();
  final _contentCtrl = TextEditingController();
  String _mood = 'neutral';

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  void _save(BuildContext blocContext) {
    if (!_formKey.currentState!.validate()) return;
    blocContext.read<JournalBloc>().add(
          SaveJournalEvent(
            JournalEntity(
              title:     _titleCtrl.text.trim(),
              content:   _contentCtrl.text.trim(),
              mood:      _mood,
              createdAt: DateTime.now(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<JournalBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('บันทึกใหม่')),
        body: BlocConsumer<JournalBloc, JournalState>(
          listener: (context, state) {
            if (state is JournalError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is JournalSaved) {
              context.router.back();
            }
          },
          builder: (context, state) {
            final isLoading = state is JournalLoading;
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                        labelText: 'หัวข้อ *',
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (v) => (v?.trim().isEmpty ?? true)
                          ? 'กรุณาใส่หัวข้อ'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                            value: 'bullish', label: Text('🟢 Bullish')),
                        ButtonSegment(
                            value: 'neutral', label: Text('⚪ Neutral')),
                        ButtonSegment(
                            value: 'bearish', label: Text('🔴 Bearish')),
                      ],
                      selected: {_mood},
                      onSelectionChanged: (s) =>
                          setState(() => _mood = s.first),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _contentCtrl,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          labelText: 'เนื้อหา *',
                          alignLabelWithHint: true,
                        ),
                        validator: (v) {
                          if (v?.trim().isEmpty ?? true)
                            return 'กรุณาใส่เนื้อหา';
                          if ((v?.trim().length ?? 0) < 10)
                            return 'อย่างน้อย 10 ตัวอักษร';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            isLoading ? null : () => _save(context),
                        icon: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                            isLoading ? 'กำลังบันทึก...' : '💾 บันทึก'),
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}