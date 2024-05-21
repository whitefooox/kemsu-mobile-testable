import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kemsu_app/UI/views/profile_bloc/profile_bloc.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends Equatable {
  final bool success;
  final UserInfo userInfo;
  final String accessToken;
  final String refreshToken;

  const AuthModel({
    required this.success,
    required this.userInfo,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  @override
  List<Object?> get props => [
        success,
        userInfo,
        accessToken,
        refreshToken,
      ];
}

@JsonSerializable()
class UserInfo extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? phone;
  final String? userType;

  String get fullName => '$lastName $firstName $middleName';

  UserType get currentUserType => UserType.values.firstWhere((el) => el.typeName == userType);

  const UserInfo({
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.phone,
    this.userType,
  });

  const UserInfo.guest()
      : firstName = 'Владимир',
        lastName = 'Петров',
        middleName = 'Сергеевич',
        email = 'petrov@gmail.com',
        phone = '+79001001111',
        userType = 'обучающийся';

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        middleName,
        email,
        phone,
        userType,
      ];
}
