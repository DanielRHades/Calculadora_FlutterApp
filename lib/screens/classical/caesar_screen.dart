import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class CaesarScreen extends StatefulWidget {
  const CaesarScreen({super.key});

  @override
  State<CaesarScreen> createState() => _CaesarScreenState();
}

class _CaesarScreenState extends State<CaesarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _shiftController = TextEditingController();
  String _result = '';

  String _encryptCaesar(String message, int shift) {
    // Convertimos el mensaje a mayúsculas
    message = message.toUpperCase();
    
    // Normalizamos el desplazamiento a un valor entre 0 y 25
    shift = shift % 26;
    if (shift < 0) shift += 26;
    
    String encrypted = '';
    for (int i = 0; i < message.length; i++) {
      if (message[i] == ' ') {
        encrypted += ' ';
        continue;
      }
      
      // Convertimos el carácter a su valor ASCII y aplicamos el desplazamiento
      int charCode = message.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) { // Solo procesamos letras
        int shiftedCode = charCode + shift;
        if (shiftedCode > 90) {
          shiftedCode -= 26;
        }
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
        final shift = int.parse(_shiftController.text);
        
        final encrypted = _encryptCaesar(message, shift);
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
        title: const Text('Cifrado César'),
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
                'Cifrado César',
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
                controller: _shiftController,
                decoration: AppStyles.textFieldInputDecoration('Desplazamiento', Icons.arrow_forward),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un desplazamiento';
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
    _shiftController.dispose();
    super.dispose();
  }
} 