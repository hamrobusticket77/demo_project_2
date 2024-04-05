import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/office_setup/cubit/get_officesetup_cubit.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_repository.dart';
import 'package:krishi_hub/feature/office_setup/ui/widget/office_setup_widget.dart';

class OfficeSetup extends StatelessWidget {
  const OfficeSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetOfficeSetupCubit(
          callcenterRepository:
              RepositoryProvider.of<CallCenterRepository>(context)),
      child: const CallCenterWidget(),
    );
  }
}
