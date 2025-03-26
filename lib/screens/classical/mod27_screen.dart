import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class Mod27Screen extends StatefulWidget {
  const Mod27Screen({super.key});

  @override
  State<Mod27Screen> createState() => _Mod27ScreenState();
}

class _Mod27ScreenState extends State<Mod27Screen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  String _encryptMod27(String message, int key) {
    // Convertimos el mensaje a mayúsculas
    message = message.toUpperCase();
    
    // Convertimos cada carácter a su valor numérico (A=0, B=1, ..., Z=25, espacio=26)
    // y aplicamos el cifrado módulo 27
    String encrypted = '';
    for (int i = 0; i < message.length; i++) {
      int charValue;
      if (message[i] == ' ') {
        charValue = 26; // Espacio
      } else {
        charValue = message.codeUnitAt(i) - 65; // A=0, B=1, etc.
      }
      
      // Aplicamos el cifrado: (charValue + key) mod 27
      int encryptedValue = (charValue + key) % 27;
      
      // Convertimos de vuelta a carácter
      if (encryptedValue == 26) {
        encrypted += ' ';
      } else {
        encrypted += String.fromCharCode(encryptedValue + 65);
      }
    }
    
    return encrypted;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final message = _messageController.text;
        final key = int.parse(_keyController.text);
        
        final encrypted = _encryptMod27(message, key);
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
        title: const Text('Cifrado Módulo 27'),
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
                'Cifrado Módulo 27',
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
                controller: _keyController,
                decoration: AppStyles.textFieldInputDecoration('Clave', Icons.key),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una clave';
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
    _keyController.dispose();
    super.dispose();
  }
} 