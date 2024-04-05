import 'package:krishi_hub/feature/chat/model/old_message.dart';

class AllChatRepository {
  final Map<String, OldMessage> _message = {};
  Map<String, OldMessage> get getMessage => _message;

  addAll(Map<String, OldMessage> other) {
    _message.addAll(other);
  }

  add(OldMessage other) {
    _message[other.id] = other;
  }

  removeAll() {
    _message.clear();
  }
}
