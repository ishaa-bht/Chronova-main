import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final Location _location = Location();

  LocationData? _currentLocation;
  final List<LatLng> _routePoints = [];
  final List<Marker> _markers = [];

  final String _orsApiKey = '5b3ce3597851110001cf624822a2c9301433415889356c2c851a3ca3';
  String _searchedPlace = 'Search location';
  String? _routeInfo;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final loc = await _location.getLocation();
    setState(() => _currentLocation = loc);

    _location.onLocationChanged.listen((newLoc) {
      setState(() => _currentLocation = newLoc);
    });
  }

  Future<LatLng?> _searchLocation(String query) async {
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1';

    final response = await http.get(Uri.parse(url), headers: {
      'User-Agent': 'FlutterApp',
    });

    if (response.statusCode == 200) {
      final results = json.decode(response.body) as List<dynamic>;
      if (results.isNotEmpty) {
        final lat = double.parse(results[0]['lat']);
        final lon = double.parse(results[0]['lon']);
        return LatLng(lat, lon);
      }
    }
    return null;
  }
  void _showSearchDialog() {
    final TextEditingController _searchController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Search Location',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter place name',
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _performSearch(context, _searchController.text),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _performSearch(context, _searchController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD2B48C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performSearch(BuildContext context, String query) async {
    Navigator.of(context).pop();
    final location = await _searchLocation(query);
    if (location != null && _currentLocation != null) {
      setState(() {
        _searchedPlace = query;
        _markers.clear();
        _routePoints.clear();

        _markers.add(
          Marker(
            point: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
            width: 60,
            height: 60,
            child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
          ),
        );

        _markers.add(
          Marker(
            point: location,
            width: 60,
            height: 60,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );
      });

      _getRoute(
        LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        location,
      );

      _mapController.move(location, 14.0);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location not found")),
      );
    }
  }

  Future<void> _getRoute(LatLng from, LatLng to) async {
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$_orsApiKey&start=${from.longitude},${from.latitude}&end=${to.longitude},${to.latitude}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coords = data['features'][0]['geometry']['coordinates'] as List<dynamic>;
      final distance = data['features'][0]['properties']['segments'][0]['distance'];

      setState(() {
        _routePoints.clear();
        _routePoints.addAll(coords.map((c) => LatLng(c[1], c[0])));
        _routeInfo = '${(distance / 1000).toStringAsFixed(2)} km';
      });
    } else {
      print("Failed to get route: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: _showSearchDialog,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _searchedPlace,
                    style: const TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFF8B4513),
      ),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(
                _currentLocation!.latitude!,
                _currentLocation!.longitude!,
              ),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: _markers),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    strokeWidth: 4,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
          if (_routeInfo != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                ),
                child: Text(
                  '🚗 $_routeInfo',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentLocation != null) {
            final loc = LatLng(
              _currentLocation!.latitude!,
              _currentLocation!.longitude!,
            );
            _mapController.move(loc, 15);
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}