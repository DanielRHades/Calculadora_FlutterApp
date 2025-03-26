import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';
import 'dart:convert';

class Base64Screen extends StatefulWidget {
  const Base64Screen({super.key});

  @override
  State<Base64Screen> createState() => _Base64ScreenState();
}

class _Base64ScreenState extends State<Base64Screen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _result = '';

  String _encodeToBase64(String text) {
    try {
      final bytes = utf8.encode(text);
      return base64.encode(bytes);
    } catch (e) {
      throw Exception('Error al codificar: ${e.toString()}');
    }
  }

  String _decodeFromBase64(String base64Text) {
    try {
      // Verificar que el texto sea válido en Base64
      if (!RegExp(r'^[A-Za-z0-9+/]*={0,2}$').hasMatch(base64Text)) {
        throw Exception('El texto no es válido en Base64');
      }

      final bytes = base64.decode(base64Text);
      return utf8.decode(bytes);
    } catch (e) {
      throw Exception('Error al decodificar: ${e.toString()}');
    }
  }

  void _encode() {
    if (_formKey.currentState!.validate()) {
      try {
        final text = _textController.text;
        final base64Text = _encodeToBase64(text);

        setState(() {
          _result = '''
Texto original: $text
Texto Base64: $base64Text
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
        final base64Text = _textController.text;
        final text = _decodeFromBase64(base64Text);

        setState(() {
          _result = '''
Texto Base64: $base64Text
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
        title: const Text('Codificación Base64'),
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
                'Codificación Base64',
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