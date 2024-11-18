import 'package:flutter/material.dart';

import '../api/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  final String id;
  final String image;
  final String name;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 320,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: {'id': id});
          },
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.network(
                    '$baseUrl/$image',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1, // Limit to 1 line
                    overflow: TextOverflow.ellipsis, // Truncate overflow text
                  ),
                ),
                const SizedBox(height: 4), // Add spacing
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2, // Limit to 2 lines
                    overflow: TextOverflow.ellipsis, // Truncate overflow text
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
