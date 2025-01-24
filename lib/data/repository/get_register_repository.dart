// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/networking/api_constants.dart';
import 'package:temple_app/networking/api_manager.dart';

import '../dtos/userInfoDto.dart';


class GetRegisterRepository {
  Future<UserInfoResult> getRegister(String str, int uniqueId) async {
    final response = await ApiManager.get(
      ApiConstant.getRegister + '?Id=' + str + '&Unique_Id='+uniqueId.toString(),
    );
    final data = UserInfoResult.fromJson(response);
    return data;
  }
}

final userProfileProvider = StateProvider<UserInfoResult?>((ref) {
  return;
});

final isAuthenticatedProvider = StateProvider<bool>((ref) {
  return false;
});

final userIdProvider = StateProvider<String?>((ref) {
  return;
});
