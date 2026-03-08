import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class MlKitService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFile(File(imagePath));
    final recognized = await _textRecognizer.processImage(inputImage);
    await _textRecognizer.close();
    return recognized.text;
  }

  void dispose() {
    _textRecognizer.close();
  }
}