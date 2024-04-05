import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_cubit.dart';
import 'package:krishi_hub/feature/chat/resource/all_chat_repository.dart';
import 'package:krishi_hub/feature/chat/resource/all_question_repository.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_doctor_record_cubit.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_fertilizer_store_cubit.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_seed_store_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_all_crop_categories_cubit.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_crop_by_categoryId_cubit.dart';
import 'package:krishi_hub/feature/crop_type/resource/crop_repository.dart';
import 'package:krishi_hub/feature/filter/cubit/product_list_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/disease_report_cubit.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_market_price_cubit.dart';
import 'package:krishi_hub/feature/filter/cubit/market_list_cubit.dart';
import 'package:krishi_hub/feature/filter/cubit/product_category_cubit.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';
import 'package:krishi_hub/feature/chat/cubit/all_chat_cubit.dart';
import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_phone_book_cubit.dart';
import 'package:krishi_hub/feature/phone_book/resources/phone_book_repository.dart';
import 'package:krishi_hub/feature/product/cubit/delete_product_cubit.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/reference_content_cubit.dart';
import 'package:krishi_hub/feature/weather/cubit/get_five_days_weather_cubit.dart';
import 'package:krishi_hub/feature/weather/cubit/get_weather_cubit.dart';
import 'package:krishi_hub/feature/weather/resources/weather_repository.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/delete_agriculture_plan.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/get_agriculture_plan_cubit.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';
import 'package:krishi_hub/feature/auth/cubit/farmer_request_cubit.dart';
import 'package:krishi_hub/feature/auth/cubit/login_cubit.dart';
import 'package:krishi_hub/feature/auth/cubit/logout_cubit.dart';
import 'package:krishi_hub/feature/auth/cubit/update_cubit.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

import 'package:krishi_hub/feature/contact/cubit/contact_cubit.dart';
import 'package:krishi_hub/feature/contact/resources/contactus_repository.dart';
import 'package:krishi_hub/feature/demand/cubit/delete_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/cubit/get_demand_list_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/downloads/cubit/get_download_cubit.dart';
import 'package:krishi_hub/feature/downloads/resources/download_repository.dart';
import 'package:krishi_hub/feature/employee/resource/employee_repository.dart';
import 'package:krishi_hub/feature/faq/cubit/get_faq_cubit.dart';
import 'package:krishi_hub/feature/faq/resources/faq_repository.dart';
import 'package:krishi_hub/feature/feedback/cubit/delete_feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/cubit/feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/cubit/get_feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_repository.dart';
import 'package:krishi_hub/feature/images/cubit/get_album_cubit.dart';
import 'package:krishi_hub/feature/images/resources/images_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_home_krishi_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_krishi_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';
import 'package:krishi_hub/feature/news/cubit/get_notice_dialog.dart';
import 'package:krishi_hub/feature/news/cubit/get_scrollable_news.dart';
import 'package:krishi_hub/feature/notification/cubit/get_notification_cubit.dart';
import 'package:krishi_hub/feature/notification/cubit/update_notification_cubit.dart';
import 'package:krishi_hub/feature/notification/resource/notification_repository.dart';
import 'package:krishi_hub/feature/office_setup/cubit/get_officesetup_cubit.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_repository.dart';
import 'package:krishi_hub/feature/organization_structure/cubit/get_organization_cubit.dart';
import 'package:krishi_hub/feature/organization_structure/resources/organization_repository.dart';

import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';
import 'package:krishi_hub/feature/project/cubit/planing_service_cubit.dart';
import 'package:krishi_hub/feature/project/cubit/program_cubit.dart';
import 'package:krishi_hub/feature/project/cubit/project_cubit.dart';
import 'package:krishi_hub/feature/project/cubit/seed_category_cubit.dart';
import 'package:krishi_hub/feature/project/resource/project_repository.dart';
import 'package:krishi_hub/feature/slider/cubit/get_slider_cubit.dart';
import 'package:krishi_hub/feature/slider/resource/slider_repository.dart';
import 'package:krishi_hub/feature/traning/cubit/get_training_cubit.dart';
import 'package:krishi_hub/feature/traning/resources/traning_repository.dart';
import 'package:krishi_hub/feature/video/cubit/get_video_cubit.dart';
import 'package:krishi_hub/feature/video/resource/video_repository.dart';
import 'package:krishi_hub/feature/vission/cubit/get_mission_cubit.dart';
import 'package:krishi_hub/feature/vission/resource/vision_repository.dart';
import '../../feature/employee/cubit/get_employee_cubit.dart';
import '../../feature/news/cubit/get_news_cubit.dart';
import '../../feature/news/resource/news_repository.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  final Env env;

  const MultiBlocWrapper({Key? key, required this.child, required this.env})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNewsCubit>(
          // Specify the type parameter here
          create: (context) => GetNewsCubit(
            newsRepository: RepositoryProvider.of<NewsRepository>(context),
          ),
        ),
        BlocProvider<GetScrollableNews>(
            // Specify the type parameter here
            create: (context) => GetScrollableNews(
                  newsRepository:
                      RepositoryProvider.of<NewsRepository>(context),
                )),
        BlocProvider(
            create: (context) => DownloadCubit(
                downloadRepository:
                    RepositoryProvider.of<DownloadRepository>(context))),
        BlocProvider<GetMissionCubit>(
            create: (context) => GetMissionCubit(
                missionRepository:
                    RepositoryProvider.of<MissionRepository>(context))),
        BlocProvider(
          create: (context) => FeedbackCubit(
              feedbackrepository:
                  RepositoryProvider.of<FeedbackRepository>(context)),
        ),
        BlocProvider<GetEmployeeCubit>(
          create: (context) => GetEmployeeCubit(
              employeeRepository:
                  RepositoryProvider.of<EmployeeRepository>(context)),
        ),

        BlocProvider(
            create: (context) => ContactUsCubit(
                contactusrepository:
                    RepositoryProvider.of<ContactUsRepository>(context))),
        BlocProvider(
            create: (context) => FAQCubit(
                faqRepository: RepositoryProvider.of<FAQRepository>(context))),
        BlocProvider(
            create: (context) => GetAlbumCubit(
                imagesRepository:
                    RepositoryProvider.of<ImagesRepository>(context))),
        BlocProvider(
            create: (context) => GetOrganizationCubit(
                organizationRepository:
                    RepositoryProvider.of<OrganizationRepository>(context))),
        BlocProvider(
            create: (context) => GetKrishiCubit(
                krishiRepository:
                    RepositoryProvider.of<KrishiRepository>(context))),

        BlocProvider(
            create: (context) => ContactUsCubit(
                contactusrepository:
                    RepositoryProvider.of<ContactUsRepository>(context))),
        BlocProvider(
            create: (context) => FAQCubit(
                faqRepository: RepositoryProvider.of<FAQRepository>(context))),
        BlocProvider(
            create: (context) => GetAlbumCubit(
                imagesRepository:
                    RepositoryProvider.of<ImagesRepository>(context))),
        BlocProvider(
            create: (context) => GetOrganizationCubit(
                organizationRepository:
                    RepositoryProvider.of<OrganizationRepository>(context))),
        BlocProvider(
            create: (context) => GetKrishiCubit(
                krishiRepository:
                    RepositoryProvider.of<KrishiRepository>(context))),
        BlocProvider(
            create: (context) => GetHomeKrishiCubit(
                krishiRepository:
                    RepositoryProvider.of<KrishiRepository>(context))),
        BlocProvider(
            create: (context) => GetVideoCubit(
                videoRepository:
                    RepositoryProvider.of<VideoRepository>(context))),
        BlocProvider(
          create: ((context) => LoginCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context))),
        ),
        BlocProvider(
            create: (context) => GetSliderCubit(
                sliderRepository:
                    RepositoryProvider.of<SliderRepository>(context))),
        BlocProvider(
            create: (context) => GetFeedbackCubit(
                feedbackRepository:
                    RepositoryProvider.of<FeedbackRepository>(context))),
        BlocProvider(
          create: ((context) => LogoutCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context))),
        ),
        BlocProvider(
          create: ((context) => FiscalYearCubit(
              projectRepository:
                  RepositoryProvider.of<ProjectRepository>(context))),
        ),
        BlocProvider(
          create: ((context) => ProgramCubit(
              projectRepository:
                  RepositoryProvider.of<ProjectRepository>(context))),
        ),
        BlocProvider(
            create: (context) => PlaningServiceCubit(
                projectRepository:
                    RepositoryProvider.of<ProjectRepository>(context))),
        BlocProvider(
          create: ((context) => ProjectCubit(
              projectRepository:
                  RepositoryProvider.of<ProjectRepository>(context))),
        ),
        BlocProvider(
          create: ((context) => SeedCategoryCubit(
              projectRepository:
                  RepositoryProvider.of<ProjectRepository>(context))),
        ),
        BlocProvider(
          create: (context) => GetDemandListCubit(
            demandlistRepository:
                RepositoryProvider.of<DemandRepository>(context),
          ),
        ),
        BlocProvider(
            create: (context) => GetAgricultureCubit(
                agricultureRepository:
                    RepositoryProvider.of<AgricultureRepository>(context))),
        BlocProvider(
          create: (context) => DeleteAgricluturePlan(
            agricultureRepository:
                RepositoryProvider.of<AgricultureRepository>(context),
          ),
        ),
        BlocProvider(
            create: (context) => DeleteDemand(
                demandRepository:
                    RepositoryProvider.of<DemandRepository>(context))),
        // BlocProvider(
        //   create: (context) => ApplyTraningCubit(
        //     traningRepository:
        //         RepositoryProvider.of<TrainingRepository>(context),
        //   ),
        // ),
        BlocProvider(
            create: (context) => DeleteFeedback(
                feedbackRepository:
                    RepositoryProvider.of<FeedbackRepository>(context))),
        BlocProvider(
            create: (context) => GetOfficeSetupCubit(
                callcenterRepository:
                    RepositoryProvider.of<CallCenterRepository>(context))),
        BlocProvider(
            create: (context) => UpdateCubit(
                authRepository:
                    RepositoryProvider.of<AuthRepository>(context))),
        BlocProvider(
            create: (context) => GetNewsDialog(
                newsRepository:
                    RepositoryProvider.of<NewsRepository>(context))),
        BlocProvider(
            create: (context) => FarmerRequestCubit(
                authRepository:
                    RepositoryProvider.of<AuthRepository>(context))),
        // BlocProvider(
        //     create: (context) => ApplyDemandCubit(
        //         demandRepository:
        //             RepositoryProvider.of<DemandRepository>(context))),
        BlocProvider(
          create: (context) => GetTrainingCubit(
            traningRepository:
                RepositoryProvider.of<TrainingRepository>(context),
          ),
        ),
        BlocProvider(
            create: (context) => UpdateNotificationCubit(
                notificationRepository:
                    RepositoryProvider.of<NotificationRepository>(context))),
        BlocProvider(
            create: (context) => GetNotificationCubit(
                updateNotificationCubit:
                    RepositoryProvider.of<UpdateNotificationCubit>(context),
                notificationRepository:
                    RepositoryProvider.of<NotificationRepository>(context))),

        BlocProvider(
            create: (context) => GetAllCropCategoriesCubit(
                  cropRepository:
                      RepositoryProvider.of<CropRepository>(context),
                )),

        BlocProvider(
          create: (context) => GetWeatherCubit(
            weatherRepository:
                RepositoryProvider.of<WeatherRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => GetFiveDaysWeatherCubit(
            weatherRepository:
                RepositoryProvider.of<WeatherRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => GetMarketPriceCubit(
            marketPriceRepository:
                RepositoryProvider.of<MarketPriceRepository>(context),
          ),
        ),
        // BlocProvider(
        //     create: (context) => CreateProductCubit(
        //           productRepository:
        //               RepositoryProvider.of<ProductRepository>(context),
        //         )),
        // BlocProvider(
        //     create: (context) => ProductCubit(
        //           createProductCubit:
        //               RepositoryProvider.of<CreateProductCubit>(context),
        //           productRepository:
        //               RepositoryProvider.of<ProductRepository>(context),
        //         )),
        BlocProvider(
            create: (context) => GetCropByCategoryIdCubit(
                  cropRepository:
                      RepositoryProvider.of<CropRepository>(context),
                )),

        BlocProvider(
            create: (context) => ChatSocketCubit(
                  allChatRepository:
                      RepositoryProvider.of<AllChatRepository>(context),
                  socketRepository:
                      RepositoryProvider.of<SocketRepository>(context),
                )),

        BlocProvider(
          create: (context) => AllChatCubit(
            allQuestionRepository:
                RepositoryProvider.of<AllQuestionRepository>(context),
            socketRepository: RepositoryProvider.of<SocketRepository>(context),
            chatSocketCubit: RepositoryProvider.of<ChatSocketCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) => GetPhoneBookCubit(
            phoneBookRepository:
                RepositoryProvider.of<PhoneBookRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => GetDoctorRecordCubit(
            cropCareRepository:
                RepositoryProvider.of<CropCareRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => GetFertilizerStoreCubit(
            cropCareRepository:
                RepositoryProvider.of<CropCareRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => GetSeedStoreCubit(
            cropCareRepository:
                RepositoryProvider.of<CropCareRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => DiseaseReportCubit(
            krishiRepository: RepositoryProvider.of<KrishiRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => DeleteProductCubit(
            productRepository:
                RepositoryProvider.of<ProductRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ReferenceContentCubit(
            newsRepository: RepositoryProvider.of<NewsRepository>(context),
          ),
        ),

        BlocProvider(
          create: (context) => MarketListCubit(
            marketPriceRepository:
                RepositoryProvider.of<MarketPriceRepository>(context),
          ),
        ),

        BlocProvider(
          create: (context) => ProductCategoryCubit(
            productRepository:
                RepositoryProvider.of<ProductRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => ProductListCubit(
            productRepository:
                RepositoryProvider.of<ProductRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
