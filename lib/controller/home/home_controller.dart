import 'package:flutter/material.dart';
import 'package:product_task/model/home/get_all_product_model.dart';

import '../../service/home/get_all_service.dart';
import '../../view/single_product.dart';

class HomeController with ChangeNotifier {
  bool isLoading = false;
  GetAllProductsModel? allProducts;
  void getAllProducts(context) async {
    isLoading = true;
    notifyListeners();
    await GetAllProductsService.getAllProductsService(context).then((value) {
      if (value != null) {
        allProducts = value;
        isLoading = false;
        notifyListeners();
      }
    });

    isLoading = false;
    notifyListeners();
  }

  void navigateToProductDetails(context, int index, String productId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SingleProduct(
        index: index,
        productId: productId,
      );
    }));
  }
}
