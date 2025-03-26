import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';
import 'modular_operations_screen.dart';
import 'classical_crypto_screen.dart';
import 'modern_crypto_screen.dart';
import 'hash_screen.dart';
import 'encoding_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Criptográfica'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Calculadora Criptográfica',
            style: AppStyles.titleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildMenuCard(
            context,
            'Operaciones Matemáticas Modulares',
            'Operaciones básicas y avanzadas con módulos',
            Icons.calculate,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModularOperationsScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Criptografía Clásica',
            'Métodos de cifrado clásicos',
            Icons.lock,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClassicalCryptoScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Criptografía Moderna',
            'Métodos de cifrado modernos',
            Icons.security,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModernCryptoScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Algoritmos Hash',
            'Funciones hash criptográficas',
            Icons.fingerprint,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HashScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Codificación',
            'Métodos de codificación y decodificación',
            Icons.code,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EncodingScreen()),
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