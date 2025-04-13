import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimarket App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Map<String, dynamic>> cart = [];

  final List<Map<String, dynamic>> products = const [
    {
      'name': 'Aceite Primor 900 Ml',
      'price': 1.50,
      'image': 'http://corporacionliderperu.com/46924-large_default/primor-clasico-aceite-vegetal-bt-x-900-ml.jpg',
    },
    {
      'name': 'Harina maíz Pan',
      'price': 1.20,
      'image': 'https://walmartcr.vtexassets.com/arquivos/ids/535314/Harina-Maiz-Pan-Precoc-Blanco-1000gr-1-34028.jpg?v=638422918768000000',
    },
    {
      'name': 'Esencia de Vainilla UNIVERSAL Frasco 100ml',
      'price': 2.30,
      'image': 'https://vegaperu.vtexassets.com/arquivos/ids/167153-600-338?v=638616862248900000&width=600&height=338&aspect=true',
    },
    {
      'name': 'Inca Kola 500ml',
      'price': 2.40,
      'image': 'https://i.postimg.cc/sX1q0nb8/incakola.jpg',
    },
    {
      'name': 'Panetón D’onofrio 900g',
      'price': 19.90,
      'image': 'https://i.postimg.cc/0jczW9DY/paneton.jpg',
    },
    {
      'name': 'Agua San Luis 625ml',
      'price': 1.50,
      'image': 'https://i.postimg.cc/NfjNVH63/agua-san-luis.jpg',
    },
  ];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} agregado al carrito'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void openCart() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El carrito está vacío'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(item['name']),
            subtitle: Text('S/ ${item['price'].toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minimarket Abarrotes'),
        backgroundColor: Colors.orange,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: openCart,
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Imagen desde URL
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      item['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Información del producto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'S/ ${item['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => addToCart(item),
                          child: const Text('Agregar'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
