import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:product_task/model/home/get_all_product_model.dart';
import 'package:product_task/model/single_product/get_single_product_model.dart';

import '../../core/api/api_baseurl.dart';
import '../../core/api/api_endpoints.dart';
import '../../utils/exception/app_exception.dart';

class GetSingleProductService {
  static Future<GetAllProductsModel?> getSingleProductService(
      String productId, context) async {
    final dio = Dio();

    try {
      final Response response = await dio.get(
        ApiBaseUrl.baseUrl + ApiEndPoints.products,
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        log(response.data.toString());
        return GetAllProductsModel.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      AppException.handleError(e, context);
    }
    return null;
  }
}
