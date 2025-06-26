import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Assuming you have a colors file, if not, define these colors
class AppColors {
  static const Color primaryBrown = Color(0xFF8B4513);
  static const Color lightBrown = Color(0xFFD2B48C);
  static const Color darkBrown = Color(0xFF654321);
}

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _interestType;
  String? _locationPreference;
  String? _dietaryPreference;
  String? _foodType;
  String? _b2bInterest;
  bool _isLoading = false;

  // Update this URL to your actual backend URL
  final String apiUrl = 'https://fc89-110-44-118-28.ngrok-free.app/recommendations';

  // Better label mappings for user-friendly display
  final Map<String, String> interestTypeLabels = {
    'temples_religious': 'Temples & Religious Sites',
    'ancient_architecture': 'Ancient Architecture',
    'old_towns': 'Historic Old Towns',
    'cultural_museums': 'Cultural Museums',
    'archaeological_ruins': 'Archaeological Ruins',
  };

  final Map<String, String> locationLabels = {
    'kathmandu_valley': 'Kathmandu Valley',
    'lumbini': 'Lumbini',
    'gorkha_bandipur': 'Gorkha & Bandipur',
    'janakpur': 'Janakpur',
  };

  final Map<String, String> dietaryLabels = {
    'vegetarian': 'Vegetarian',
    'vegan': 'Vegan',
    'non_vegetarian': 'Non-Vegetarian',
  };

  final Map<String, String> foodTypeLabels = {
    'local_snacks': 'Local Snacks',
    'traditional_meals': 'Traditional Meals',
    'high_end': 'High-End Dining',
  };

  final Map<String, String> serviceLabels = {
    'none': 'Not Interested',
    'homestays': 'Homestays',
    'traditional_shops': 'Traditional Shops',
    'guided_tours': 'Guided Tours',
  };

  Future<void> _submitPreferences() async {
    if (_formKey.currentState!.validate()) {
      final preferences = {
        'interest_type': _interestType,
        'location_preference': _locationPreference,
        'dietary_preference': _dietaryPreference,
        'food_type': _foodType,
        'b2b_interest': _b2bInterest ?? 'none',
      };

      try {
        setState(() => _isLoading = true);

        print('Sending preferences: $preferences'); // Debug log

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true', // For ngrok
          },
          body: jsonEncode(preferences),
        );

        print('Response status: ${response.statusCode}'); // Debug log
        print('Response body: ${response.body}'); // Debug log

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['status'] == 'success') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecommendationsScreen(
                  data: data['data'],
                  preferences: preferences,
                ),
              ),
            );
          } else {
            _showError('Error: ${data['message'] ?? 'Unknown error'}');
          }
        } else {
          _showError('Server error: ${response.statusCode}\n${response.body}');
        }
      } catch (e) {
        print('Error: $e'); // Debug log
        _showError('Failed to connect: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: _submitPreferences,
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Preferences',
          style: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBrown,
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      body: _isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primaryBrown),
            SizedBox(height: 16),
            Text('Getting your recommendations...'),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text(
              //   'Share your interests for personalized recommendations!',
              //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
              //     fontFamily: 'Roboto',
              //     fontSize: 20,
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.darkBrown,
              //     height: 1.4,
              //     letterSpacing: 0.5,
              //   ),
              //   textAlign: TextAlign.center,
              // ),

              const SizedBox(height: 24),

              // Interest Type
              _buildDropdownField(
                label: 'What interests you most?',
                value: _interestType,
                items: interestTypeLabels,
                onChanged: (value) => setState(() => _interestType = value),
                validator: (value) => value == null ? 'Please select your interest' : null,
              ),

              // Location Preference
              _buildDropdownField(
                label: 'Preferred region to explore',
                value: _locationPreference,
                items: locationLabels,
                onChanged: (value) => setState(() => _locationPreference = value),
                validator: (value) => value == null ? 'Please select a location' : null,
              ),

              // Dietary Preference
              _buildDropdownField(
                label: 'Dietary preference',
                value: _dietaryPreference,
                items: dietaryLabels,
                onChanged: (value) => setState(() => _dietaryPreference = value),
                isOptional: true,
              ),

              // Food Type
              _buildDropdownField(
                label: 'Food experience preference',
                value: _foodType,
                items: foodTypeLabels,
                onChanged: (value) => setState(() => _foodType = value),
                isOptional: true,
              ),

              // Service Interest
              _buildDropdownField(
                label: 'Additional services of interest',
                value: _b2bInterest,
                items: serviceLabels,
                onChanged: (value) => setState(() => _b2bInterest = value),
                isOptional: true,
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitPreferences,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBrown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Get My Recommendations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required Map<String, String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    bool isOptional = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + (isOptional ? ' (Optional)' : ' *'),
            style: const TextStyle(
              color: AppColors.darkBrown,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.lightBrown),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.lightBrown),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primaryBrown, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: items.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }
}

class RecommendationsScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> preferences;

  const RecommendationsScreen({super.key, required this.data, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Recommendations'),
        backgroundColor: AppColors.primaryBrown,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommendations Summary',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primaryBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Historical Sites', data['historical_sites']?.length ?? 0),
                    _buildSummaryRow('Food Places', data['food_places']?.length ?? 0),
                    _buildSummaryRow('Services', data['services']?.length ?? 0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Historical Sites
            if (data['historical_sites'] != null && data['historical_sites'].isNotEmpty)
              _buildSection(
                context,
                'Historical Sites',
                data['historical_sites'],
                _buildHistoricalSiteCard,
                Icons.account_balance,
              ),

            // Food Places
            if (data['food_places'] != null && data['food_places'].isNotEmpty)
              _buildSection(
                context,
                'Food Places',
                data['food_places'],
                _buildFoodPlaceCard,
                Icons.restaurant,
              ),

            // Services
            if (data['services'] != null && data['services'].isNotEmpty)
              _buildSection(
                context,
                'Services',
                data['services'],
                _buildServiceCard,
                Icons.business,
              ),

            // No recommendations message
            if (_getTotalRecommendations() == 0)
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Icon(Icons.search_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No recommendations found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your preferences to find more matches.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Update Preferences'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  int _getTotalRecommendations() {
    return (data['historical_sites']?.length ?? 0) +
        (data['food_places']?.length ?? 0) +
        (data['services']?.length ?? 0);
  }

  Widget _buildSummaryRow(String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.lightBrown,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context,
      String title,
      List<dynamic> items,
      Widget Function(dynamic) cardBuilder,
      IconData icon,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryBrown),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryBrown,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${items.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...items.map((item) => cardBuilder(item)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildHistoricalSiteCard(dynamic site) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          _buildImageSection(site),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        site['name'] ?? 'Unknown Site',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ),
                    _buildScoreChip(site['relevance_score']),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.category, 'Type', site['site_type']),
                _buildInfoRow(Icons.location_on, 'Location', site['location']),
                if (site['region'] != null)
                  _buildInfoRow(Icons.map, 'Region', site['region']),
                if (site['unesco_status'] == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'UNESCO World Heritage Site',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                if (site['description'] != null && site['description'].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      site['description'],
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPlaceCard(dynamic place) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          _buildImageSection(place),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        place['name'] ?? 'Unknown Place',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ),
                    _buildScoreChip(place['relevance_score']),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.restaurant_menu, 'Type', place['food_type']),
                _buildInfoRow(Icons.location_on, 'Location', place['location']),
                if (place['rating'] != null)
                  _buildInfoRow(Icons.star, 'Rating', '${place['rating']} ⭐'),
                if (place['dietary_options'] != null && place['dietary_options'].isNotEmpty)
                  _buildInfoRow(Icons.dining, 'Dietary Options',
                      (place['dietary_options'] as List).join(', ')),
                if (place['specialties'] != null && place['specialties'].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: (place['specialties'] as List).map<Widget>((specialty) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.lightBrown,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            specialty.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(dynamic service) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          _buildImageSection(service),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        service['name'] ?? 'Unknown Service',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ),
                    _buildScoreChip(service['relevance_score']),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.business, 'Type', service['service_type']),
                _buildInfoRow(Icons.location_on, 'Location', service['location']),
                if (service['description'] != null && service['description'].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      service['description'],
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                if (service['specialties'] != null && service['specialties'].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: (service['specialties'] as List).map<Widget>((specialty) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.lightBrown,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            specialty.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (service['contact_info'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Contact: ${service['contact_info']}',
                      style: const TextStyle(
                        color: AppColors.primaryBrown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // New method to build image section
  Widget _buildImageSection(dynamic item) {
    // Check if item has images
    List<dynamic>? images = item['images'];
    String? singleImage = item['image']; // In case backend sends single image
    String? imageUrl = item['image_url']; // Alternative field name

    // Determine which image to show
    String? displayImage;
    if (images != null && images.isNotEmpty) {
      displayImage = images.first.toString();
    } else if (singleImage != null && singleImage.isNotEmpty) {
      displayImage = singleImage;
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      displayImage = imageUrl;
    }

    if (displayImage == null || displayImage.isEmpty) {
      return const SizedBox.shrink(); // Return empty widget if no image
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              displayImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBrown,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Image not available',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Optional: Add a gradient overlay for better text readability
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
            // Optional: Add multiple images indicator if there are more images
            if (images != null && images.length > 1)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${images.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Method to show image gallery when user taps on image
  void _showImageGallery(BuildContext context, dynamic item) {
    List<dynamic>? images = item['images'];
    String? singleImage = item['image'];
    String? imageUrl = item['image_url'];

    List<String> imageUrls = [];

    if (images != null && images.isNotEmpty) {
      imageUrls = images.map((img) => img.toString()).toList();
    } else if (singleImage != null && singleImage.isNotEmpty) {
      imageUrls = [singleImage];
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      imageUrls = [imageUrl];
    }

    if (imageUrls.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: PageView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Text('Image not available'),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, dynamic value) {
    if (value == null || value.toString().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryBrown),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChip(dynamic score) {
    if (score == null) return const SizedBox.shrink();

    double scoreValue = score is double ? score : double.tryParse(score.toString()) ?? 0.0;
    Color chipColor = scoreValue >= 0.7 ? Colors.green :
    scoreValue >= 0.4 ? Colors.orange : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Score: ${(scoreValue * 100).toInt()}%',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}