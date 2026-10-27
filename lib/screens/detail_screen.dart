import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';
import 'package:wisata_candi/screens/profile_screen.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavoriteProvider>().isFavorite(candi.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(candi.name),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FavoriteProvider>().toggle(candi.name);
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              candi.imageAsset,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    candi.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${candi.location} | ${candi.type}'),
                  const SizedBox(height: 16),
                  Text(candi.description),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol sementara untuk menguji perpindahan ke ProfileScreen (Slide 19)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        },
        child: const Icon(Icons.person),
      ),
    );
  }
}
