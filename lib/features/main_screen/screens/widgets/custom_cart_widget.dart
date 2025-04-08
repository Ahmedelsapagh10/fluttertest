import 'package:flutter/material.dart';
import 'package:fluttertest/core/exports.dart';

class ShoppingCartIconWithBadge extends StatelessWidget {
  final int itemCount; // Number of items in the cart
  final VoidCallback onTap; // Callback when the icon is tapped

  const ShoppingCartIconWithBadge({
    super.key,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
              color: AppColors.primary,
            ),
          ),
          if (itemCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  itemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
