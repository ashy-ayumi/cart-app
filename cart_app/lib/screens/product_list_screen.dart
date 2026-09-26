import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/filter_provider.dart';
import 'cart_screen.dart';

IconData iconForProduct(IconIndex icon) {
  switch (icon) {
    case IconIndex.fruit:
      return Icons.apple;
    case IconIndex.bread:
      return Icons.bakery_dining;
    case IconIndex.milk:
      return Icons.local_drink;
    case IconIndex.coffee:
      return Icons.coffee;
    case IconIndex.snack:
      return Icons.fastfood;
    case IconIndex.drink:
      return Icons.local_bar;
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch rebuilds this widget whenever the cart count changes,
    // so the badge in the AppBar stays live.
    final cartCount = context.watch<CartProvider>().totalItemCount;
    final filter = context.watch<FilterProvider>();

    final filteredProducts = localProducts.where((product) {
      final matchesSearch = product.name
          .toLowerCase()
          .contains(filter.searchQuery.toLowerCase());
      final matchesCategory = filter.selectedCategory == 'All' ||
          product.category == filter.selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                context.read<FilterProvider>().setSearchQuery(value);
              },
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: productCategories.length,
              itemBuilder: (context, index) {
                final category = productCategories[index];
                final selected = filter.selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    onSelected: (_) {
                      context.read<FilterProvider>().setCategory(category);
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('No products match your search.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(iconForProduct(product.icon)),
                          ),
                          title: Text(product.name),
                          subtitle: Text('৳${product.price.toStringAsFixed(0)}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // read (not watch) here — this button doesn't
                              // need to rebuild when the cart changes.
                              context.read<CartProvider>().addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart'),
                                  duration: const Duration(milliseconds: 700),
                                ),
                              );
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
