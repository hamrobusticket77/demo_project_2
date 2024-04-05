import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_doctor_record_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_Widget.dart';

class DoctorRecordPage extends StatelessWidget {
  const DoctorRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDoctorRecordCubit(
        cropCareRepository: RepositoryProvider.of<CropCareRepository>(context),
      )..getDoctorRecord(),
      child: const DoctorRecordWidget(),
    );
  }
}
