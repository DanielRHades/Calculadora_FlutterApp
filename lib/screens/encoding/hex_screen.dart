import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class HexScreen extends StatefulWidget {
  const HexScreen({super.key});

  @override
  State<HexScreen> createState() => _HexScreenState();
}

class _HexScreenState extends State<HexScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _result = '';

  String _encodeToHex(String text) {
    String hex = '';
    for (int i = 0; i < text.length; i++) {
      hex += text.codeUnitAt(i).toRadixString(16).padLeft(2, '0').toUpperCase() + ' ';
    }
    return hex.trim();
  }

  String _decodeFromHex(String hex) {
    try {
      // Eliminar espacios y verificar que solo contenga caracteres hexadecimales
      hex = hex.replaceAll(' ', '');
      if (!RegExp(r'^[0-9A-Fa-f]+$').hasMatch(hex)) {
        throw Exception('El texto hexadecimal solo debe contener caracteres 0-9 y A-F');
      }

      // Verificar que la longitud sea par
      if (hex.length % 2 != 0) {
        throw Exception('El texto hexadecimal debe tener una longitud par');
      }

      String text = '';
      for (int i = 0; i < hex.length; i += 2) {
        String byte = hex.substring(i, i + 2);
        text += String.fromCharCode(int.parse(byte, radix: 16));
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
        final hex = _encodeToHex(text);

        setState(() {
          _result = '''
Texto original: $text
Texto hexadecimal: $hex
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
        final hex = _textController.text;
        final text = _decodeFromHex(hex);

        setState(() {
          _result = '''
Texto hexadecimal: $hex
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
        title: const Text('Codificación Hexadecimal'),
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
                'Codificación Hexadecimal',
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