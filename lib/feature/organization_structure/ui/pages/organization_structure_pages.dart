import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/organization_structure/cubit/get_organization_cubit.dart';

import '../widget/organization_widget.dart';

class OrganizationStructure extends StatelessWidget {
  const OrganizationStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetOrganizationCubit(
          organizationRepository: RepositoryProvider.of(context))
        ..getOrganization(),
      child: const OrganizationListWidget(),
    );
  }
}
