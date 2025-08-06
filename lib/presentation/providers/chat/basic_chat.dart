import 'package:gemini_app/config/gemini/gemini_impl.dart';
import 'package:gemini_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart'
    show Message, PartialText, TextMessage, User;

part 'basic_chat.g.dart';

final uuid = Uuid();

@riverpod
class BasicChat extends _$BasicChat {
  final gemini = GeminiImpl();
  late User geminiUser;
  @override
  List<Message> build() {
    geminiUser = ref.read(geminiUserProvider);
    return [];
  }

  void addMessage({required PartialText partialText, required User user}) {
    // todo: agregar condición cuando vengan imagenes
    _addTextMessage(partialText, user);
  }

  void _addTextMessage(PartialText partialText, User author) {
    _createTextMessage(partialText.text, author);
    // _geminiTextResponse(partialText.text);
    _geminiTextResponseStream(partialText.text);
  }

  void _geminiTextResponse(String prompt) async {
    _setGeminiWritingStatus(true);

    final textResponse = await gemini.getResponse(prompt);

    _setGeminiWritingStatus(false);
    _createTextMessage(textResponse, geminiUser);
  }

  // Stream version
  void _geminiTextResponseStream(String prompt) async {
    _createTextMessage('Gemini está pensando...', geminiUser);

    gemini.getResponseStream(prompt).listen((responseChunk) {
      if (responseChunk.isEmpty) return;
      final updatedMessages = [...state];
      final updatedMessage = (updatedMessages.first as TextMessage).copyWith(
        text: responseChunk,
      );

      updatedMessages[0] = updatedMessage;
      state = updatedMessages;
    });

    // _createTextMessage(textResponse, geminiUser);
  }

  // Helper methods
  void _createTextMessage(String text, User author) {
    final message = TextMessage(
      id: uuid.v4(),
      author: author,
      text: text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    state = [message, ...state];
  }

  void _setGeminiWritingStatus(bool isWriting) {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    isWriting
        ? isGeminiWriting.setIsWriting()
        : isGeminiWriting.setIsNotWriting();
  }
}
