import 'package:flutter/material.dart';
import '../utils/colors.dart';

class FoodListPage extends StatelessWidget {
  final List<Map<String, String>> foodItems = const [
    {
      'title': 'Yomari',
      'description': 'Sweet Newari steamed dumpling',
      'image': 'assets/images/yomari.jpeg',
    },
    {
      'title': 'Juju Dhau',
      'description': 'Famous curd of Bhaktapur',
      'image': 'assets/images/juju_dhau.jpg',
    },
    {
      'title': 'Bara',
      'description': 'Newari lentil pancake, crispy and savory',
      'image': 'assets/images/bara.png',
    },
    {
      'title': 'Samay Baji',
      'description': 'Traditional Newari ceremonial platter',
      'image': 'assets/images/samay_baji.jpeg',
    },
  ];

  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: foodItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 6.5,
          mainAxisSpacing: 6.5,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['description']!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}