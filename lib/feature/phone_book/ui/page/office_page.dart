import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_office_cubit.dart';
import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/office_widget.dart';

class OfficePage extends StatelessWidget {
  final PhoneBookModel phoneBookModel;
  const OfficePage({super.key, required this.phoneBookModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetOfficeCubit(phoneBookRepository: RepositoryProvider.of(context))
            ..getOffice(id: phoneBookModel.id),
      child: const OfficeWidget(),
    );
  }
}
