import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class TraditionalInverseScreen extends StatefulWidget {
  const TraditionalInverseScreen({super.key});

  @override
  State<TraditionalInverseScreen> createState() => _TraditionalInverseScreenState();
}

class _TraditionalInverseScreenState extends State<TraditionalInverseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _nController = TextEditingController();
  String _result = '';

  int _calculateGcd(int a, int b) {
    // Implementación manual del algoritmo de Euclides para calcular el MCD
    a = a.abs();
    b = b.abs();
    
    if (b == 0) {
      return a;
    }
    
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    
    return a;
  }

  int? _calculateTraditionalInverse(int a, int n) {
    // Primero verificamos si existe el inverso multiplicativo
    if (_calculateGcd(a, n) != 1) {
      return null;
    }
    
    // Buscamos el inverso multiplicativo por fuerza bruta
    for (int i = 1; i < n; i++) {
      if ((a * i) % n == 1) {
        return i;
      }
    }
    
    return null;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final a = int.parse(_aController.text);
        final n = int.parse(_nController.text);
        
        final inverse = _calculateTraditionalInverse(a, n);
        
        setState(() {
          if (inverse != null) {
            _result = 'El inverso multiplicativo de $a mod $n es $inverse';
          } else {
            _result = 'No existe inverso multiplicativo para $a mod $n';
          }
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
        title: const Text('Inverso Multiplicativo Tradicional'),
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
                'Calcular Inverso Multiplicativo Tradicional',
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
                controller: _nController,
                decoration: AppStyles.textFieldInputDecoration('Módulo n', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  if (int.parse(value) <= 0) {
                    return 'El módulo debe ser positivo';
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
    _nController.dispose();
    super.dispose();
  }
} 