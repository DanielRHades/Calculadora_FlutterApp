import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class FastExponentiationScreen extends StatefulWidget {
  const FastExponentiationScreen({super.key});

  @override
  State<FastExponentiationScreen> createState() => _FastExponentiationScreenState();
}

class _FastExponentiationScreenState extends State<FastExponentiationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _baseController = TextEditingController();
  final _exponentController = TextEditingController();
  final _modulusController = TextEditingController();
  String _result = '';
  List<String> _steps = [];

  int _modPow(int base, int exponent, int modulus) {
    if (modulus == 1) return 0;
    int result = 1;
    base = base % modulus;
    _steps.add('Inicio: base = $base, exponente = $exponent, módulo = $modulus');
    
    while (exponent > 0) {
      if (exponent % 2 == 1) {
        result = (result * base) % modulus;
        _steps.add('Exponente impar: multiplicar resultado por base = $result');
      }
      base = (base * base) % modulus;
      _steps.add('Cuadrar base = $base');
      exponent = exponent >> 1;
      _steps.add('Dividir exponente entre 2 = $exponent');
    }
    return result;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final base = int.parse(_baseController.text);
        final exponent = int.parse(_exponentController.text);
        final modulus = int.parse(_modulusController.text);

        _steps.clear();
        final result = _modPow(base, exponent, modulus);

        setState(() {
          _result = '''
Resultado: $result
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
        title: const Text('Exponenciación Rápida'),
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
                'Exponenciación Rápida',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _baseController,
                decoration: AppStyles.textFieldInputDecoration('Base', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una base';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _exponentController,
                decoration: AppStyles.textFieldInputDecoration('Exponente', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un exponente';
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
                        if (_steps.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Text(
                            'Pasos del algoritmo:',
                            style: AppStyles.cardTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          ..._steps.map((step) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(step),
                          )),
                        ],
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
    _baseController.dispose();
    _exponentController.dispose();
    _modulusController.dispose();
    super.dispose();
  }
} 