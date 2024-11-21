import 'package:flutter/material.dart';
import 'package:flutter_app/data/local/dao/product_dao.dart';
import 'package:flutter_app/data/local/db/database_factory.dart';
import 'package:flutter_app/data/remote/api/constants.dart';
import 'package:flutter_app/di/service_locator.dart';
import 'package:flutter_app/domain/models/Product.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Stream<Product?> _product;
  late ProductDao _productDao;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final productId = args['id'] as String;
    _productDao = getIt<AppDatabase>().productDao;
    _product = fetchProduct(productId);
  }

  Stream<Product?> fetchProduct(String productId) {
    final productEntity = _productDao.fetchProduct(productId);
    return productEntity.map((pr) => pr?.toProduct());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(onPressed: () {
                Navigator.pop(context);
              }),
            ),
            body: StreamBuilder<Product?>(
                stream: _product,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No data'),
                    );
                  } else if (snapshot.hasData) {
                    final product = snapshot.data;
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
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'Price: ${product.price}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'Quantity: ${product.quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/cart');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero)),
                                  child: const Text(
                                    'Add to cart',
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ),
                          ),
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
