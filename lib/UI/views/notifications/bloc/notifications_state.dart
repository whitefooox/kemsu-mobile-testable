part of 'notifications_bloc.dart';

enum NotificationStatus { loading, active, error }

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = NotificationStatus.loading,
  });

  final NotificationStatus status;

  NotificationsState copyWith({
    NotificationStatus? status,
  }) {
    return NotificationsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
