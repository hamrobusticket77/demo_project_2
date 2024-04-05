import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_krishi_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/disease_widget.dart';

class DiseasePage extends StatelessWidget {
  const DiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetKrishiCubit(krishiRepository: RepositoryProvider.of(context))
            ..getKrishi(),
      child: const DiseaseWidget(),
    );
  }
}
