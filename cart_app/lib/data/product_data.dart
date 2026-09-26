import '../models/product.dart';

final List<Product> localProducts = [
  Product(
    id: 'p1',
    name: 'Apple (1kg)',
    price: 180,
    icon: IconIndex.fruit,
    category: 'Fruits',
  ),
  Product(
    id: 'p2',
    name: 'Banana (dozen)',
    price: 90,
    icon: IconIndex.fruit,
    category: 'Fruits',
  ),
  Product(
    id: 'p3',
    name: 'Whole Wheat Bread',
    price: 65,
    icon: IconIndex.bread,
    category: 'Bakery',
  ),
  Product(
    id: 'p4',
    name: 'Milk (1L)',
    price: 110,
    icon: IconIndex.milk,
    category: 'Dairy',
  ),
  Product(
    id: 'p5',
    name: 'Coffee Beans (250g)',
    price: 650,
    icon: IconIndex.coffee,
    category: 'Beverages',
  ),
  Product(
    id: 'p6',
    name: 'Potato Chips',
    price: 55,
    icon: IconIndex.snack,
    category: 'Snacks',
  ),
  Product(
    id: 'p7',
    name: 'Orange Juice (1L)',
    price: 220,
    icon: IconIndex.drink,
    category: 'Beverages',
  ),
  Product(
    id: 'p8',
    name: 'Croissant (pack of 4)',
    price: 320,
    icon: IconIndex.bread,
    category: 'Bakery',
  ),
];

List<String> get productCategories {
  final categories = localProducts.map((p) => p.category).toSet().toList();
  categories.sort();
  return ['All', ...categories];
}
