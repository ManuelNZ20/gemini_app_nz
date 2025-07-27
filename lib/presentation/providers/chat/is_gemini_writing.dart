// provider para trabajar con un objeto elaborado
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_gemini_writing.g.dart';

@riverpod
class IsGeminiWriting extends _$IsGeminiWriting {
  @override
  bool build() => false;

  void setIsWriting() {
    state = true;
  }

  void setIsNotWriting() {
    state = false;
  }
}
