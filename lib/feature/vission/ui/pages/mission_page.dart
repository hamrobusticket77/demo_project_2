import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/vission/cubit/get_mission_cubit.dart';

import '../widget/mission_widget.dart';

class Missionpage extends StatelessWidget {
  const Missionpage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetMissionCubit(missionRepository: RepositoryProvider.of(context)
              // ..getmission(),

              ),
      child: const MissionWidget(),
    );
  }
}
