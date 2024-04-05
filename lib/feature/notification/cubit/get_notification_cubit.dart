import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/notification/cubit/update_notification_cubit.dart';
import 'package:krishi_hub/feature/notification/resource/notification_repository.dart';

class GetNotificationCubit extends Cubit<CommonState> {
  final NotificationRepository notificationRepository;

  final UpdateNotificationCubit updateNotificationCubit;

  StreamSubscription? updateNotificationStream;
  GetNotificationCubit({
    required this.notificationRepository,
    required this.updateNotificationCubit,
  }) : super(CommonInitial()) {
    updateNotificationStream = updateNotificationCubit.stream.listen((event) {
      if (state is CommonSuccess) {
        _refetchNotification();
      }
    });
  }

  _refetchNotification() {
    if (notificationRepository.getItems.isNotEmpty) {
      emit(CommonDataFetchSuccess<String>(
          data: notificationRepository.getItems));
    } else {
      emit(const CommonNoData());
    }
  }

  getNotification() async {
    emit(CommonLoading());
    final res = await notificationRepository.getNotificaiton();

    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMoreNotification({String? searchItem}) async {
    emit(CommonDummyLoading());
    final res = await notificationRepository.getNotificaiton(
      isLoadMore: true,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<String>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<String>(
            data: notificationRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(
          data: notificationRepository.getItems));
    }
  }

  reloadNotification() async {
    // emit(CommonDataFetchSuccess<String>(data: notificationRepository.getItems));
    emit(CommonDummyLoading());

    final res = await notificationRepository.getNotificaiton();

    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(CommonDataFetchSuccess<String>(
            data: notificationRepository.getItems));
      }
    } else {
      emit(CommonDataFetchSuccess<String>(
          data: notificationRepository.getItems));
    }
  }
}
