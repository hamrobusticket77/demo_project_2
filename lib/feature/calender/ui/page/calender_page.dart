import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/calender/constant/calender_constant.dart';
import 'package:krishi_hub/feature/calender/cubit/calender_cubit.dart';
import 'package:krishi_hub/feature/calender/cubit/crop_index_change_cubit.dart';
import 'package:krishi_hub/feature/calender/cubit/echological_region_cubit.dart';
import 'package:krishi_hub/feature/calender/resource/all_calender_repository.dart';
import 'package:krishi_hub/feature/calender/resource/calender_repository.dart';
import 'package:krishi_hub/feature/calender/ui/widget/calender_widgte.dart';
import 'package:krishi_hub/feature/crop_type/cubit/get_all_crop_categories_cubit.dart';
import 'package:krishi_hub/feature/crop_type/resource/crop_repository.dart';


class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllCropCategoriesCubit(
            cropRepository: RepositoryProvider.of<CropRepository>(context),
          )..getAllCropCategories(),
        ),
        BlocProvider(
            create: (context) => EcologicalRegionCubit(
                  calenderRepository:
                      RepositoryProvider.of<CalenderRepository>(context),
                )),
        BlocProvider(
            create: (context) => CropIndexChangeCubit(
                  allCalenderRepository:
                      RepositoryProvider.of<AllCalenderRepository>(context),
                  calenderRepository:
                      RepositoryProvider.of<CalenderRepository>(context),
                )),
        BlocProvider(
          create: (context) => CalenderCubit(
            calenderRepository:
                RepositoryProvider.of<CalenderRepository>(context),
          )..getCalender(
              id: 1,
              ecologicalRegion: CalenderConstant.teraiEn,
            ),
        ),
      ],
      child: const CalenderWidget(),
    );
  }
}
