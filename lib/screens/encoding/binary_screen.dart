import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class BinaryScreen extends StatefulWidget {
  const BinaryScreen({super.key});

  @override
  State<BinaryScreen> createState() => _BinaryScreenState();
}

class _BinaryScreenState extends State<BinaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _result = '';

  String _encodeToBinary(String text) {
    String binary = '';
    for (int i = 0; i < text.length; i++) {
      binary += text.codeUnitAt(i).toRadixString(2).padLeft(8, '0') + ' ';
    }
    return binary.trim();
  }

  String _decodeFromBinary(String binary) {
    try {
      // Eliminar espacios y verificar que solo contenga 0s y 1s
      binary = binary.replaceAll(' ', '');
      if (!RegExp(r'^[01]+$').hasMatch(binary)) {
        throw Exception('El texto binario solo debe contener 0s y 1s');
      }

      // Verificar que la longitud sea múltiplo de 8
      if (binary.length % 8 != 0) {
        throw Exception('El texto binario debe tener una longitud múltiplo de 8');
      }

      String text = '';
      for (int i = 0; i < binary.length; i += 8) {
        String byte = binary.substring(i, i + 8);
        text += String.fromCharCode(int.parse(byte, radix: 2));
      }
      return text;
    } catch (e) {
      throw Exception('Error al decodificar: ${e.toString()}');
    }
  }

  void _encode() {
    if (_formKey.currentState!.validate()) {
      try {
        final text = _textController.text;
        final binary = _encodeToBinary(text);

        setState(() {
          _result = '''
Texto original: $text
Texto binario: $binary
''';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  void _decode() {
    if (_formKey.currentState!.validate()) {
      try {
        final binary = _textController.text;
        final text = _decodeFromBinary(binary);

        setState(() {
          _result = '''
Texto binario: $binary
Texto decodificado: $text
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
        title: const Text('Codificación Binaria'),
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
                'Codificación Binaria',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _textController,
                decoration: AppStyles.textFieldInputDecoration('Texto', Icons.message),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un texto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _encode,
                      style: AppStyles.elevatedButtonStyle,
                      child: const Text('Codificar', style: AppStyles.buttonTextStyle),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _decode,
                      style: AppStyles.elevatedButtonStyle,
                      child: const Text('Decodificar', style: AppStyles.buttonTextStyle),
                    ),
                  ),
                ],
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
    _textController.dispose();
    super.dispose();
  }
} 