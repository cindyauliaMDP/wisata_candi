import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/providers/auth_provider.dart';

import 'package:wisata_candi/providers/favorite_provider.dart';

import 'package:wisata_candi/screens/sign_in_screen.dart';
import 'package:wisata_candi/widgets/profile_info_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final favoriteCount = context.watch<FavoriteProvider>().count;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'images/placeholder_image.png',
                            ),
                          ),
                        ),
                        if (auth.isSignedIn)
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris Pengguna (Menggunakan auth.username sesuai Slide 30)
                ProfileInfoItem(
                  icon: Icons.lock,
                  label: 'Pengguna',
                  value: auth.isSignedIn ? auth.username : '',
                  iconColor: Colors.amber,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                ProfileInfoItem(
                  icon: Icons.person,
                  label: 'Nama',
                  value: auth.isSignedIn ? auth.username : '',
                  showEditIcon: auth.isSignedIn,
                  onEditPressed: () {
                    debugPrint('Icon edit ditekan');
                  },
                  iconColor: Colors.blue,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris Favorit (Membaca jumlah dari FavoriteProvider)
                ProfileInfoItem(
                  icon: Icons.favorite,
                  label: 'Favorit',
                  value: auth.isSignedIn && favoriteCount > 0
                      ? '$favoriteCount'
                      : '0',
                  iconColor: Colors.red,
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),

                const SizedBox(height: 20),
                auth.isSignedIn
                    ? TextButton(
                        onPressed: () {
                          // Sign Out & Hapus Semua Favorit (Latihan Mandiri Slide 30)
                          context.read<AuthProvider>().signOut();
                          context.read<FavoriteProvider>().clearAll();
                        },
                        child: const Text('Sign Out'),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text('Sign In'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
