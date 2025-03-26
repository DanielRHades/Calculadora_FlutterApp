import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class HillScreen extends StatefulWidget {
  const HillScreen({super.key});

  @override
  State<HillScreen> createState() => _HillScreenState();
}

class _HillScreenState extends State<HillScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _keyController = TextEditingController();
  String _result = '';

  // Función para calcular el determinante de una matriz 2x2
  int _determinant(List<List<int>> matrix) {
    return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
  }

  // Función para calcular el inverso multiplicativo módulo 26
  int _modInverse(int a, int m) {
    for (int x = 1; x < m; x++) {
      if (((a % m) * (x % m)) % m == 1) {
        return x;
      }
    }
    return 1;
  }

  // Función para convertir texto a números (A=0, B=1, etc.)
  List<int> _textToNumbers(String text) {
    text = text.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    List<int> numbers = [];
    for (int i = 0; i < text.length; i++) {
      numbers.add(text.codeUnitAt(i) - 65);
    }
    return numbers;
  }

  // Función para convertir números a texto
  String _numbersToText(List<int> numbers) {
    String text = '';
    for (int number in numbers) {
      text += String.fromCharCode(number + 65);
    }
    return text;
  }

  // Función para multiplicar matrices 2x2
  List<List<int>> _matrixMultiply(List<List<int>> a, List<List<int>> b) {
    List<List<int>> result = [
      [0, 0],
      [0, 0]
    ];
    
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        result[i][j] = 0;
        for (int k = 0; k < 2; k++) {
          result[i][j] += a[i][k] * b[k][j];
        }
        result[i][j] %= 26;
      }
    }
    
    return result;
  }

  String _encryptHill(String message, String key) {
    // Convertimos la clave a una matriz 2x2
    List<int> keyNumbers = _textToNumbers(key);
    if (keyNumbers.length != 4) {
      throw Exception('La clave debe tener exactamente 4 letras');
    }
    
    List<List<int>> keyMatrix = [
      [keyNumbers[0], keyNumbers[1]],
      [keyNumbers[2], keyNumbers[3]]
    ];
    
    // Verificamos que la matriz sea invertible
    int det = _determinant(keyMatrix);
    if (det == 0 || det % 2 == 0 || det % 13 == 0) {
      throw Exception('La clave no es válida. El determinante debe ser coprimo con 26.');
    }
    
    // Convertimos el mensaje a números
    List<int> messageNumbers = _textToNumbers(message);
    
    // Si la longitud es impar, agregamos una X
    if (messageNumbers.length % 2 != 0) {
      messageNumbers.add(23); // X = 23
    }
    
    // Ciframos el mensaje
    List<int> encryptedNumbers = [];
    for (int i = 0; i < messageNumbers.length; i += 2) {
      List<List<int>> messageMatrix = [
        [messageNumbers[i]],
        [messageNumbers[i + 1]]
      ];
      
      List<List<int>> result = _matrixMultiply(keyMatrix, messageMatrix);
      encryptedNumbers.add(result[0][0]);
      encryptedNumbers.add(result[1][0]);
    }
    
    return _numbersToText(encryptedNumbers);
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final message = _messageController.text;
        final key = _keyController.text;
        
        final encrypted = _encryptHill(message, key);
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
        title: const Text('Cifrado Hill'),
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
                'Cifrado Hill',
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
                decoration: AppStyles.textFieldInputDecoration('Clave (4 letras)', Icons.key),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una clave';
                  }
                  if (value.length != 4) {
                    return 'La clave debe tener exactamente 4 letras';
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