import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/data/dtos/verify_otp_res.dart';
import 'package:temple_app/networking/api_constants.dart';
import 'package:temple_app/networking/api_manager.dart';
import '../dtos/get_register_model_dto.dart';
import '../dtos/login_ model_dto.dart';
import '../dtos/otp_res_dto.dart';


final loginRepositoryProvider = Provider((
  ref,
) {
  return LoginRepository();
});

final loginUserProvider =
    FutureProvider.family<GetOtpRes, Map<String, dynamic>>(
        (ref, mobileNumber) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final GetOtpRes result = await loginRep.getOtp(mobileNumber);
  return result;
});

final registerUserProvider =
    FutureProvider.family<UserInfoResultForRegister, Map<String, dynamic>>(
        (ref, user) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final UserInfoResultForRegister result = await loginRep.registerUser(user);
  return result;
});

final verifyOtpProvider =
    FutureProvider.family<VerifyOtpRes, Map<String, dynamic>>(
        (ref, otpReq) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final VerifyOtpRes result = await loginRep.verifyOtp(otpReq);
  return result;
});

class LoginRepository {
  Future<LoginModelDto> loginCall(String str) async {
    try {
      final response = await ApiManager.post(ApiConstant.login, body: str);
      final data = LoginModelDto.fromJson(response as Map<String, dynamic>);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfoResultForRegister> registerUser(
      Map<String, dynamic> userInfo) async {
    try {
      final response =
          await ApiManager.post(ApiConstant.register, body: userInfo);
      print('data returned from APi $response');
      final data =
          UserInfoResultForRegister.fromJson(response as Map<String, dynamic>);

      if (data.statusCode == '1') {
        return data;
      } else {
        return UserInfoResultForRegister(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserInfoResultForRegister> registerUserMobile(userInfo) async {
    try {
      final response =
          await ApiManager.post(ApiConstant.register, body: userInfo);
      print('data returned from APi $response');
      final data =
          UserInfoResultForRegister.fromJson(response as Map<String, dynamic>);

      if (data.statusCode == '1') {
        return data;
      } else {
        return UserInfoResultForRegister(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<GetOtpRes> getOtp(Map<String, dynamic> otpInfo) async {
    try {
      final response = await ApiManager.post(ApiConstant.getOtp, body: otpInfo);
      final data = GetOtpRes.fromJson(response as Map<String, dynamic>);
      print('data returned from APi $response');
      if (data.statusCode == '1') {
        return data;
      } else {
        return GetOtpRes(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<VerifyOtpRes> verifyOtp(Map<String, dynamic> otpInfo) async {
    try {
      final response =
          await ApiManager.post(ApiConstant.verityOtp, body: otpInfo);
      final data = VerifyOtpRes.fromJson(response as Map<String, dynamic>);
      print('data returned from API $response');
      if (data.statusCode == '1') {
        return data;
      } else {
        return VerifyOtpRes(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }
}
