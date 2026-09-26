class Product {
  final String id;
  final String name;
  final double price;
  final IconIndex icon;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
    required this.category,
  });
}

// Simple enum-like wrapper so we don't need image assets — we map this
// to a Material icon in the UI layer.
enum IconIndex {
  fruit,
  bread,
  milk,
  coffee,
  snack,
  drink,
}
