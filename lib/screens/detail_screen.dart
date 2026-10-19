import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wisata_candi/models/candi.dart';

class DetailScreen extends StatefulWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final candi = widget.candi;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: gambar utama dan tombol kembali
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      candi.imageAsset,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.deepPurple.shade50,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 48,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      child: IconButton(
                        tooltip: 'Kembali',
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Kamu sudah berada di halaman utama.',
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Informasi candi dan tombol favorit
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          candi.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: candi.isFavorite
                            ? 'Hapus dari favorit'
                            : 'Tambahkan ke favorit',
                        onPressed: () {
                          setState(() {
                            candi.isFavorite = !candi.isFavorite;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                candi.isFavorite
                                    ? '${candi.name} ditambahkan ke favorit'
                                    : '${candi.name} dihapus dari favorit',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          candi.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: candi.isFavorite ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    Icons.location_on,
                    Colors.red,
                    'Lokasi',
                    candi.location,
                  ),
                  _infoRow(
                    Icons.calendar_month,
                    Colors.blue,
                    'Dibangun',
                    candi.built,
                  ),
                  _infoRow(
                    Icons.account_balance,
                    Colors.green,
                    'Tipe',
                    candi.type,
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Colors.deepPurple.shade100),
                  const SizedBox(height: 12),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    candi.description,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),

            // Galeri gambar dari internet
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.deepPurple.shade100),
                  const SizedBox(height: 12),
                  const Text(
                    'Galeri Candi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 130,
                    child: candi.imageUrls.isEmpty
                        ? const Center(child: Text('Belum ada foto galeri.'))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: candi.imageUrls.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: candi.imageUrls[index],
                                    width: 140,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Container(
                                        width: 140,
                                        color: Colors.deepPurple.shade50,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        width: 140,
                                        color: Colors.deepPurple.shade50,
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 36,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Geser foto ke samping untuk melihat galeri.',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(': $value')),
        ],
      ),
    );
  }
}
