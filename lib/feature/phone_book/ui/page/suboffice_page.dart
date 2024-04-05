import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_suboffice_cubit.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/model/sub_office_model.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/suboffice_widget.dart';

class Suboffice extends StatelessWidget {
  final OfficeModel suboffice;
  const Suboffice({super.key, required this.suboffice});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetSubOfficeCubit(phoneBookRepository: RepositoryProvider.of(context))
            ..getSubOffice(
              departement: suboffice.department.id,
              office: suboffice.id,
            ),
      child: const SubOfficeWidget(),
    );
  }
}
