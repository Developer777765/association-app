import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../networking/api_constants.dart';
import '../../networking/api_manager.dart';
import '../dtos/dashboard_model_dto.dart';

class DashboardRepository {
  Future<DashboardModelDto> getDashBoard() async {
    try {
      final response = await ApiManager.get(ApiConstant.getDashboardList);
      final data = DashboardModelDto.fromJson(response);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

final getDashboardProvider =
    FutureProvider.family<DashboardModelDto, String>((ref, body) async {
  await Future.delayed(const Duration(seconds: 1));
  final res = await DashboardRepository().getDashBoard();
  return res;
});
