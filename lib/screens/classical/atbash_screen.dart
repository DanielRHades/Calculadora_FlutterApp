import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class AtbashScreen extends StatefulWidget {
  const AtbashScreen({super.key});

  @override
  State<AtbashScreen> createState() => _AtbashScreenState();
}

class _AtbashScreenState extends State<AtbashScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  String _result = '';

  String _encryptAtbash(String message) {
    // Convertimos el mensaje a mayúsculas
    message = message.toUpperCase();
    
    String encrypted = '';
    for (int i = 0; i < message.length; i++) {
      if (message[i] == ' ') {
        encrypted += ' ';
        continue;
      }
      
      // Convertimos el carácter a su valor ASCII y aplicamos el cifrado ATBASH
      int charCode = message.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) { // Solo procesamos letras
        int shiftedCode = 90 - (charCode - 65); // ATBASH: Z=A, Y=B, X=C, etc.
        encrypted += String.fromCharCode(shiftedCode);
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
        
        final encrypted = _encryptAtbash(message);
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
        title: const Text('Cifrado ATBASH'),
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
                'Cifrado ATBASH',
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
    super.dispose();
  }
} 