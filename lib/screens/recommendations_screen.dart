//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
//
// class RecommendationsScreen extends StatefulWidget {
//   final Map<String, dynamic> recommendations;
//   final Map<String, dynamic> userPreferences;
//
//   const RecommendationsScreen({
//     Key? key,
//     required this.recommendations,
//     required this.userPreferences,
//   }) : super(key: key);
//
//   @override
//   _RecommendationsScreenState createState() => _RecommendationsScreenState();
// }
//
// class _RecommendationsScreenState extends State<RecommendationsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<String> favoriteItems = [];
//   bool _showItinerary = false;
//   List<dynamic> _itinerary = [];
//   bool _loadingItinerary = false;
//
//   static const String API_BASE_URL = 'https://8137-110-44-118-28.ngrok-free.app';
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Determine number of tabs based on available data
//     int tabCount = 0;
//     if (_hasHistoricalSites()) tabCount++;
//     if (_hasFoodPlaces()) tabCount++;
//     if (_hasServices()) tabCount++;
//
//     // Ensure at least 1 tab
//     if (tabCount == 0) tabCount = 1;
//
//     _tabController = TabController(length: tabCount, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   bool _hasHistoricalSites() {
//     final sites = widget.recommendations['historical_sites'];
//     return sites != null && sites is List && sites.isNotEmpty;
//   }
//
//   bool _hasFoodPlaces() {
//     final places = widget.recommendations['food_places'];
//     return places != null && places is List && places.isNotEmpty;
//   }
//
//   bool _hasServices() {
//     final services = widget.recommendations['services'];
//     return services != null && services is List && services.isNotEmpty;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_hasHistoricalSites() && !_hasFoodPlaces() && !_hasServices()) {
//       return _buildEmptyState();
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text(
//           'Your Recommendations',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.orange[700],
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.calendar_today, color: Colors.white),
//             onPressed: _generateItinerary,
//             tooltip: 'Generate Itinerary',
//           ),
//           IconButton(
//             icon: Icon(Icons.favorite, color: Colors.white),
//             onPressed: () {
//               _showFavorites();
//             },
//             tooltip: 'View Favorites',
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: Container(
//             color: Colors.orange[700],
//             child: TabBar(
//               controller: _tabController,
//               indicatorColor: Colors.white,
//               indicatorWeight: 3,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.orange[100],
//               tabs: _buildTabs(),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // User preferences summary
//           _buildPreferencesSummary(),
//
//           // Main content
//           Expanded(
//             child: _showItinerary ? _buildItineraryView() : _buildTabView(),
//           ),
//         ],
//       ),
//       floatingActionButton: _showItinerary
//           ? FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _showItinerary = false;
//           });
//         },
//         backgroundColor: Colors.orange[700],
//         child: Icon(Icons.list, color: Colors.white),
//         tooltip: 'Back to Recommendations',
//       )
//           : null,
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recommendations'),
//         backgroundColor: Colors.orange[700],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search_off,
//               size: 80,
//               color: Colors.grey[400],
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No Recommendations Found',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Try adjusting your preferences and search again.',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[500],
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Modify Preferences'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange[700],
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   List<Tab> _buildTabs() {
//     List<Tab> tabs = [];
//
//     if (_hasHistoricalSites()) {
//       tabs.add(Tab(
//         text: 'Sites',
//         icon: Icon(Icons.location_city, size: 20),
//       ));
//     }
//
//     if (_hasFoodPlaces()) {
//       tabs.add(Tab(
//         text: 'Food',
//         icon: Icon(Icons.restaurant, size: 20),
//       ));
//     }
//
//     if (_hasServices()) {
//       tabs.add(Tab(
//         text: 'Services',
//         icon: Icon(Icons.business, size: 20),
//       ));
//     }
//
//     // If no tabs, add a default tab
//     if (tabs.isEmpty) {
//       tabs.add(Tab(
//         text: 'Results',
//         icon: Icon(Icons.info, size: 20),
//       ));
//     }
//
//     return tabs;
//   }
//
//   Widget _buildPreferencesSummary() {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.person, color: Colors.orange[700], size: 20),
//               SizedBox(width: 8),
//               Text(
//                 'Your Preferences',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//           Wrap(
//             spacing: 8,
//             runSpacing: 4,
//             children: _buildPreferenceChips(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildPreferenceChips() {
//     List<Widget> chips = [];
//
//     final prefs = widget.userPreferences;
//
//     if (prefs['interest_type'] != null) {
//       chips.add(_buildChip(_formatPreference(prefs['interest_type']), Icons.temple_buddhist));
//     }
//
//     if (prefs['location_preference'] != null) {
//       chips.add(_buildChip(_formatPreference(prefs['location_preference']), Icons.location_on));
//     }
//
//     if (prefs['dietary_preference'] != null) {
//       chips.add(_buildChip(_formatPreference(prefs['dietary_preference']), Icons.restaurant_menu));
//     }
//
//     if (prefs['food_type'] != null) {
//       chips.add(_buildChip(_formatPreference(prefs['food_type']), Icons.fastfood));
//     }
//
//     return chips;
//   }
//
//   Widget _buildChip(String label, IconData icon) {
//     return Chip(
//       avatar: Icon(icon, size: 16, color: Colors.orange[700]),
//       label: Text(
//         label,
//         style: TextStyle(fontSize: 12, color: Colors.orange[800]),
//       ),
//       backgroundColor: Colors.orange[50],
//       side: BorderSide(color: Colors.orange[200]!),
//     );
//   }
//
//   String _formatPreference(String pref) {
//     return pref.replaceAll('_', ' ').split(' ')
//         .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
//         .join(' ');
//   }
//
//   Widget _buildTabView() {
//     return TabBarView(
//       controller: _tabController,
//       children: _buildTabViews(),
//     );
//   }
//
//   List<Widget> _buildTabViews() {
//     List<Widget> views = [];
//
//     if (_hasHistoricalSites()) {
//       views.add(_buildHistoricalSitesTab());
//     }
//
//     if (_hasFoodPlaces()) {
//       views.add(_buildFoodPlacesTab());
//     }
//
//     if (_hasServices()) {
//       views.add(_buildServicesTab());
//     }
//
//     // If no views, add empty view
//     if (views.isEmpty) {
//       views.add(_buildEmptyTabView());
//     }
//
//     return views;
//   }
//
//   Widget _buildEmptyTabView() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.info_outline, size: 64, color: Colors.grey[400]),
//           SizedBox(height: 16),
//           Text(
//             'No data available',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHistoricalSitesTab() {
//     final sites = widget.recommendations['historical_sites'] as List;
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: sites.length,
//       itemBuilder: (context, index) {
//         final site = sites[index];
//         return _buildSiteCard(site);
//       },
//     );
//   }
//
//   Widget _buildFoodPlacesTab() {
//     final places = widget.recommendations['food_places'] as List;
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: places.length,
//       itemBuilder: (context, index) {
//         final place = places[index];
//         return _buildFoodCard(place);
//       },
//     );
//   }
//
//   Widget _buildServicesTab() {
//     final services = widget.recommendations['services'] as List;
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: services.length,
//       itemBuilder: (context, index) {
//         final service = services[index];
//         return _buildServiceCard(service);
//       },
//     );
//   }
//
//   Widget _buildSiteCard(Map<String, dynamic> site) {
//     final String siteName = site['name'] ?? 'Unknown Site';
//     final bool isFavorite = favoriteItems.contains('site_$siteName');
//
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     siteName,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: isFavorite ? Colors.red : Colors.grey[400],
//                   ),
//                   onPressed: () => _toggleFavorite('site_$siteName'),
//                 ),
//                 if (site['relevance_score'] != null)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.orange[100],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       '${(site['relevance_score'] * 100).toInt()}% match',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.orange[800],
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(height: 8),
//             if (site['description'] != null)
//               Text(
//                 site['description'],
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.4,
//                 ),
//               ),
//             SizedBox(height: 12),
//             _buildSiteDetails(site),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSiteDetails(Map<String, dynamic> site) {
//     return Column(
//       children: [
//         if (site['location'] != null)
//           _buildDetailRow(Icons.location_on, 'Location', site['location']),
//         if (site['site_type'] != null)
//           _buildDetailRow(Icons.category, 'Type', site['site_type']),
//         if (site['visiting_hours'] != null)
//           _buildDetailRow(Icons.access_time, 'Hours', site['visiting_hours']),
//         if (site['entry_fee'] != null)
//           _buildDetailRow(Icons.monetization_on, 'Entry Fee', site['entry_fee']),
//         if (site['unesco_status'] == true)
//           _buildDetailRow(Icons.star, 'UNESCO', 'World Heritage Site'),
//       ],
//     );
//   }
//
//   Widget _buildFoodCard(Map<String, dynamic> place) {
//     final String placeName = place['name'] ?? 'Unknown Place';
//     final bool isFavorite = favoriteItems.contains('food_$placeName');
//
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     placeName,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: isFavorite ? Colors.red : Colors.grey[400],
//                   ),
//                   onPressed: () => _toggleFavorite('food_$placeName'),
//                 ),
//                 if (place['relevance_score'] != null)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.orange[100],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       '${(place['relevance_score'] * 100).toInt()}% match',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.orange[800],
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(height: 8),
//             if (place['description'] != null)
//               Text(
//                 place['description'],
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.4,
//                 ),
//               ),
//             SizedBox(height: 12),
//             _buildFoodDetails(place),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFoodDetails(Map<String, dynamic> place) {
//     return Column(
//       children: [
//         if (place['location'] != null)
//           _buildDetailRow(Icons.location_on, 'Location', place['location']),
//         if (place['food_type'] != null)
//           _buildDetailRow(Icons.restaurant, 'Type', place['food_type']),
//         if (place['price_range'] != null)
//           _buildDetailRow(Icons.attach_money, 'Price', place['price_range']),
//         if (place['rating'] != null)
//           _buildDetailRow(Icons.star, 'Rating', '${place['rating']}/5'),
//         if (place['dietary_options'] != null && place['dietary_options'] is List)
//           _buildDetailRow(Icons.restaurant_menu, 'Dietary Options',
//               (place['dietary_options'] as List).join(', ')),
//         if (place['contact_info'] != null)
//           _buildContactInfo(place['contact_info']),
//       ],
//     );
//   }
//
//   Widget _buildServiceCard(Map<String, dynamic> service) {
//     final String serviceName = service['name'] ?? 'Unknown Service';
//     final bool isFavorite = favoriteItems.contains('service_$serviceName');
//
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     serviceName,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[800],
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: isFavorite ? Colors.red : Colors.grey[400],
//                   ),
//                   onPressed: () => _toggleFavorite('service_$serviceName'),
//                 ),
//                 if (service['relevance_score'] != null)
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.orange[100],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       '${(service['relevance_score'] * 100).toInt()}% match',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.orange[800],
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             SizedBox(height: 8),
//             if (service['description'] != null)
//               Text(
//                 service['description'],
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.4,
//                 ),
//               ),
//             SizedBox(height: 12),
//             _buildServiceDetails(service),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildServiceDetails(Map<String, dynamic> service) {
//     return Column(
//       children: [
//         if (service['location'] != null)
//           _buildDetailRow(Icons.location_on, 'Location', service['location']),
//         if (service['service_type'] != null)
//           _buildDetailRow(Icons.business, 'Type', service['service_type']),
//         if (service['specialties'] != null && service['specialties'] is List)
//           _buildDetailRow(Icons.star_outline, 'Specialties',
//               (service['specialties'] as List).join(', ')),
//         if (service['contact_info'] != null)
//           _buildContactInfo(service['contact_info']),
//       ],
//     );
//   }
//
//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 16, color: Colors.orange[600]),
//           SizedBox(width: 8),
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[700],
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactInfo(Map<String, dynamic> contactInfo) {
//     return Column(
//       children: [
//         if (contactInfo['phone'] != null)
//           _buildDetailRow(Icons.phone, 'Phone', contactInfo['phone']),
//         if (contactInfo['email'] != null)
//           _buildDetailRow(Icons.email, 'Email', contactInfo['email']),
//         if (contactInfo['website'] != null)
//           _buildDetailRow(Icons.web, 'Website', contactInfo['website']),
//       ],
//     );
//   }
//
//   void _toggleFavorite(String itemId) {
//     setState(() {
//       if (favoriteItems.contains(itemId)) {
//         favoriteItems.remove(itemId);
//       } else {
//         favoriteItems.add(itemId);
//       }
//     });
//   }
//
//   void _showFavorites() {
//     if (favoriteItems.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No favorites added yet!'),
//           backgroundColor: Colors.orange[600],
//         ),
//       );
//       return;
//     }
//
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Your Favorites',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: favoriteItems.length,
//                   itemBuilder: (context, index) {
//                     final item = favoriteItems[index];
//                     final type = item.split('_')[0];
//                     final name = item.substring(item.indexOf('_') + 1);
//
//                     return ListTile(
//                       leading: Icon(
//                         type == 'site' ? Icons.location_city :
//                         type == 'food' ? Icons.restaurant : Icons.business,
//                         color: Colors.orange[700],
//                       ),
//                       title: Text(name),
//                       subtitle: Text(_formatPreference(type)),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           setState(() {
//                             favoriteItems.remove(item);
//                           });
//                           Navigator.pop(context);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _generateItinerary() async {
//     setState(() {
//       _loadingItinerary = true;
//     });
//
//     try {
//       final response = await http.post(
//         Uri.parse('$API_BASE_URL/itinerary'),
//         headers: {
//           'Content-Type': 'application/json',
//           'ngrok-skip-browser-warning': 'true',
//         },
//         body: json.encode({
//           'preferences': widget.userPreferences,
//           'days': 3, // Default to 3 days
//         }),
//       ).timeout(Duration(seconds: 30));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           _itinerary = data['data'] ?? [];
//           _showItinerary = true;
//         });
//       } else {
//         throw Exception('Failed to generate itinerary');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to generate itinerary: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _loadingItinerary = false;
//       });
//     }
//   }
//
//   Widget _buildItineraryView() {
//     if (_loadingItinerary) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Colors.orange[700]),
//             SizedBox(height: 16),
//             Text('Generating your itinerary...'),
//           ],
//         ),
//       );
//     }
//
//     if (_itinerary.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.calendar_today, size: 64, color: Colors.grey[400]),
//             SizedBox(height: 16),
//             Text('No itinerary available'),
//           ],
//         ),
//       );
//     }
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: _itinerary.length,
//       itemBuilder: (context, index) {
//         final day = _itinerary[index];
//         return _buildDayCard(day);
//       },
//     );
//   }
//
//   Widget _buildDayCard(Map<String, dynamic> day) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Day ${day['day']}',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.orange[700],
//               ),
//             ),
//             SizedBox(height: 16),
//             if (day['sites'] != null && day['sites'].isNotEmpty) ...[
//               Text(
//                 'Historical Sites:',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 8),
//               ...((day['sites'] as List).map((site) =>
//                   Padding(
//                     padding: EdgeInsets.only(left: 16, bottom: 4),
//                     child: Text('• ${site['name']}'),
//                   )
//               )),
//               SizedBox(height: 12),
//             ],
//             if (day['recommended_food'] != null && day['recommended_food'].isNotEmpty) ...[
//               Text(
//                 'Recommended Food:',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 8),
//               ...((day['recommended_food'] as List).map((food) =>
//                   Padding(
//                     padding: EdgeInsets.only(left: 16, bottom: 4),
//                     child: Text('• ${food['name']}'),
//                   )
//               )),
//               SizedBox(height: 12),
//             ],
//             if (day['services'] != null && day['services'].isNotEmpty) ...[
//               Text(
//                 'Services:',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 8),
//               ...((day['services'] as List).map((service) =>
//                   Padding(
//                     padding: EdgeInsets.only(left: 16, bottom: 4),
//                     child: Text('• ${service['name']}'),
//                   )
//               )),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import '../utils/colors.dart';
//
// class RecommendationsDisplayScreen extends StatefulWidget {
//   final Map<String, dynamic> data;
//
//   RecommendationsDisplayScreen({required this.data});
//
//   @override
//   _RecommendationsDisplayScreenState createState() => _RecommendationsDisplayScreenState();
// }
//
// class _RecommendationsDisplayScreenState extends State<RecommendationsDisplayScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         _selectedIndex = _tabController.index;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Recommendations'),
//         backgroundColor: AppColors.primaryBrown,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           indicatorWeight: 3,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           tabs: [
//             Tab(
//               icon: Icon(Icons.location_city),
//               text: 'Sites (${widget.data['historical_sites']?.length ?? 0})',
//             ),
//             Tab(
//               icon: Icon(Icons.restaurant),
//               text: 'Food (${widget.data['food_places']?.length ?? 0})',
//             ),
//             Tab(
//               icon: Icon(Icons.business),
//               text: 'Services (${widget.data['services']?.length ?? 0})',
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildHistoricalSitesTab(),
//           _buildFoodPlacesTab(),
//           _buildServicesTab(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showItineraryDialog(context),
//         backgroundColor: AppColors.primaryBrown,
//         icon: Icon(Icons.calendar_today),
//         label: Text('Create Itinerary'),
//       ),
//     );
//   }
//
//   Widget _buildHistoricalSitesTab() {
//     final sites = widget.data['historical_sites'] as List<dynamic>? ?? [];
//
//     if (sites.isEmpty) {
//       return _buildEmptyState('No historical sites found', Icons.location_city);
//     }
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: sites.length,
//       itemBuilder: (context, index) {
//         final site = sites[index];
//         return _buildHistoricalSiteCard(site);
//       },
//     );
//   }
//
//   Widget _buildHistoricalSiteCard(Map<String, dynamic> site) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with name and score
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: AppColors.primaryBrown.withOpacity(0.1),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     site['name'] ?? 'Unknown Site',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.primaryBrown,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryBrown,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     '${(site['relevance_score'] * 100).toInt()}%',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Content
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow(Icons.category, 'Type', site['site_type']),
//                 _buildInfoRow(Icons.location_on, 'Location', site['location']),
//                 _buildInfoRow(Icons.public, 'Region', site['region']),
//                 if (site['unesco_status'] == true)
//                   _buildInfoRow(Icons.star, 'UNESCO World Heritage Site', null),
//                 if (site['visiting_hours'] != null)
//                   _buildInfoRow(Icons.access_time, 'Hours', site['visiting_hours']),
//                 if (site['entry_fee'] != null)
//                   _buildInfoRow(Icons.monetization_on, 'Entry Fee', site['entry_fee']),
//                 if (site['description'] != null && site['description'].toString().isNotEmpty)
//                   Padding(
//                     padding: EdgeInsets.only(top: 8),
//                     child: Text(
//                       site['description'],
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[700],
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFoodPlacesTab() {
//     final foodPlaces = widget.data['food_places'] as List<dynamic>? ?? [];
//
//     if (foodPlaces.isEmpty) {
//       return _buildEmptyState('No food places found', Icons.restaurant);
//     }
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: foodPlaces.length,
//       itemBuilder: (context, index) {
//         final place = foodPlaces[index];
//         return _buildFoodPlaceCard(place);
//       },
//     );
//   }
//
//   Widget _buildFoodPlaceCard(Map<String, dynamic> place) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with name and score
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.orange.withOpacity(0.1),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     place['name'] ?? 'Unknown Restaurant',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.orange[800],
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     if (place['rating'] != null) ...[
//                       Icon(Icons.star, color: Colors.amber, size: 16),
//                       Text(
//                         place['rating'].toString(),
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(width: 8),
//                     ],
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         '${(place['relevance_score'] * 100).toInt()}%',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           // Content
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow(Icons.restaurant_menu, 'Food Type', place['food_type']),
//                 _buildInfoRow(Icons.location_on, 'Location', place['location']),
//                 if (place['dietary_options'] != null && place['dietary_options'].isNotEmpty)
//                   _buildDietaryOptions(place['dietary_options']),
//                 if (place['price_range'] != null)
//                   _buildInfoRow(Icons.attach_money, 'Price Range', place['price_range']),
//                 if (place['specialties'] != null && place['specialties'].isNotEmpty)
//                   _buildSpecialties(place['specialties']),
//                 if (place['contact_info'] != null)
//                   _buildContactInfo(place['contact_info']),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildServicesTab() {
//     final services = widget.data['services'] as List<dynamic>? ?? [];
//
//     if (services.isEmpty) {
//       return _buildEmptyState('No services found', Icons.business);
//     }
//
//     return ListView.builder(
//       padding: EdgeInsets.all(16),
//       itemCount: services.length,
//       itemBuilder: (context, index) {
//         final service = services[index];
//         return _buildServiceCard(service);
//       },
//     );
//   }
//
//   Widget _buildServiceCard(Map<String, dynamic> service) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with name and score
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.1),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     service['name'] ?? 'Unknown Service',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue[800],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     '${(service['relevance_score'] * 100).toInt()}%',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Content
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildInfoRow(Icons.business, 'Service Type', service['service_type']),
//                 _buildInfoRow(Icons.location_on, 'Location', service['location']),
//                 if (service['description'] != null && service['description'].toString().isNotEmpty)
//                   Padding(
//                     padding: EdgeInsets.only(top: 8, bottom: 8),
//                     child: Text(
//                       service['description'],
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[700],
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 if (service['specialties'] != null && service['specialties'].isNotEmpty)
//                   _buildSpecialties(service['specialties']),
//                 if (service['contact_info'] != null)
//                   _buildContactInfo(service['contact_info']),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(IconData icon, String label, String? value) {
//     if (value == null || value.isEmpty) return SizedBox.shrink();
//
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 16, color: Colors.grey[600]),
//           SizedBox(width: 8),
//           Text(
//             '$label: ',
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[700],
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.grey[800]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDietaryOptions(List<dynamic> options) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.restaurant, size: 16, color: Colors.grey[600]),
//           SizedBox(width: 8),
//           Text(
//             'Dietary: ',
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[700],
//             ),
//           ),
//           Expanded(
//             child: Wrap(
//               spacing: 4,
//               children: options.map<Widget>((option) => Chip(
//                 label: Text(
//                   option.toString().replaceAll('_', ' ').toUpperCase(),
//                   style: TextStyle(fontSize: 10),
//                 ),
//                 backgroundColor: Colors.green.withOpacity(0.1),
//                 labelStyle: TextStyle(color: Colors.green[800]),
//                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               )).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSpecialties(List<dynamic> specialties) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.stars, size: 16, color: Colors.grey[600]),
//           SizedBox(width: 8),
//           Text(
//             'Specialties: ',
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.grey[700],
//             ),
//           ),
//           Expanded(
//             child: Wrap(
//               spacing: 4,
//               children: specialties.map<Widget>((specialty) => Chip(
//                 label: Text(
//                   specialty.toString(),
//                   style: TextStyle(fontSize: 10),
//                 ),
//                 backgroundColor: Colors.purple.withOpacity(0.1),
//                 labelStyle: TextStyle(color: Colors.purple[800]),
//                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               )).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactInfo(Map<String, dynamic> contactInfo) {
//     return Container(
//       margin: EdgeInsets.only(top: 8),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Contact Information',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: AppColors.primaryBrown,
//             ),
//           ),
//           SizedBox(height: 4),
//           if (contactInfo['phone'] != null)
//             _buildContactRow(Icons.phone, contactInfo['phone']),
//           if (contactInfo['email'] != null)
//             _buildContactRow(Icons.email, contactInfo['email']),
//           if (contactInfo['website'] != null)
//             _buildContactRow(Icons.web, contactInfo['website']),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactRow(IconData icon, String value) {
//     return Padding(
//       padding: EdgeInsets.only(top: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: Colors.grey[600]),
//           SizedBox(width: 6),
//           Text(
//             value,
//             style: TextStyle(fontSize: 12, color: Colors.grey[700]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String message, IconData icon) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 64, color: Colors.grey[400]),
//           SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Try adjusting your preferences',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showItineraryDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Create Itinerary'),
//           content: Text('How many days would you like your itinerary to be?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // TODO: Navigate to itinerary creation screen
//                 // You can implement this by calling your backend's /itinerary endpoint
//               },
//               child: Text('Create'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
