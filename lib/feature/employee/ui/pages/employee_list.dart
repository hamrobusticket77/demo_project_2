import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/employee/cubit/get_elective_rep_cubit.dart';
import 'package:krishi_hub/feature/employee/cubit/get_employee_cubit.dart';
import 'package:krishi_hub/feature/employee/resource/employee_repository.dart';

import '../widget/employee_list_widget.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => GetElectiveCubit(
            employeeRepository:
                RepositoryProvider.of<EmployeeRepository>(context))
          ..getElectiveRepresentive(),
      ),
      BlocProvider(
        create: (context) => GetEmployeeCubit(
            employeeRepository:
                RepositoryProvider.of<EmployeeRepository>(context))
          ..getEmployee(),
      ),
    ], child: const EmployeeWidget());
  }
}
