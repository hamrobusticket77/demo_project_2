import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_agriculture_equipment_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/agriculture_equipment_widget.dart';

class AgricultureEquipementPage extends StatelessWidget {
  const AgricultureEquipementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAgricultureEquipmentCubit(
        cropCareRepository: RepositoryProvider.of<CropCareRepository>(context),
      )..getAgricultureEquipment(),
      child: const AgricultureEquipmentWidget(),
    );
  }
}
