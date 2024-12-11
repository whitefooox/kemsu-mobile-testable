part of 'notifications_bloc.dart';

abstract class NotificationsEvents extends Equatable {}

class NotificationInitEvent extends NotificationsEvents {
  NotificationInitEvent();

  @override
  List<Object?> get props => [];
}
