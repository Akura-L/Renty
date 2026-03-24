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
            child: Padding(
              padding: EdgeInsets.all(AppTheme.kPaddingLarge),
              child: provider.favouriteCars.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border,
                              size: 80, color: AppTheme.grey),
                          SizedBox(height: 16),
                          Text('No favourites yet',
                              style: TextStyle(fontSize: 18)),
                          Text('Tap hearts on cars to save them',
                              style: TextStyle(color: AppTheme.grey)),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: provider.favouriteCars.length,
                      itemBuilder: (context, i) => _buildCarCard(
                          context, provider.favouriteCars[i], provider),
                    ),
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: car.imageUrl,
                    height: AppTheme.kCardImageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(height: AppTheme.kCardImageHeight),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: AppTheme.kCardImageHeight,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported,
                          size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => provider.toggleFavourite(car.id),
                    child: Icon(
                      Icons.favorite,
                      color: provider.isFavourite(car.id)
                          ? Colors.red[400]
                          : Colors.white.withOpacity(0.6),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${car.location} • ${car.year}',
                    style: const TextStyle(color: AppTheme.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      children: [
                        const TextSpan(
                            text: 'KSh ',
                            style: TextStyle(color: AppTheme.primary)),
                        TextSpan(text: '${car.price.toStringAsFixed(0)}'),
                        const TextSpan(
                            text: ' / day',
                            style:
                                TextStyle(fontSize: 12, color: AppTheme.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
