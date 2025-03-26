import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';
import 'modular/modulo_screen.dart';
import 'modular/additive_inverse_screen.dart';
import 'modular/xor_inverse_screen.dart';
import 'modular/gcd_screen.dart';
import 'modular/multiplicative_inverse_screen.dart';

class ModularOperationsScreen extends StatelessWidget {
  const ModularOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operaciones Modulares'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Operaciones Modulares',
            style: AppStyles.titleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildMenuCard(
            context,
            'Módulo',
            'Calcular el módulo de un número',
            Icons.numbers,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ModuloScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Inverso Aditivo',
            'Calcular el inverso aditivo módulo n',
            Icons.remove_circle,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdditiveInverseScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Inverso XOR',
            'Calcular el inverso XOR módulo n',
            Icons.calculate,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const XORInverseScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'MCD',
            'Calcular el máximo común divisor',
            Icons.calculate,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GCDScreen()),
            ),
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            'Inverso Multiplicativo',
            'Calcular el inverso multiplicativo módulo n',
            Icons.calculate,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MultiplicativeInverseScreen()),
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