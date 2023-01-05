import 'package:flutter/material.dart';
import 'package:product_task/view/widgets/home_card.dart';

import 'package:provider/provider.dart';

import '../controller/home/home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final providerhome = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        providerhome.getAllProducts(context);
      },
    );
    return Scaffold(
      body: SafeArea(child: Consumer<HomeController>(
        builder: (context, value, child) {
          return value.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : value.allProducts == null
                  ? const SizedBox()
                  : ListView.builder(
                      itemCount: value.allProducts!.products!.length,
                      itemBuilder: (context, index) {
                        return value.allProducts == null
                            ? const Text('no data')
                            : InkWell(
                                onTap: () {
                                  providerhome.navigateToProductDetails(
                                      context,
                                      index,
                                      value.allProducts!.products![index].id
                                          .toString());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CardWidget(
                                    title: value
                                        .allProducts!.products![index].title!,
                                    image: value.allProducts!.products![index]
                                        .images![0],
                                  ),
                                ),
                              );
                      },
                    );
        },
      )),
    );
  }
}
