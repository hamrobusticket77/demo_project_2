import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_svg_widget.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/auto_scroll/auto_scrollable_widget.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/crop_care_page.dart';
import 'package:krishi_hub/feature/employee/ui/pages/palika_contact_page.dart';
import 'package:krishi_hub/feature/expertise/ui/page/expertise_page.dart';
import 'package:krishi_hub/feature/feedback/ui/pages/feedback_page.dart';
import 'package:krishi_hub/feature/home/ui/widget/pull_to_refresh.dart';
import 'package:krishi_hub/feature/home/ui/widget/slider_widget.dart';
import 'package:krishi_hub/feature/krishi_knowledge/constant/agriculture_knowledge_type.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/common_agriculture_knowledge.dart';
import 'package:krishi_hub/feature/market_price/ui/pages/wholesaller_price.dart';
import 'package:krishi_hub/feature/market_price/ui/pages/market_page.dart';
import 'package:krishi_hub/feature/office_setup/ui/pages/call_center_page.dart';
import 'package:krishi_hub/feature/phone_book/ui/page/phone_book_page.dart';
import 'package:krishi_hub/feature/office_setup/cubit/get_officesetup_cubit.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/reference_content_cubit.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/page/refrence_content_page.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/widget/reference_content_home_widget.dart';
import 'package:krishi_hub/feature/weather/ui/pages/weather_page.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/auth/ui/page/login_page.dart';
import 'package:krishi_hub/feature/downloads/ui/pages/dowload_pages.dart';
import 'package:krishi_hub/feature/home/ui/widget/home_service_title_widget.dart';
import 'package:krishi_hub/feature/home/ui/widget/service_card%20copy.dart';
import 'package:krishi_hub/feature/images/ui/pages/album_page.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_home_krishi_cubit.dart';
import 'package:krishi_hub/feature/news/cubit/get_news_cubit.dart';
import 'package:krishi_hub/feature/news/cubit/get_scrollable_news.dart';
import 'package:krishi_hub/feature/news/model/news_model.dart';
import 'package:krishi_hub/feature/news/ui/page/new_list_page.dart';
import 'package:krishi_hub/feature/news/ui/widget/news_details_widget.dart';
import 'package:krishi_hub/feature/notification/ui/page/notification_list_page.dart';
import 'package:krishi_hub/feature/notification/utils/notification_utils.dart';
import 'package:krishi_hub/feature/slider/cubit/get_slider_cubit.dart';
import 'package:krishi_hub/feature/video/cubit/get_video_cubit.dart';
import 'package:krishi_hub/feature/video/ui/pages/video_player.dart';
import 'kirishi_widget.dart';
import 'news_widgets.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _isUserLogin() {
    final isLoggedIn =
        RepositoryProvider.of<AuthRepository>(context).isLoggedIn;
    if (isLoggedIn.value) {
      return true;
    } else {
      return false;
    }
  }

  fetchHomeData() async {
    Future.sync(() {
      context.read<GetScrollableNews>().reloadScrollableNews();
      context.read<GetSliderCubit>().reloadSlider();
      // context.read<GetKrishiCubit>().getKrishi();
      context.read<GetHomeKrishiCubit>().getHomeKrisiKnowledge();
      context.read<GetVideoCubit>().getVideos();
      context.read<GetNewsCubit>().getNews();
      context.read<GetOfficeSetupCubit>().getOfficeSetup();
      context.read<ReferenceContentCubit>().getReferenceContent();
    });
  }

  _loginHandler({required context, required String route}) {
    if (_isUserLogin()) {
      NavigationService.pushNamed(routeName: route);
    } else {
      NavigationService.push(target: const LoginPage(loginFromOtherPage: true))
          .then((value) {
        if (value != null && value == true) {
          NavigationService.pushNamed(routeName: route);
        }
      });
    }
  }

  @override
  void dispose() {
    // _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final textTheme = Theme.of(context).textTheme;

    final env = RepositoryProvider.of<Env>(context);

    return BlocListener<GetScrollableNews, CommonState>(
      listener: (context, state) {
        // if (state is! CommonLoading) {
        //   // _refreshController.refreshCompleted();
        // }
      },
      child: PullToRefresh(
        onRefresh: () async {
          fetchHomeData();
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: CheckLocal.check(env.environment.appHomeTitle),
                showBackButton: false,
                centerMiddle: false,
                actions: [
                  Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              NavigationService.push(
                                  target: const NotificationListPage());
                            },
                            child: Container(
                              // constraints: BoxConstraints(maxHeight: 20),
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  const CommonSvgWidget(
                                    svgName: Assets.bell,
                                    color: CustomTheme.white,
                                    height: 20,
                                    width: 20,
                                  ),
                                  ValueListenableBuilder(
                                    valueListenable:
                                        NotificationUtils.notificationCount,
                                    builder: ((context, value, child) {
                                      if (value <= 0) {
                                        return const SizedBox();
                                      } else {
                                        return Positioned(
                                            right: 0,
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                  color: CustomTheme.red,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                constraints:
                                                    const BoxConstraints(
                                                  minWidth: 12,
                                                  minHeight: 12,
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                )));
                                      }
                                    }),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              color: CustomTheme.white,
              // height: 35.hp,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        child: Text(
                          LocaleKeys.news.tr(),
                          style: textTheme.bodyLarge,
                        )),
                  ),
                  const SizedBox(),
                  Expanded(
                    child: BlocBuilder<GetScrollableNews, CommonState>(
                      buildWhen: (context, state) {
                        if (state is CommonDummyLoading) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is CommonDataFetchSuccess<NewsModel>) {
                          return ScrollLoopAutoScroll(
                              enableScrollInput: false,
                              duration: const Duration(minutes: 20),
                              reverseScroll: false,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    state.data.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            NavigationService.push(
                                                target: NewsDetailsWidget(
                                                    newsModel:
                                                        state.data[index]));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            // height: 50,
                                            child: Text(state.data[index].title,
                                                style: textTheme.titleLarge),
                                          ),
                                        )),
                              ));
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  )
                ],
              ),
            )),
            SpacerWidget(
              height: 0.hp,
            ),
            const SliderWidget(),
            const SpacerWidget(),
            // const SpacerWidget(),
            HomeServiceTitleWidget(
              title: LocaleKeys.ourServices.tr(),
            ),
            SliverToBoxAdapter(
                child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 5.hp, horizontal: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                crossAxisSpacing: 0,
                mainAxisSpacing: 5.hp,
              ),
              children: [
                ServiceCard(
                  imagePath: Assets.animalhusbandary,
                  serviceTitle: LocaleKeys.agriculturehusbandaryknowledge.tr(),
                  onPressed: () {
                    NavigationService.push(
                      target: CommonAgricultureKnowledge(
                        data: KnowledgetTypeModel.animalHusbandary(),
                      ),
                    );
                  },
                ),
                ServiceCard(
                  imagePath: Assets.cropKnowledge,
                  serviceTitle: LocaleKeys.cropknowledge.tr(),
                  onPressed: () {
                    NavigationService.push(
                      target: CommonAgricultureKnowledge(
                        data: KnowledgetTypeModel.crop(),
                      ),
                    );
                  },
                ),
                ServiceCard(
                  imagePath: Assets.worm,
                  serviceTitle: LocaleKeys.diseaseworm.tr(),
                  onPressed: () {
                    NavigationService.push(
                        target: CommonAgricultureKnowledge(
                      data: KnowledgetTypeModel.disease(),
                    ));
                  },
                ),
                ServiceCard(
                  imagePath: Assets.training,
                  serviceTitle: LocaleKeys.training.tr(),
                  onPressed: () {
                    _loginHandler(
                      context: context,
                      route: Routes.tranninglist,
                    );
                  },
                ),
                ServiceCard(
                  imagePath: Assets.demand,
                  serviceTitle: LocaleKeys.subsidy.tr(),
                  onPressed: () {
                    _loginHandler(context: context, route: Routes.demandlist);
                  },
                ),
                ServiceCard(
                  imagePath: Assets.agriculture,
                  serviceTitle: LocaleKeys.projectprogram.tr(),
                  onPressed: () {
                    _loginHandler(
                        context: context, route: Routes.agicultureplan);
                  },
                ),
                ServiceCard(
                  imagePath: Assets.disease,
                  serviceTitle: LocaleKeys.diseaseTitle.tr(),
                  onPressed: () {
                    _loginHandler(context: context, route: Routes.diseasePage);
                  },
                ),
                ServiceCard(
                  imagePath: Assets.product,
                  serviceTitle: LocaleKeys.productTitle.tr(),
                  onPressed: () {
                    _loginHandler(
                      context: context,
                      route: Routes.productFormPage,
                    );
                  },
                ),
                ServiceCard(
                  imagePath: Assets.marketPrice,
                  serviceTitle: LocaleKeys.marketPrice.tr(),
                  onPressed: () {
                    NavigationService.push(target: const MarketPage());
                  },
                ),
                // ServiceCard(
                //   imagePath: Assets.wholesaler,
                //   serviceTitle: LocaleKeys.wholeSaler.tr(),
                //   onPressed: () {
                //     NavigationService.push(target: const WholeSallerPrice());
                //   },
                // ),
                ServiceCard(
                  imagePath: Assets.cropCalendar.tr(),
                  serviceTitle: LocaleKeys.calenderTitle.tr(),
                  onPressed: () {
                    _loginHandler(
                      context: context,
                      route: Routes.calenderPage,
                    );
                  },
                ),
                ServiceCard(
                  imagePath: Assets.weatherHome,
                  serviceTitle: LocaleKeys.weather.tr(),
                  onPressed: () {
                    NavigationService.push(target: const WeatherPage());
                  },
                ),
                ServiceCard(
                  imagePath: Assets.shopContact,
                  serviceTitle: LocaleKeys.expertAndShopContact.tr(),
                  onPressed: () {
                    NavigationService.push(target: const CropCarePage());
                  },
                ),
                // ServiceCard(
                //   imagePath: Assets.chatHome,
                //   serviceTitle: LocaleKeys.chatTitle.tr(),
                //   onPressed: () {
                //     _loginHandler(context: context, route: Routes.chatListPage);
                //   },
                // ),
                ServiceCard(
                  imagePath: Assets.callCenter,
                  serviceTitle: LocaleKeys.callcenter.tr(),
                  onPressed: () {
                    NavigationService.push(target: const CallcenterPage());
                  },
                ),
                ServiceCard(
                  imagePath: Assets.feedback,
                  serviceTitle: LocaleKeys.feedback.tr(),
                  onPressed: () {
                    NavigationService.push(target: const FeedBackPage());
                    // _loginHandler(context: context, route: Routes.feedBackPage);
                  },
                ),
                ServiceCard(
                  imagePath: Assets.agricultureBranchContact,
                  serviceTitle: LocaleKeys.agricultureBranchContact.tr(),
                  onPressed: () {
                    NavigationService.push(target: const PhoneBookPage());
                  },
                ),
                ServiceCard(
                  imagePath: Assets.palikaContact,
                  serviceTitle: LocaleKeys.palikaContact.tr(),
                  onPressed: () {
                    NavigationService.push(target: const PalikaContactPage());
                  },
                ),
                ServiceCard(
                  imagePath: Assets.download,
                  serviceTitle: LocaleKeys.downloads.tr(),
                  onPressed: () {
                    NavigationService.push(target: const DownloadPages());
                  },
                ),
                ServiceCard(
                  imagePath: Assets.images,
                  serviceTitle: LocaleKeys.image.tr(),
                  onPressed: () {
                    NavigationService.push(target: const AlbumPage());
                  },
                ),
                ServiceCard(
                  imagePath: Assets.video,
                  serviceTitle: LocaleKeys.video.tr(),
                  onPressed: () {
                    NavigationService.push(target: const VideoPlayer());
                  },
                ),
                // ServiceCard(
                //   imagePath: Assets.expert,
                //   serviceTitle: LocaleKeys.expertis.tr(),
                //   onPressed: () {
                //     NavigationService.push(target: const Expertisepage());
                //   },
                // ),
              ],
            )),
            const SpacerWidget(),
            HomeServiceTitleWidget(
              hasViewAll: true,
              title: LocaleKeys.krishiknowledge.tr(),
              onPressed: () {
                _loginHandler(context: context, route: Routes.krishiknowledge);
              },
            ),
            const KrishiWidget(),
            const SpacerWidget(),
            HomeServiceTitleWidget(
              hasViewAll: true,
              title: LocaleKeys.newsAndEvent.tr(),
              onPressed: () {
                NavigationService.push(target: const NewsListPage());
              },
            ),
            const NewsWidget(),
            const SpacerWidget(),
            HomeServiceTitleWidget(
              title: LocaleKeys.referenceMaterial.tr(),
              hasViewAll: true,
              onPressed: () {
                NavigationService.push(target: const ReferenceContentPage());
              },
            ),
            const ReferenceContentHomeWidget(),
            const SpacerWidget(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SpacerWidget extends StatelessWidget {
  final double height;
  const SpacerWidget({
    super.key,
    this.height = 18,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
      ),
    );
  }
}
