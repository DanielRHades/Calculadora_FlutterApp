import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';
import 'modern/diffie_hellman_screen.dart';
import 'modern/rsa_screen.dart';
import 'modern/fast_exponentiation_screen.dart';

class ModernCryptoScreen extends StatelessWidget {
  const ModernCryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptografía Moderna'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Criptografía Moderna',
            style: AppStyles.titleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildMenuCard(
            context,
            'Diffie-Hellman',
            'Intercambio de claves Diffie-Hellman',
            Icons.key,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DiffieHellmanScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'RSA',
            'Cifrado RSA',
            Icons.lock,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RSAScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Exponenciación Rápida',
            'Algoritmo de exponenciación rápida',
            Icons.speed,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FastExponentiationScreen()),
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