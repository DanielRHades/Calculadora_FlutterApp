import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class AffineScreen extends StatefulWidget {
  const AffineScreen({super.key});

  @override
  State<AffineScreen> createState() => _AffineScreenState();
}

class _AffineScreenState extends State<AffineScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String _result = '';

  int _calculateGCD(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  String _encryptAffine(String message, int a, int b) {
    // Verificamos que a y 26 sean coprimos
    if (_calculateGCD(a, 26) != 1) {
      throw Exception('El valor de a debe ser coprimo con 26');
    }

    // Convertimos el mensaje a mayúsculas
    message = message.toUpperCase();
    
    String encrypted = '';
    for (int i = 0; i < message.length; i++) {
      if (message[i] == ' ') {
        encrypted += ' ';
        continue;
      }
      
      // Convertimos el carácter a su valor ASCII y aplicamos el cifrado afín
      int charCode = message.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) { // Solo procesamos letras
        int x = charCode - 65; // Convertimos a 0-25
        int y = (a * x + b) % 26; // Fórmula del cifrado afín: y = (ax + b) mod 26
        encrypted += String.fromCharCode(y + 65); // Convertimos de vuelta a letra
      } else {
        encrypted += message[i]; // Mantenemos caracteres no alfabéticos sin cambios
      }
    }
    
    return encrypted;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final message = _messageController.text;
        final a = int.parse(_aController.text);
        final b = int.parse(_bController.text);
        
        final encrypted = _encryptAffine(message, a, b);
        setState(() {
          _result = 'Mensaje cifrado: $encrypted';
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
        title: const Text('Cifrado Afín'),
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
                'Cifrado Afín',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageController,
                decoration: AppStyles.textFieldInputDecoration('Mensaje', Icons.message),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un mensaje';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _aController,
                decoration: AppStyles.textFieldInputDecoration('Valor de a', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el valor de a';
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
                decoration: AppStyles.textFieldInputDecoration('Valor de b', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el valor de b';
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
                child: const Text('Cifrar', style: AppStyles.buttonTextStyle),
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
    _messageController.dispose();
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }
} 