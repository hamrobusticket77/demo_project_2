import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_suboffice_detail_cubit.dart';
import 'package:krishi_hub/feature/phone_book/model/sub_office_model.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/suboffice_detail.dart';

class SubOfficeDetail extends StatelessWidget {
  final SubofficeModel subofficeModel;
  const SubOfficeDetail({super.key, required this.subofficeModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSubOfficeDetailCubit(
          phoneBookRepository: RepositoryProvider.of(context))
        ..getSubOfficeDetail(id: subofficeModel.id),
      child: const SubOfficeDetailWidget(),
    );
  }
}
