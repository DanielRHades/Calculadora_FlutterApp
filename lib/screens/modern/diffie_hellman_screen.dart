import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class DiffieHellmanScreen extends StatefulWidget {
  const DiffieHellmanScreen({super.key});

  @override
  State<DiffieHellmanScreen> createState() => _DiffieHellmanScreenState();
}

class _DiffieHellmanScreenState extends State<DiffieHellmanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pController = TextEditingController();
  final _gController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String _result = '';

  int _modPow(int base, int exponent, int modulus) {
    if (modulus == 1) return 0;
    int result = 1;
    base = base % modulus;
    while (exponent > 0) {
      if (exponent % 2 == 1) {
        result = (result * base) % modulus;
      }
      base = (base * base) % modulus;
      exponent = exponent >> 1;
    }
    return result;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final p = int.parse(_pController.text);
        final g = int.parse(_gController.text);
        final a = int.parse(_aController.text);
        final b = int.parse(_bController.text);

        // Verificar que p sea primo
        bool isPrime = true;
        for (int i = 2; i <= p / 2; i++) {
          if (p % i == 0) {
            isPrime = false;
            break;
          }
        }
        if (!isPrime) {
          throw Exception('p debe ser un número primo');
        }

        // Calcular A = g^a mod p
        final A = _modPow(g, a, p);
        
        // Calcular B = g^b mod p
        final B = _modPow(g, b, p);
        
        // Calcular clave compartida para Alice: B^a mod p
        final keyAlice = _modPow(B, a, p);
        
        // Calcular clave compartida para Bob: A^b mod p
        final keyBob = _modPow(A, b, p);

        setState(() {
          _result = '''
A = $A
B = $B
Clave compartida de Alice: $keyAlice
Clave compartida de Bob: $keyBob
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
        title: const Text('Diffie-Hellman'),
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
                'Diffie-Hellman',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _pController,
                decoration: AppStyles.textFieldInputDecoration('p (número primo)', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor para p';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gController,
                decoration: AppStyles.textFieldInputDecoration('g (generador)', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor para g';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _aController,
                decoration: AppStyles.textFieldInputDecoration('a (clave privada de Alice)', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor para a';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bController,
                decoration: AppStyles.textFieldInputDecoration('b (clave privada de Bob)', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor para b';
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
                child: const Text('Calcular', style: AppStyles.buttonTextStyle),
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
    _pController.dispose();
    _gController.dispose();
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }
} 