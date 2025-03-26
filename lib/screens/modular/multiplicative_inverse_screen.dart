import 'package:flutter/material.dart';
import '../../../styles/app_styles.dart';

class MultiplicativeInverseScreen extends StatefulWidget {
  const MultiplicativeInverseScreen({super.key});

  @override
  State<MultiplicativeInverseScreen> createState() => _MultiplicativeInverseScreenState();
}

class _MultiplicativeInverseScreenState extends State<MultiplicativeInverseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _modulusController = TextEditingController();
  String _result = '';

  int _calculateGCD(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  int _calculateMultiplicativeInverse(int a, int n) {
    // Verificar si existe el inverso multiplicativo
    if (_calculateGCD(a, n) != 1) {
      throw Exception('No existe inverso multiplicativo');
    }

    // Implementación del algoritmo extendido de Euclides
    int m0 = n;
    int y = 0, x = 1;

    if (n == 1) return 0;

    while (a > 1) {
      int q = a ~/ n;
      int t = n;
      n = a % n;
      a = t;
      t = y;
      y = x - q * y;
      x = t;
    }

    if (x < 0) x += m0;
    return x;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final number = int.parse(_numberController.text);
        final modulus = int.parse(_modulusController.text);

        if (modulus <= 0) {
          throw Exception('El módulo debe ser un número positivo');
        }

        final inverse = _calculateMultiplicativeInverse(number, modulus);

        setState(() {
          _result = '''
Número: $number
Módulo: $modulus
Inverso multiplicativo: $inverse
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
        title: const Text('Inverso Multiplicativo'),
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
                'Inverso Multiplicativo',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _numberController,
                decoration: AppStyles.textFieldInputDecoration('Número', Icons.numbers),
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
                controller: _modulusController,
                decoration: AppStyles.textFieldInputDecoration('Módulo', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un módulo';
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
    _numberController.dispose();
    _modulusController.dispose();
    super.dispose();
  }
} 