import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controller/single_product/single_product_controller.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct(
      {super.key, required this.productId, required this.index});
  final String productId;
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SingleProductController>(context, listen: false);
    final product = provider.singleProduct!.products![index];
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        provider.getSingleProductDetail(productId, context);
      },
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Consumer(
            builder: (context, SingleProductController value, child) {
              return value.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : value.singleProduct == null
                      ? const Text('no data')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              child: CarouselSlider.builder(
                                  options: CarouselOptions(
                                    height: 280.0,
                                    enlargeCenterPage: true,
                                    onPageChanged: (position, reason) {},
                                    enableInfiniteScroll: true,
                                  ),
                                  itemBuilder: (BuildContext context,
                                      int index1, int realIndex) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(value
                                                    .singleProduct!
                                                    .products![index]
                                                    .images![index1]),
                                                fit: BoxFit.cover)));
                                  },
                                  itemCount: value.singleProduct
                                      ?.products![index].images!.length),
                            ),
                            Container(
                              height: 400,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 218, 216, 210),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          product.title ?? "",
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                        const SizedBox(width: 60),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(
                                              Icons.currency_rupee_outlined,
                                              size: 17,
                                            ),
                                            Text(product.price.toString(),
                                                style: const TextStyle(
                                                    fontSize: 15))
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        provider.singleProduct?.products![index]
                                                .description ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: 'Radley', fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
            },
          ),
        ],
      ),
    );
  }
}
