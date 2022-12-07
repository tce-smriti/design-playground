class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/icons/home.svg', name: 'Home'),
  Model(id: 1, imagePath: 'assets/icons/products.svg', name: 'Products'),
  Model(id: 2, imagePath: 'assets/icons/services.svg', name: 'Services'),
  Model(id: 3, imagePath: 'assets/icons/my_policy.svg', name: 'My Policy'),
  Model(id: 4, imagePath: 'assets/icons/products.svg', name: 'Claims'),
];
