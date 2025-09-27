import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// A helper class to manage location permissions, coordinates, and address lookup.
/// All methods are static so you can call them directly without instantiating the class.
class LocationService {
  LocationService._(); // Private constructor to prevent instantiation

  /// Requests location permission if not already granted,
  /// then fetches the current GPS position.
  ///
  /// Throws an exception if permission is denied or permanently denied.
  static Future<Position> getCurrentLocation() async {
    // Check current permission status
    LocationPermission permission = await Geolocator.checkPermission();

    // If permission is denied, request it
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // If permission is permanently denied, guide user to settings
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings(); // Optional: open settings
      throw Exception('Location permission permanently denied. Please enable it from settings.');
    }

    // If still denied after request, throw error
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }

    // Fetch current position with high accuracy
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// Converts a [Position] (latitude & longitude) into a human-readable address.
  ///
  /// Returns a formatted string like "City, State, Country".
  /// Falls back to raw coordinates if no placemark is found.
  static Future<String> getAddressFromPosition(Position pos) async {
    try {
      final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return '${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.country ?? ''}';
      }

      // Fallback: return lat/lng if no placemark found
      return '${pos.latitude.toStringAsFixed(3)}, ${pos.longitude.toStringAsFixed(3)}';
    } catch (e) {
      // Handle geocoding failure
      return '${pos.latitude.toStringAsFixed(3)}, ${pos.longitude.toStringAsFixed(3)}';
    }
  }
}
