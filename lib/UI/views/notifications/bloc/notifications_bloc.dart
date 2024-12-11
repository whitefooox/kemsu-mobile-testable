import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_events.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationInitEvent>(_onInit);
  }

  Future<void> _onInit(NotificationInitEvent event, Emitter<NotificationsState> emit) async {
    log('Notifications Init Event');
  }
}
