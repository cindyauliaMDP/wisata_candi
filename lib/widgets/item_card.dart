import 'package:flutter/material.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/screens/detail_screen.dart';

class ItemCard extends StatelessWidget {
  // TODO: 1. Deklarasikan variabel yang dibutuhkan dan pasang pada konstruktor
  final Candi candi;

  const ItemCard({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    // TODO: 6. Implementasi routing ke DetailScreen
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(candi: candi)),
        );
      },
      child: Card(
        // TODO: 2. Tetapkan parameter shape, margin, dan elevation dari Card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(4),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: 3. Buat Image sebagai anak dari Column
            Expanded(
              // TODO: 7. Implementasi Hero animation
              child: Hero(
                tag: candi.imageAsset,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    candi.imageAsset,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // TODO: 4. Buat Text sebagai nama candi
            // Text nama candi
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                candi.name,
                textAlign: TextAlign.center,   // <-- tambahan
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Text jenis candi
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                candi.type,
                textAlign: TextAlign.center,   // <-- tambahan
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
