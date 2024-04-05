import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_insurance_directory_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/insurance_widget.dart';

class InsurancePage extends StatelessWidget {
  const InsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInsuranceDirectoryCubit(
        cropCareRepository: RepositoryProvider.of<CropCareRepository>(context),
      )..getInsuranceDirectory(),
      child: const InsuranceWidget(),
    );
  }
}
