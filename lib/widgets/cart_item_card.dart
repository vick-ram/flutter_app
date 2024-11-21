import 'package:flutter/material.dart';
import '../data/remote/api/constants.dart';

class CartItemCard extends StatefulWidget {
  final String productImgUrl;
  final String productName;
  final String productPrice;
  final String productDiscountedPrice;
  final int productCartQuantity;
  final VoidCallback onRemoveProduct;
  final VoidCallback onIncreaseProductQuantity;
  final VoidCallback onDecreaseProductQuantity;

  const CartItemCard({
    super.key,
    required this.productImgUrl,
    required this.productName,
    required this.productPrice,
    required this.productDiscountedPrice,
    required this.productCartQuantity,
    required this.onRemoveProduct,
    required this.onIncreaseProductQuantity,
    required this.onDecreaseProductQuantity,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Image.network('$baseUrl/${widget.productImgUrl}'),
          Text(widget.productName),
          Text(widget.productPrice),
          Text(widget.productDiscountedPrice),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: widget.onDecreaseProductQuantity,
              ),
              Text(widget.productCartQuantity.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: widget.onIncreaseProductQuantity,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: widget.onRemoveProduct,
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
