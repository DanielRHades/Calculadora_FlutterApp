import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class VernamScreen extends StatefulWidget {
  const VernamScreen({super.key});

  @override
  State<VernamScreen> createState() => _VernamScreenState();
}

class _VernamScreenState extends State<VernamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  String _encryptVernam(String message, String key) {
    // Convertimos el mensaje y la clave a mayúsculas
    message = message.toUpperCase();
    key = key.toUpperCase();
    
    // Eliminamos caracteres no alfabéticos de la clave
    key = key.replaceAll(RegExp(r'[^A-Z]'), '');
    
    // Si la clave está vacía, usamos 'A' como clave por defecto
    if (key.isEmpty) key = 'A';
    
    // Repetimos la clave hasta que tenga la misma longitud que el mensaje
    while (key.length < message.length) {
      key += key;
    }
    key = key.substring(0, message.length);
    
    String encrypted = '';
    for (int i = 0; i < message.length; i++) {
      if (message[i] == ' ') {
        encrypted += ' ';
        continue;
      }
      
      // Convertimos los caracteres a valores numéricos (A=0, B=1, etc.)
      int messageValue = message.codeUnitAt(i) - 65;
      int keyValue = key[i].codeUnitAt(0) - 65;
      
      // Aplicamos el cifrado Vernam (XOR): (messageValue + keyValue) mod 26
      int encryptedValue = (messageValue + keyValue) % 26;
      
      // Convertimos de vuelta a carácter
      encrypted += String.fromCharCode(encryptedValue + 65);
    }
    
    return encrypted;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final message = _messageController.text;
        final key = _keyController.text;
        
        final encrypted = _encryptVernam(message, key);
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
        title: const Text('Cifrado Vernam'),
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
                'Cifrado Vernam',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una clave';
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