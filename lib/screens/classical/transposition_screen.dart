import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class TranspositionScreen extends StatefulWidget {
  const TranspositionScreen({super.key});

  @override
  State<TranspositionScreen> createState() => _TranspositionScreenState();
}

class _TranspositionScreenState extends State<TranspositionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  String _encryptTransposition(String message, String key) {
    // Convertimos el mensaje a mayúsculas y eliminamos caracteres no alfabéticos
    message = message.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    
    // Convertimos la clave a números
    List<int> keyNumbers = [];
    for (int i = 0; i < key.length; i++) {
      keyNumbers.add(key.codeUnitAt(i) - 65);
    }
    
    // Creamos la matriz de transposición
    int rows = (message.length / key.length).ceil();
    List<List<String>> matrix = List.generate(rows, (i) => List.filled(key.length, ''));
    
    // Llenamos la matriz con el mensaje
    int messageIndex = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < key.length; j++) {
        if (messageIndex < message.length) {
          matrix[i][j] = message[messageIndex];
          messageIndex++;
        } else {
          matrix[i][j] = 'X'; // Rellenamos con X si es necesario
        }
      }
    }
    
    // Ordenamos las columnas según la clave
    List<int> sortedKey = List.from(keyNumbers)..sort();
    List<int> columnOrder = [];
    for (int i = 0; i < keyNumbers.length; i++) {
      columnOrder.add(sortedKey.indexOf(keyNumbers[i]));
    }
    
    // Leemos el mensaje cifrado por columnas
    String encrypted = '';
    for (int i = 0; i < key.length; i++) {
      int col = columnOrder.indexOf(i);
      for (int row = 0; row < rows; row++) {
        encrypted += matrix[row][col];
      }
    }
    
    return encrypted;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final message = _messageController.text;
        final key = _keyController.text;
        
        final encrypted = _encryptTransposition(message, key);
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
        title: const Text('Cifrado de Transposición'),
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
                'Cifrado de Transposición',
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