import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/expertise/cubit/get_expertise_detail_cubit.dart';
import 'package:krishi_hub/feature/expertise/ui/widget/expertise_detail_widget.dart';

class ExpertiseDetail extends StatelessWidget {
  final DoctorRecordModel doctorRecordModel;
  const ExpertiseDetail({required this.doctorRecordModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetExpertiseDetailCubit(
          expertiseRepository: RepositoryProvider.of(context))
        ..getExpertiseDetail(id: doctorRecordModel.id),
      child: const ExpertiseDetailWidget(),
    );
  }
}
