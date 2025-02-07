import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temple_app/data/dtos/get_all_companies_dto.dart';
import 'package:temple_app/data/dtos/get_img_dto.dart';
import 'package:temple_app/data/dtos/get_img_res_dto.dart';
import 'package:temple_app/data/dtos/mob_num_uniq_res_dto.dart';
import 'package:temple_app/data/dtos/postal_code_response_dto.dart';
import 'package:temple_app/data/dtos/profile_approval_res_dto.dart';
import 'package:temple_app/data/dtos/update_user_profile_res_dto.dart';
import 'package:temple_app/data/dtos/upload_img_req_dto.dart';
import 'package:temple_app/data/dtos/upload_img_res_dto.dart';
import 'package:temple_app/data/dtos/verify_otp_res.dart';
import 'package:temple_app/networking/api_constants.dart';
import 'package:temple_app/networking/api_manager.dart';
import '../dtos/get_register_model_dto.dart';
import '../dtos/login_ model_dto.dart';
import '../dtos/otp_res_dto.dart';
import 'package:http/http.dart' as http;

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

final updateUserProfileProvider =
    FutureProvider.family<UpdateUserProfileResDto, Map<String, dynamic>>(
        (ref, updatedProfile) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final UpdateUserProfileResDto result = await loginRep.updateProfile(updatedProfile);
  return result;
});

final verifyOtpProvider =
    FutureProvider.family<VerifyOtpRes, Map<String, dynamic>>(
        (ref, otpReq) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final VerifyOtpRes result = await loginRep.verifyOtp(otpReq);
  return result;
});

final profileApprovalProvider =
    FutureProvider.family<ApproveProfileResult, Map<String, dynamic>>(
  (ref, id) async {
    final loginRep = ref.read(loginRepositoryProvider);
    final ApproveProfileResult result = await loginRep.approveProfile(id);
    return result;
  },
);

final getAllCompaniesProvider = FutureProvider((ref) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final GetAllCompaniesResponseDto result = await loginRep.getAllCompanies();
  return result;
});

final mobNumberUniquenessProvider =
    FutureProvider.family<CheckNumberUniquenessResponse, Map<String, dynamic>>(
        (ref, req) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final CheckNumberUniquenessResponse result =
      await loginRep.checkMobileNumberAvailability(req);
  return result;
});

final photoUploadProvider =
    FutureProvider.family<ProfilePicUploadRes, FormData>((ref, req) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final ProfilePicUploadRes result = await loginRep.uploadProfilePicture(req);
  return result;
});

final getImageProvider =
    FutureProvider.family<GetImgResDto, Map<String, dynamic>>((ref, req) async {
  final loginRep = ref.read(loginRepositoryProvider);
  final GetImgResDto result = await loginRep.getImage(req);
  print('the image from the api is as follow ${result.result.docUrl}');
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
      final response = await ApiManager.post(ApiConstant.register, body: userInfo);
      final data = UserInfoResultForRegister.fromJson(response as Map<String, dynamic>);
      if (data.statusCode == '1') {
        return data;
      } else {
        return UserInfoResultForRegister(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<UpdateUserProfileResDto> updateProfile(
      Map<String, dynamic> userInfo) async {
    try {
      final response = await ApiManager.post(ApiConstant.updateProfile, body: userInfo);
      final data = UpdateUserProfileResDto.fromJson(response as Map<String, dynamic>);
      return data;
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
      GetOtpRes data = GetOtpRes.fromJson(response as Map<String, dynamic>);
      if (data.status == 'Success') {
        return data;
      } else {
        GetOtpRes data = GetOtpRes.fromJson(response);
        return data;
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
      if (data.statusCode == '1') {
        return data;
      } else {
        return VerifyOtpRes(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<ApproveProfileResult> approveProfile(Map<String, dynamic> id) async {
    try {
      final response =
          await ApiManager.post(ApiConstant.approveProfile, body: id);
      final data =
          ApproveProfileResult.fromJson(response as Map<String, dynamic>);
      print('approval of profile is ${data.status}');
      if (data.statusCode == '1') {
        return data;
      } else {
        return ApproveProfileResult(status: 'failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  uploadProfilePicture(FormData imageFile) async {
    try {
      final response =
          await ApiManager.post(ApiConstant.uploadImage, body: imageFile);
      ProfilePicUploadRes result =
          ProfilePicUploadRes.fromJson(response as Map<String, dynamic>);
      result.result.uniqId;
      if (result.status == 'Success') {
        return result.result.uniqId;
      }
    } catch (ex) {
      rethrow;
    }
  }

  getAllCompanies() async {
    try {
      final response = await ApiManager.get(ApiConstant.getAllCompanies);
      GetAllCompaniesResponseDto result =
          GetAllCompaniesResponseDto.fromJson(response as Map<String, dynamic>);
      print('data returned from the API $response');
      if (result.status == 'Success') {
        return result;
      } else {
        return GetAllCompaniesResponseDto(status: 'Failed');
      }
    } catch (ex) {
      rethrow;
    }
  }

  checkMobileNumberAvailability(Map<String, dynamic> req) async {
    try {
      final response =
          await ApiManager.post(ApiConstant.checkNumberAvailability, body: req);
      CheckNumberUniquenessResponse result =
          CheckNumberUniquenessResponse.fromJson(
              response as Map<String, dynamic>);
      print('data returned from the API $response');
      return result;
    } catch (ex) {
      rethrow;
    }
  }

  Future<GetImgResDto> getImage(Map<String, dynamic> req) async {
    try {
      final response = await ApiManager.post(ApiConstant.getImage, body: req);
      GetImgResDto result =
          GetImgResDto.fromJson(response as Map<String, dynamic>);
      print('the image from the api is as follow ${result.result.docUrl}');
      return result;
    } catch (ex) {
      rethrow;
    }
  }

  //*****************separate third party api to get postal code information******************** */
  getPostalCodeDetails(String postalCode) async {
    try {
      final result =
          await http.get(Uri.parse(ApiConstant.getPostalAddress + postalCode));

      if (result.statusCode == 200) {
        final responseJson = json.decode(result.body);
        return responseJson;
      } else {
        return PostalCodeResponse(status: 'Failed');
      }
    } catch (ex) {
      rethrow;
    }
  }
  //*****************separate third party api to get postal code information******************** */
}
