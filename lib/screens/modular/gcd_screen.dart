import 'package:flutter/material.dart';
import '../../../styles/app_styles.dart';

class GCDScreen extends StatefulWidget {
  const GCDScreen({super.key});

  @override
  State<GCDScreen> createState() => _GCDScreenState();
}

class _GCDScreenState extends State<GCDScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String _result = '';

  int _calculateGCD(int a, int b) {
    // Implementación del algoritmo de Euclides
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final a = int.parse(_aController.text);
        final b = int.parse(_bController.text);

        final gcd = _calculateGCD(a, b);

        setState(() {
          _result = '''
Número a: $a
Número b: $b
MCD: $gcd
''';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Máximo Común Divisor'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Máximo Común Divisor',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _aController,
                decoration: AppStyles.textFieldInputDecoration('Número a', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bController,
                decoration: AppStyles.textFieldInputDecoration('Número b', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculate,
                style: AppStyles.elevatedButtonStyle,
                child: const Text('Calcular', style: AppStyles.buttonTextStyle),
              ),
              if (_result.isNotEmpty) ...[
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Resultado',
                          style: AppStyles.cardTitleStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _result,
                          style: AppStyles.priceStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }
} 