import 'package:flutter/material.dart';

import '../../../../core/preferences/product_model.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;
  final Function(int) onUpdateQuantity; // Callback to update quantity

  const CartItemWidget({
    required this.product,
    required this.onRemove,
    required this.onUpdateQuantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(product.price! * product.myCount).toStringAsFixed(2)}', // Total price for the item
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category ?? 'No Category',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Quantity Controls
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.green),
                  onPressed: () => onUpdateQuantity(
                      product.myCount! + 1), // Increase quantity
                ),
                Text(
                  '${product.myCount}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: product.myCount! > 1
                      ? () => onUpdateQuantity(
                          product.myCount! - 1) // Decrease quantity
                      : null, // Disable if quantity is 1
                ),
              ],
            ),

            // Remove Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
