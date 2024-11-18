import 'package:flutter/material.dart';
import 'package:flutter_app/api/constants.dart';
import 'package:flutter_app/api/dto/Product.dart';
import 'package:flutter_app/api/services/ProductService.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Future<ApiResponse<Product>> _product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final productId = args['id'] as String;
    _product = fetchProduct(dio, productId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder<ApiResponse<Product>>(
                future: _product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No data'),
                    );
                  } else if (snapshot.hasData && snapshot.data!.success) {
                    final product = snapshot.data!.data;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              '$baseUrl/${product!.image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              '${product.shortDescription} - ${product.detailedDescription}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 8),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero)),
                                child: const Text(
                                  'Add to cart',
                                  style: TextStyle(fontSize: 18),
                                )),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }
                })));
  }
}
