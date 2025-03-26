import 'package:flutter/material.dart';
import '../../../styles/app_styles.dart';

class XORInverseScreen extends StatefulWidget {
  const XORInverseScreen({super.key});

  @override
  State<XORInverseScreen> createState() => _XORInverseScreenState();
}

class _XORInverseScreenState extends State<XORInverseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _modulusController = TextEditingController();
  String _result = '';

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final number = int.parse(_numberController.text);
        final modulus = int.parse(_modulusController.text);

        if (modulus <= 0) {
          throw Exception('El módulo debe ser un número positivo');
        }

        // El inverso XOR de un número es el mismo número
        // ya que a XOR a = 0
        final result = number;

        setState(() {
          _result = '''
Número: $number
Módulo: $modulus
Inverso XOR: $result
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
        title: const Text('Inverso XOR'),
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
                'Inverso XOR',
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