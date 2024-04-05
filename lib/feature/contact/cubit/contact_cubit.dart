import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/contact/resources/contactus_repository.dart';
import '../../../common/cubit/data_state.dart';

class ContactUsCubit extends Cubit<CommonState> {
  ContactUsRepository contactusrepository;
  ContactUsCubit({required this.contactusrepository}) : super(CommonInitial());

  contactus({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String message,
  }) async {
    emit(CommonLoading());
    final res = await contactusrepository.contactus(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      message: message,
    );

    if (res.status == Status.success) {
      emit(CommonSuccess());
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
