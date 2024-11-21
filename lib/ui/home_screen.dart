import 'package:flutter/material.dart';
import 'package:flutter_app/data/local/dao/product_dao.dart';
import 'package:flutter_app/data/local/db/database_factory.dart';
import 'package:flutter_app/data/local/db/sync.dart';
import 'package:flutter_app/data/local/entities/product_entity.dart';
import 'package:flutter_app/di/service_locator.dart';
import '../widgets/product_card.dart';
import '../domain/models/Product.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {
  late ProductDao _productDao;
  late Future<List<Product>> _products = Future.value(<Product>[]);
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncProducts();
  }

  Future<void> _initialize() async {
    final database = await getIt.getAsync<AppDatabase>();
    setState(() {
      _productDao = database.productDao;
      _products = loadProducts();
      _products.then((products) {});
    });
  }

  Future<void> _syncProducts() async {
    final syn = await getIt.getAsync<Sync>();
    syn.syncProducts();
  }

  Future<List<Product>> loadProducts() async {
    final List<ProductEntity> productEntities =
        await _productDao.fetchAllProducts();
    final List<Product> products = productEntities.map((productEntity) {
      return productEntity.toProduct();
    }).toList();
    return products;
  }

  void _updateSearchQuery(String newQuery) {
    if (mounted) {
      setState(() {
        _searchQuery = newQuery;
      });
    }
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_searchQuery.isEmpty) {
      return products;
    }
    return products
        .where((product) =>
            product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProductSearchDelegate(
                    products: _products,
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
            Stack(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Product>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final List<Product> products = _filterProducts(snapshot.data!);
                // final products = snapshot.data;

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = products[index];
                          return ProductCard(
                            id: product.id,
                            image: product.image ?? '',
                            name: product.name,
                            description: product.shortDescription,
                            price: product.price.toString(),
                          );
                        },
                        childCount: products.length,
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text('No products found'),
                );
              }
            }),
      ),
    );
  }
}

// class ProductSearchDelegate extends SearchDelegate<String> {
//   final Future<List<Product>> products;
//   final ValueChanged<String> onSearchQueryChanged;

//   ProductSearchDelegate({
//     required this.products,
//     required this.onSearchQueryChanged,
//   });

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           onSearchQueryChanged(query);
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return BackButton(
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     onSearchQueryChanged(query);
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     onSearchQueryChanged(query);
//     return Container();
//   }
// }

class ProductSearchDelegate extends SearchDelegate<String> {
  final Future<List<Product>> products;

  ProductSearchDelegate({required this.products});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildFilteredResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildFilteredResults();
  }

  Widget _buildFilteredResults() {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final List<Product> filteredProducts = snapshot.data!
              .where((product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()))
              .toList();

          if (filteredProducts.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.shortDescription),
                onTap: () {
                  close(context, product.name);
                },
              );
            },
          );
        } else {
          return const Center(child: Text('No products available.'));
        }
      },
    );
  }
}
