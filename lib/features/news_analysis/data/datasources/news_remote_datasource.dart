import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/gemini_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<String> analyzeText({
    required String text,
    required String analysisType,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio _dio;
  NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<String> analyzeText({
    required String text,
    required String analysisType,
  }) async {
    final prompt = analysisType == 'stock_news'
        ? '''วิเคราะห์ข่าวหุ้นต่อไปนี้เป็นภาษาไทย:
1. สรุปประเด็นหลัก
2. ผลกระทบต่อหุ้น (บวก/ลบ/กลาง)
3. แนวโน้มระยะสั้นและกลาง
4. สัญญาณที่นักลงทุนควรติดตาม
ข้อความ: $text'''
        : '''วิเคราะห์โค้ดต่อไปนี้เป็นภาษาไทย:
1. สรุปว่าโค้ดทำอะไร
2. Tech Stack ที่ใช้
3. จุดที่น่าสนใจหรือควรปรับปรุง
โค้ด: $text''';

    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final fullUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey';

    print('>>> Calling: $fullUrl');

    final response = await _dio.post(
      fullUrl,
      data: {
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 1024,
        },
      },
    );

    final geminiResponse = GeminiResponse.fromJson(response.data);
    return geminiResponse.candidates.first.content.parts.first.text;
  }
}