import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/chat/model/question_model.dart';
import 'package:krishi_hub/feature/chat/ui/widget/chat_widget.dart';

class ChatPage extends StatelessWidget {
  final QuestionModel? questionModel;
  const ChatPage({super.key, this.questionModel});

  @override
  Widget build(BuildContext context) {
    return

        // BlocProvider(
        //   create: (context) => ChatSocketCubit(

        //     socketRepository: RepositoryProvider.of<SocketRepository>(context),
        //   ),
        //   child: ChatWidget(
        //     questionModel: questionModel,
        //   ),
        // );

        ChatWidget(
      questionModel: questionModel,
    );
  }
}
