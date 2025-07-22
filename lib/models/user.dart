// lib/models/user.dart
class User {
  final String id; // Unique ID, will be Firebase UID later
  final String name;
  final String username;
  final String status; // e.g., 'Online', 'Offline', 'Away'
  final String image; // URL to profile image
  final String lastSeen; // e.g., 'Active now', 'Last seen 2 hours ago'
  final String bio;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.status,
    required this.image,
    required this.lastSeen,
    required this.bio,
  });

  // Factory constructor to create a User from a Map (useful for dummy data or later from Firestore)
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'] ?? '',
      name: data['name'] ?? 'Unknown User',
      username: data['username'] ?? 'unknown',
      status: data['status'] ?? 'Offline',
      image: data['image'] ?? 'https://placehold.co/60x60/CCCCCC/000000?text=User', // Default placeholder
      lastSeen: data['lastSeen'] ?? '',
      bio: data['bio'] ?? 'No bio available.',
    );
  }

  // Method to convert User to a Map (useful for dummy data or later for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'status': status,
      'image': image,
      'lastSeen': lastSeen,
      'bio': bio,
    };
  }
}