import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_phone_book_cubit.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/phone_book_widget.dart';

class PhoneBookPage extends StatelessWidget {
  const PhoneBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetPhoneBookCubit(phoneBookRepository: RepositoryProvider.of(context))
            ..getPhoneBook(),
      child: const PhoneBookWidget(),
    );
  }
}
