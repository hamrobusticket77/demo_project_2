import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/common_svg_widget.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/chat/cubit/all_chat_cubit.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_cubit.dart';
import 'package:krishi_hub/feature/chat/resource/all_question_repository.dart';
import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';
import 'package:krishi_hub/feature/chat/ui/page/chat_page.dart';

import 'package:krishi_hub/feature/chat/cubit/chat_socket_state.dart'
    as chat_state;
import 'package:krishi_hub/feature/home/ui/widget/pull_to_refresh.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({super.key});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    context.read<AllChatCubit>().getQuestionList();
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final allQuestion =
        RepositoryProvider.of<AllQuestionRepository>(context).getQuestions;

    return BlocListener<ChatSocketCubit, chat_state.CommonChatState>(
      listener: (context, state) {
        if (state is chat_state.QuestionCreateSuccess) {
          setState(() {});
        }
      },
      child: BlocListener<AllChatCubit, CommonState>(
        listener: (context, state) {
          if (state is! CommonLoading) {}

          if (state is CommonDataFetchSuccess<String>) {
            _isLoadMoreActive = false;
          }
        },
        child: PopScope(
          onPopInvoked: (value) async {
            RepositoryProvider.of<SocketRepository>(context).logoutSocket();
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: LocaleKeys.chatTitle.tr(),
            ),
            backgroundColor: CustomTheme.lightGray,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    NavigationService.pushNamed(routeName: Routes.chatPage);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const CommonSvgWidget(
                      color: CustomTheme.white,
                      svgName: Assets.chat,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels >
                    scrollNotification.metrics.maxScrollExtent / 2) {
                  if (!_isLoadMoreActive &&
                      _scrollController.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                    _isLoadMoreActive = true;
                    context.read<AllChatCubit>().loadMoreQuestion();
                  }
                }
                return true;
              },
              child: PullToRefresh(
                onRefresh: () async {
                  context.read<AllChatCubit>().reloadQuestion();
                  return Future<void>.delayed(const Duration(seconds: 3));
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                        child: Center(
                          child: Text(''),
                        ),
                      ),
                    ),
                    BlocBuilder<AllChatCubit, CommonState>(
                      buildWhen: (context, state) {
                        if (state is CommonDummyLoading) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is CommonError) {
                          return SliverToBoxAdapter(
                            child: CommonErrorWidget(message: state.message),
                          );
                        } else if (state is CommonNoData) {
                          return const SliverToBoxAdapter(
                            child: CommonNoDataWidget(),
                          );
                        }
                        if (state is CommonLoading) {
                          return const SliverToBoxAdapter(
                            child: ListViewPlaceHolder(),
                          );
                        } else if (state is CommonDataFetchSuccess<String>) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.data.length,
                              (BuildContext context, int index) {
                                final data = allQuestion[state.data[index]];

                                if (data == null) {
                                  return const SizedBox();
                                }
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 0.hp,
                                        left: 0.wp,
                                        right: 0.wp,
                                      ),
                                      child: Material(
                                        color: CustomTheme.lightGray,
                                        child: InkWell(
                                          onTap: () {
                                            NavigationService.push(
                                                target: ChatPage(
                                              questionModel: data,
                                            ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 24.wp,
                                                right: 24.wp,
                                                bottom: 15.hp,
                                                top: 15.hp),
                                            // height: 12.0,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.chat_rounded,
                                                  color: CustomTheme
                                                      .primarymaterialcolor
                                                      .shade300,
                                                ),
                                                SizedBox(width: 20.wp),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Text(
                                                        data.question
                                                            .capitalize(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textTheme
                                                            .titleLarge!
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: CustomTheme
                                                              .darkGrey,
                                                        ),
                                                      ),
                                                      Text(
                                                        data.time,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                          color:
                                                              CustomTheme.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  size: 20,
                                                  color: CustomTheme
                                                      .primarymaterialcolor
                                                      .shade100,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).padding.bottom,
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return const SliverToBoxAdapter(child: SizedBox());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
