import 'package:flutter/material.dart';
import 'package:product_task/model/home/get_all_product_model.dart';

import '../../model/single_product/get_single_product_model.dart';
import '../../service/single_product/get_single_product_service.dart';

class SingleProductController with ChangeNotifier {
  bool isLoading = false;
  GetAllProductsModel? singleProduct;
  void getSingleProductDetail(String productId, context) async {
    isLoading = true;
    notifyListeners();
    await GetSingleProductService.getSingleProductService(productId, context)
        .then((value) {
      if (value != null) {
        singleProduct = value;
        isLoading = false;
        notifyListeners();
      }
    });
    isLoading = false;
    notifyListeners();
  }
}
