import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_cubit.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_state.dart';
import 'package:krishi_hub/feature/chat/model/question_model.dart';
import 'package:krishi_hub/feature/chat/resource/all_chat_repository.dart';
import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';
import 'package:krishi_hub/feature/chat/ui/widget/message_item_widet.dart';

class ChatWidget extends StatefulWidget {
  final QuestionModel? questionModel;

  const ChatWidget({
    super.key,
    this.questionModel,
  });

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  void initState() {
    if (widget.questionModel != null) {
      context.read<ChatSocketCubit>().getMessage(widget.questionModel!.id);
    }
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();

  changePosition() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    final chats = RepositoryProvider.of<AllChatRepository>(context);
    return BlocListener<ChatSocketCubit, CommonChatState>(
      listener: (context, state) {
        if (state is QuestionCreateSuccess) {
          NavigationService.pop();
        }
        if (state is CreateQuestionError) {
          CustomToast.error(message: state.message);
        }

        if (state is FetchNewMessageState) {
          setState(() {});
          changePosition();
        }

        if (state is CommonDataFetchSuccess<String>) {
          _isLoadMoreActive = false;
          // setState(() {});
          // changePosition();
        }

        if (state is CommonDummyLoading) {}
      },
      child: PopScope(
        onPopInvoked: (value) {
          if (widget.questionModel != null) {
            RepositoryProvider.of<SocketRepository>(context)
                .leaveChat(widget.questionModel!.id);
          }
        },
        child: Scaffold(
          backgroundColor: CustomTheme.lightGray,
          appBar: CustomAppBar(
            title:
                widget.questionModel?.question ?? LocaleKeys.askQuestion.tr(),
            onBackPressed: () {
              if (widget.questionModel != null) {
                RepositoryProvider.of<SocketRepository>(context)
                    .leaveChat(widget.questionModel!.id);
              }
              Navigator.pop(context);
            },
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              top: 20.hp,
              bottom: 15.hp,
              left: 10.wp,
              right: 10.hp,
            ),
            color: CustomTheme.white,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "${LocaleKeys.typeMessage.tr()}....",
                          hintStyle: const TextStyle(
                              color: CustomTheme.grey, fontSize: 14),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomIconButton(
                      icon: Icons.send,
                      iconColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          if (widget.questionModel == null) {
                            context
                                .read<ChatSocketCubit>()
                                .createQuestion(controller.text);
                          } else {
                            context.read<ChatSocketCubit>().createMessage(
                                message: controller.text.trim(),
                                questionId: widget.questionModel!.id);

                            changePosition();

                            controller.clear();
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp,
            ),
            child: widget.questionModel == null
                ? const SizedBox()
                : BlocBuilder<ChatSocketCubit, CommonChatState>(
                    buildWhen: (context, state) {
                      if (state is CommonDummyLoading) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is CommonLoading) {
                        return const ListViewPlaceHolder();
                      } else if (state is GetChatError) {
                        return CommonErrorWidget(message: state.message);
                      } else if (state is CommonNoData) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                child: CommonNoDataWidget(
                                  message: "No Messages",
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (state is CommonDataFetchSuccess<String>) {
                        return NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (scrollNotification.metrics.pixels >
                                  scrollNotification.metrics.minScrollExtent /
                                      2) {
                                if (!_isLoadMoreActive &&
                                    _scrollController
                                            .position.userScrollDirection ==
                                        ScrollDirection.reverse) {
                                  _isLoadMoreActive = true;
                                  context
                                      .read<ChatSocketCubit>()
                                      .loadMoreMessage();
                                }
                              }
                              return true;
                            },
                            child: SingleChildScrollView(
                                controller: _scrollController,
                                reverse: true,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10.hp),
                                    ...List.generate(state.data.length,
                                        (index) {
                                      final data =
                                          chats.getMessage[state.data[index]];

                                      if (data == null) {
                                        return const SizedBox();
                                      }

                                      return MessageItemWidget(data: data);
                                    }),
                                    SizedBox(height: 10.hp),
                                    SizedBox(
                                        height: 50.hp +
                                            MediaQuery.of(context)
                                                .padding
                                                .bottom)
                                  ],
                                )));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
