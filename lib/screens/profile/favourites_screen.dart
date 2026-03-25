import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../providers/favourites_provider.dart';
import '../../../core/theme.dart';
import '../../../models/car.dart';
import '../../../screens/booking/car_detail_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Favourites (${provider.count})',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            actions: const [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=68'),
              ),
              SizedBox(width: 16),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => Future.delayed(const Duration(seconds: 1)),
            child: Column(\n              children: [\n                Expanded(\n                  child: Padding(\n                    padding: EdgeInsets.all(AppTheme.kPaddingLarge),\n                    child: provider.favouriteCars.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border,
                              size: 80, color: AppTheme.grey),
                          SizedBox(height: 16),
                          Text('No favourites yet',\n                              style: GoogleFonts.inter(\n                                  fontWeight: FontWeight.bold, \n                                  fontSize: 20)),
                          Text('Tap hearts on cars to save them',
                              style: TextStyle(color: AppTheme.grey)),
                        ],
                      ),
                    )
                    : ListView.builder(\n                      itemCount: provider.favouriteCars.length,\n                      itemBuilder: (context, i) => Padding(\n                        padding: const EdgeInsets.only(bottom: 16),\n                        child: _buildCarCard(\n                          context, provider.favouriteCars[i], provider),\n                      ),\n                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCarCard(
      BuildContext context, Car car, FavouritesProvider provider) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CarDetailScreen(car: car),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Stack(\n                  children: [\n                    ClipRRect(\n                      borderRadius:\n                          const BorderRadius.vertical(top: Radius.circular(16)),\n                      child: CachedNetworkImage(\n                        imageUrl: car.imageUrl,\n                        height: AppTheme.kCardImageHeight,\n                        width: double.infinity,\n                        fit: BoxFit.cover,\n                        placeholder: (context, url) => Shimmer.fromColors(\n                          baseColor: Colors.grey[300]!,\n                          highlightColor: Colors.grey[100]!,\n                          child: Container(height: AppTheme.kCardImageHeight),\n                        ),\n                        errorWidget: (context, url, error) => Container(\n                          height: AppTheme.kCardImageHeight,\n                          color: Colors.grey[300],\n                          child: const Icon(Icons.image_not_supported,\n                              size: 50, color: Colors.grey),\n                        ),\n                      ),\n                    ),\n                    if (car.topRated)\n                      const Positioned(\n                        top: 8,\n                        left: 8,\n                        child: Container(\n                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),\n                          decoration: BoxDecoration(\n                            color: AppTheme.primary,\n                            borderRadius: BorderRadius.circular(20),\n                          ),\n                          child: Text(\n                            'Top Rated',\n                            style: TextStyle(\n                              color: Colors.white,\n                              fontSize: 11,\n                              fontWeight: FontWeight.bold,\n                            ),\n                          ),\n                        ),\n                      ),\n                    Positioned(\n                      top: 8,\n                      right: 8,\n                      child: GestureDetector(\n                        onTap: () => provider.toggleFavourite(car.id),\n                        child: Icon(\n                          Icons.favorite,\n                          color: provider.isFavourite(car.id)\n                              ? Colors.red[400]\n                              : Colors.white.withOpacity(0.6),\n                          size: 24,\n                        ),\n                      ),\n                    ),\n                  ],
            ),
            Padding(\n              padding: const EdgeInsets.all(16),\n              child: Column(\n                crossAxisAlignment: CrossAxisAlignment.start,\n                children: [\n                  Text(\n                    car.name,\n                    style: GoogleFonts.inter(\n                      fontWeight: FontWeight.bold,\n                      fontSize: 18,\n                    ),\n                    maxLines: 2,\n                    overflow: TextOverflow.ellipsis,\n                  ),\n                  Text(\n                    car.location,\n                    style: TextStyle(\n                      color: AppTheme.grey,\n                      fontSize: 14,\n                    ),\n                  ),\n                  const SizedBox(height: 12),\n                  // Specs row\n                  if (car.specs.isNotEmpty)\n                    SizedBox(\n                      height: 40,\n                      child: ListView.builder(\n                        scrollDirection: Axis.horizontal,\n                        itemCount: (car.specs.length).clamp(0, 3),\n                        itemBuilder: (context, index) {\n                          final spec = car.specs[index];\n                          IconData icon;\n                          if (spec.toLowerCase().contains('seat')) {\n                            icon = Icons.people_outline;\n                          } else if (spec.toLowerCase().contains('auto') || spec.toLowerCase().contains('trans')) {\n                            icon = Icons.speed;\n                          } else {\n                            icon = Icons.local_gas_station_outlined;\n                          }\n                          return Padding(\n                            padding: const EdgeInsets.only(right: 20),\n                            child: Row(\n                              mainAxisSize: MainAxisSize.min,\n                              children: [\n                                Icon(icon, color: AppTheme.grey, size: 18),\n                                const SizedBox(width: 4),\n                                Text(\n                                  spec,\n                                  style: TextStyle(\n                                    color: AppTheme.grey,\n                                    fontSize: 12,\n                                  ),\n                                ),\n                              ],\n                            ),\n                          );\n                        },\n                      ),\n                    ),\n                  const SizedBox(height: 12),\n                  // Rating row\n                  Row(\n                    children: [\n                      ...List.generate(5, (index) => Icon(\n                            index < (car.rating ~/ 0.5) ? Icons.star : Icons.star_border,\n                            color: AppTheme.primary,\n                            size: 16,\n                          )),\n                      const SizedBox(width: 8),\n                      Text(\n                        '${car.rating.toStringAsFixed(1)} (${car.reviewCount})\n',\n                        style: TextStyle(\n                          fontSize: 14,\n                          fontWeight: FontWeight.w600,\n                          color: AppTheme.primary,\n                        ),\n                      ),\n                    ],\n                  ),\n                  const SizedBox(height: 16),\n                  // Button and price row\n                  Row(\n                    children: [\n                      Expanded(\n                        child: ElevatedButton(\n                          onPressed: () => Navigator.push(\n                            context,\n                            MaterialPageRoute(\n                              builder: (_) => CarDetailScreen(car: car),\n                            ),\n                          ),\n                          style: ElevatedButton.styleFrom(\n                            backgroundColor: AppTheme.primary,\n                            foregroundColor: Colors.white,\n                            shape: RoundedRectangleBorder(\n                              borderRadius: BorderRadius.circular(12),\n                            ),\n                            padding: const EdgeInsets.symmetric(vertical: 12),\n                          ),\n                          child: const Text(\n                            'Book Now',\n                            style: TextStyle(\n                              fontWeight: FontWeight.bold,\n                              fontSize: 16,\n                            ),\n                          ),\n                        ),\n                      ),\n                      const SizedBox(width: 12),\n                      Text(\n                        'KSh ${car.price.toStringAsFixed(0)}',\n                        style: GoogleFonts.inter(\n                          fontSize: 20,\n                          fontWeight: FontWeight.bold,\n                          color: AppTheme.primary,\n                        ),\n                      ),\n                    ],\n                  ),\n                ],\n              ),\n            ),
          ],
        ),
      ),
    );
  }
}
