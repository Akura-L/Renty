import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            child: provider.favouriteCars.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border,
                            size: 80, color: RentyColors.textDisabled),
                        SizedBox(height: 16),
                        Text('No favourites yet',
                            style: RentyTextStyles.headingM),
                        Text('Tap hearts on cars to save them',
                            style: RentyTextStyles.bodyM),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.favouriteCars.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildCarCard(
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
        decoration: RentyDecorations.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(RentyRadius.lg)),
              child: Image.asset(
                car.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  color: RentyColors.surface,
                  child: const Icon(Icons.image_not_supported,
                      size: 50, color: RentyColors.textDisabled),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          car.name,
                          style: RentyTextStyles.headingM,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: RentyColors.error),
                        onPressed: () => provider.toggleFavourite(car.id),
                      ),
                    ],
                  ),
                  Text(
                    car.location,
                    style: RentyTextStyles.bodyS,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "KSh ${car.price.toStringAsFixed(0)}",
                        style: RentyTextStyles.price,
                      ),
                      const Text(
                        "/day",
                        style: RentyTextStyles.bodyS,
                      ),
                    ],
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
