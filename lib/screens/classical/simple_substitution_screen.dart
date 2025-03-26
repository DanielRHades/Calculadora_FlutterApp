import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class SimpleSubstitutionScreen extends StatefulWidget {
  const SimpleSubstitutionScreen({super.key});

  @override
  State<SimpleSubstitutionScreen> createState() => _SimpleSubstitutionScreenState();
}

class _SimpleSubstitutionScreenState extends State<SimpleSubstitutionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  String _encryptSimpleSubstitution(String message, String key) {
    // Convertimos el mensaje a mayúsculas y eliminamos caracteres no alfabéticos
    message = message.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    
    // Convertimos la clave a mayúsculas y eliminamos caracteres no alfabéticos
    key = key.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    
    // Verificamos que la clave tenga 26 caracteres
    if (key.length != 26) {
      throw Exception('La clave debe tener exactamente 26 letras');
    }
    
    // Verificamos que la clave contenga todas las letras del alfabeto
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    for (int i = 0; i < alphabet.length; i++) {
      if (!key.contains(alphabet[i])) {
        throw Exception('La clave debe contener todas las letras del alfabeto');
      }
    }
    
    // Creamos el mapa de sustitución
    Map<String, String> substitutionMap = {};
    for (int i = 0; i < alphabet.length; i++) {
      substitutionMap[alphabet[i]] = key[i];
    }
    
    // Aplicamos la sustitución
    String encrypted = '';
    for (int i = 0; i < message.length; i++) {
      encrypted += substitutionMap[message[i]]!;
    }
    
    return encrypted;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final message = _messageController.text;
        final key = _keyController.text;
        
        final encrypted = _encryptSimpleSubstitution(message, key);
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
        title: const Text('Cifrado de Sustitución Simple'),
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
                'Cifrado de Sustitución Simple',
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
                decoration: AppStyles.textFieldInputDecoration('Clave (26 letras)', Icons.key),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una clave';
                  }
                  if (value.length != 26) {
                    return 'La clave debe tener exactamente 26 letras';
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