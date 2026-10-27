import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/providers/auth_provider.dart';
import 'package:wisata_candi/providers/favorite_provider.dart';
import 'package:wisata_candi/screens/detail_screen.dart';
import 'package:wisata_candi/screens/profile_screen.dart';
import 'package:wisata_candi/screens/sign_in_screen.dart';
import 'package:wisata_candi/screens/sign_up_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ).copyWith(primary: Colors.deepPurple, surface: Colors.deepPurple[50]),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

// CandiHomePage tetap dipertahankan
class CandiHomePage extends StatelessWidget {
  const CandiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final candi = candiList[0];

    return Scaffold(
      appBar: AppBar(title: const Text('Wisata Candi')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(candi: candi)),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(candi.imageAsset, height: 220, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    candi.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text('Ketuk untuk melihat detail candi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
