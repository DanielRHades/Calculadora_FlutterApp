import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';
import 'hash/md5_screen.dart';
import 'hash/sha128_screen.dart';
import 'hash/sha512_screen.dart';

class HashScreen extends StatelessWidget {
  const HashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Algoritmos Hash'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Algoritmos Hash',
            style: AppStyles.titleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildMenuCard(
            context,
            'MD5',
            'Algoritmo de hash MD5',
            Icons.fingerprint,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MD5Screen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'SHA-128',
            'Algoritmo de hash SHA-128',
            Icons.fingerprint,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SHA128Screen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'SHA-512',
            'Algoritmo de hash SHA-512',
            Icons.fingerprint,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SHA512Screen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: AppStyles.primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.cardTitleStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppStyles.subtitleStyle,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
} 