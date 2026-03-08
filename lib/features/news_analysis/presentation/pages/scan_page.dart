import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/ml_kit_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/news_analysis_entity.dart';
import '../bloc/news_bloc.dart';

@RoutePage()
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _titleController = TextEditingController();
  final _textController  = TextEditingController();
  final _mlKitService    = MlKitService();
  final _picker          = ImagePicker();
  String _analysisType   = 'stock_news';
  bool _isScanning       = false;

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _mlKitService.dispose();
    super.dispose();
  }

  Future<void> _pickAndScan(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    setState(() => _isScanning = true);
    try {
      final text = await _mlKitService.extractTextFromImage(picked.path);
      _textController.text = text;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('สแกนไม่สำเร็จ: $e')),
        );
      }
    } finally {
      setState(() => _isScanning = false);
    }
  }

  void _analyze(BuildContext blocContext) {
    if (_titleController.text.isEmpty || _textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบ')),
      );
      return;
    }
    blocContext.read<NewsBloc>().add(AnalyzeNewsEvent(
          text: _textController.text,
          analysisType: _analysisType,
        ));
  }

  void _save(BuildContext blocContext, String summary) {
    blocContext.read<NewsBloc>().add(
          SaveAnalysisEvent(
            NewsAnalysisEntity(
              title: _titleController.text,
              extractedText: _textController.text,
              aiSummary: summary,
              analysisType: _analysisType,
              createdAt: DateTime.now(),
              isFavorite: false,
              tags: [],
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewsBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('สแกนและวิเคราะห์')),
        body: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is NewsSaved) {
              context.router.back();
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'ชื่อการวิเคราะห์ *',
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                          value: 'stock_news', label: Text('📈 ข่าวหุ้น')),
                      ButtonSegment(value: 'code', label: Text('💻 โค้ด')),
                    ],
                    selected: {_analysisType},
                    onSelectionChanged: (v) =>
                        setState(() => _analysisType = v.first),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isScanning
                              ? null
                              : () => _pickAndScan(ImageSource.camera),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('ถ่ายรูป'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isScanning
                              ? null
                              : () => _pickAndScan(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('แกลเลอรี'),
                        ),
                      ),
                    ],
                  ),
                  if (_isScanning) ...[
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(),
                    const SizedBox(height: 4),
                    const Text('กำลังสแกนข้อความ...'),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    controller: _textController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'ข้อความที่ต้องการวิเคราะห์ *',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state is NewsAnalyzed) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.auto_awesome,
                                  color: AppColors.primary, size: 16),
                              SizedBox(width: 8),
                              Text('ผลวิเคราะห์ AI',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(state.summary,
                              style: const TextStyle(height: 1.5)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  ElevatedButton.icon(
                    onPressed:
                        state is NewsLoading ? null : () => _analyze(context),
                    icon: state is NewsLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(state is NewsLoading
                        ? 'กำลังวิเคราะห์...'
                        : 'AI วิเคราะห์ ✨'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (state is NewsAnalyzed)
                    ElevatedButton.icon(
                      onPressed: () => _save(context, state.summary),
                      icon: const Icon(Icons.save),
                      label: const Text('บันทึก'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}