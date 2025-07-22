// lib/screens/image_viewer_screen.dart
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  final String title; // Optional: to display a title in the AppBar

  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
    this.title = 'Image Viewer', // Default title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background for image viewing
      appBar: AppBar(
        backgroundColor: Colors.black, // Black AppBar
        iconTheme: const IconThemeData(color: Colors.white), // White back icon
        title: Text(
          title,
          style: const TextStyle(color: Colors.white), // White title text
        ),
      ),
      body: Center(
        child: Hero( // Use Hero widget for a smooth transition animation
          tag: imageUrl, // Unique tag for the Hero animation
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain, // Ensure the entire image is visible
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.progress,
                  color: Colors.white,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 100,
              ); // Placeholder for error
            },
          ),
        ),
      ),
    );
  }
}

extension on ImageChunkEvent {
  get progress => null;
}
