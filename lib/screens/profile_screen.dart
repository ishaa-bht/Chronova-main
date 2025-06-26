import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softGray,
      body: SafeArea(
        child: Column(
          children: [
            _buildProfileHeader(),
            Expanded(
              child: _buildProfileOptions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBrown, AppColors.darkBrown],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'John Explorer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'History Enthusiast',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Places', '0'),
              _buildStatItem('Favorites', '0'),
              _buildStatItem('Photos', '0'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOptions() {
    final options = [
      {'icon': Icons.history, 'title': 'Visit History', 'subtitle': 'See your exploration timeline'},
      {'icon': Icons.settings, 'title': 'Settings', 'subtitle': 'Customize your experience'},
      {'icon': Icons.help_outline, 'title': 'Help & Support', 'subtitle': 'Get assistance'},
      {'icon': Icons.info_outline, 'title': 'About', 'subtitle': 'Learn more about ChronoVa'},
      {'icon': Icons.logout, 'title': 'Sign Out', 'subtitle': 'Logout from your account'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBrown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                option['icon'] as IconData,
                color: AppColors.primaryBrown,
                size: 24,
              ),
            ),
            title: Text(
              option['title'] as String,
              style: AppStyles.headingMedium.copyWith(fontSize: 16),
            ),
            subtitle: Text(
              option['subtitle'] as String,
              style: AppStyles.bodyText.copyWith(fontSize: 14),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textLight,
              size: 16,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}