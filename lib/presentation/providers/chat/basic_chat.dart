import 'package:gemini_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart'
    show Message, PartialText, TextMessage, User;

part 'basic_chat.g.dart';

final uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  @override
  List<Message> build() {
    return [];
  }

  void addMessage({required PartialText partialText, required User user}) {
    // todo: agregar condición cuando vengan imagenes

    _addTextMessage(partialText, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    final message = TextMessage(
      author: author,
      id: uuid.v4(),
      text: partialText.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
    _geminiTextResponse(partialText.text);
  }

  void _geminiTextResponse(String prompt) async {
    final geminiUser = ref.read(geminiUserProvider);
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    isGeminiWriting.setIsWriting();

    await Future.delayed(Duration(seconds: 2));

    isGeminiWriting.setIsNotWriting();

    final message = TextMessage(
      id: uuid.v4(),
      author: geminiUser,
      text: 'Hola Mundo desde Gemini : $prompt',
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    state = [message, ...state];
  }
}
