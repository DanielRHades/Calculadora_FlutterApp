import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import 'classical/mod27_screen.dart';
import 'classical/caesar_screen.dart';
import 'classical/vernam_screen.dart';
import 'classical/atbash_screen.dart';
import 'classical/transposition_screen.dart';
import 'classical/affine_screen.dart';
import 'classical/simple_substitution_screen.dart';

class ClassicalCryptoScreen extends StatelessWidget {
  const ClassicalCryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptografía Clásica'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Criptografía Clásica',
              style: AppStyles.titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildMenuCard(
              context,
              'Cifrado Módulo 27',
              Icons.numbers,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Mod27Screen()),
              ),
            ),
            _buildMenuCard(
              context,
              'Cifrado César',
              Icons.arrow_forward,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CaesarScreen()),
              ),
            ),
            _buildMenuCard(
              context,
              'Cifrado Vernam',
              Icons.calculate,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VernamScreen()),
              ),
            ),
            _buildMenuCard(
              context,
              'Cifrado ATBASH',
              Icons.arrow_back,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AtbashScreen()),
              ),
            ),
            _buildMenuCard(
              context,
              'Cifrado Transposición Columnar Simple',
              Icons.swap_horiz,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TranspositionScreen()),
              ),
            ),
            _buildMenuCard(
              context,
              'Cifrado Afín',
              Icons.functions,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AffineScreen()),
              ),
            ),
            _buildMenuCard(
              context,
              'Cifra de Sustitución Simple',
              Icons.swap_vert,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SimpleSubstitutionScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 32, color: AppStyles.primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.cardTitleStyle,
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
} 