import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';
import 'encoding/binary_screen.dart';
import 'encoding/hex_screen.dart';
import 'encoding/base64_screen.dart';

class EncodingScreen extends StatelessWidget {
  const EncodingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Codificación'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Codificación',
            style: AppStyles.titleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildMenuCard(
            context,
            'Binario',
            'Codificación y decodificación binaria',
            Icons.code,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BinaryScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Hexadecimal',
            'Codificación y decodificación hexadecimal',
            Icons.code,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HexScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Base64',
            'Codificación y decodificación Base64',
            Icons.code,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Base64Screen()),
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