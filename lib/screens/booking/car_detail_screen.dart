import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  final List<String> images = [
    "https://picsum.photos/id/1015/400/300",
    "https://picsum.photos/id/1016/400/300",
    "https://picsum.photos/id/1018/400/300",
  ];
  int currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.dark),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    onPageChanged: (index) =>
                        setState(() => currentImage = index),
                    itemCount: images.length,
                    itemBuilder: (context, index) => Hero(
                      tag: 'car_image_$index',
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          images.length,
                          (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: currentImage == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentImage == index
                                      ? AppTheme.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Toyota Land Cruiser GX V8",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const Icon(Icons.favorite_border, color: Colors.red),
                    ],
                  ),
                  const Text("Nairobi • Automatic • 2023",
                      style: TextStyle(color: AppTheme.grey, fontSize: 14)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSpecRow("Transmission", "Automatic"),
                        _buildSpecRow("Fuel Type", "Petrol"),
                        _buildSpecRow("Seats", "7"),
                        _buildSpecRow("Year", "2023"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Features",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                          label: const Text("Air Conditioning"),
                          backgroundColor: Colors.blue[50]!),
                      Chip(
                          label: const Text("GPS Navigation"),
                          backgroundColor: Colors.green[50]!),
                      Chip(
                          label: const Text("Bluetooth"),
                          backgroundColor: Colors.purple[50]!),
                      Chip(
                          label: const Text("Camera"),
                          backgroundColor: Colors.orange[50]!),
                      Chip(
                          label: const Text("ABS"),
                          backgroundColor: Colors.red[50]!),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "🗺️ Pickup Location Map\nNairobi CBD - Westlands Branch",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text("KSh 5,500",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary)),
                      const Text("/ day",
                          style: TextStyle(fontSize: 16, color: AppTheme.grey)),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Redirecting to booking...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Reserve Now",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
