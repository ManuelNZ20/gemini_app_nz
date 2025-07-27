import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
User geminiUser(Ref ref) {
  final geminiUser = types.User(
    id: 'gemini-id',
    firstName: 'Gemini',
    imageUrl:
        'https://i.pinimg.com/236x/f8/ae/02/f8ae02fd30497c0fb7495a59ca53f019.jpg',
  );
  return geminiUser;
}

@riverpod
User userBunny(Ref ref) {
  final user = types.User(
    id: 'user-id-abc',
    firstName: 'Manuel',
    lastName: 'Navarro',
    imageUrl:
        'https://i.pinimg.com/236x/f8/ae/02/f8ae02fd30497c0fb7495a59ca53f019.jpg',
  );
  return user;
}
