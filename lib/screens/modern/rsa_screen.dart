import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class RSAScreen extends StatefulWidget {
  const RSAScreen({super.key});

  @override
  State<RSAScreen> createState() => _RSAScreenState();
}

class _RSAScreenState extends State<RSAScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pController = TextEditingController();
  final _qController = TextEditingController();
  final _eController = TextEditingController();
  final _messageController = TextEditingController();
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

  int _gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  int _modInverse(int a, int m) {
    int m0 = m;
    int y = 0, x = 1;
    if (m == 1) return 0;
    while (a > 1) {
      int q = a ~/ m;
      int t = m;
      m = a % m;
      a = t;
      t = y;
      y = x - q * y;
      x = t;
    }
    if (x < 0) x += m0;
    return x;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final p = int.parse(_pController.text);
        final q = int.parse(_qController.text);
        final e = int.parse(_eController.text);
        final message = int.parse(_messageController.text);

        // Verificar que p y q sean primos
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

        isPrime = true;
        for (int i = 2; i <= q / 2; i++) {
          if (q % i == 0) {
            isPrime = false;
            break;
          }
        }
        if (!isPrime) {
          throw Exception('q debe ser un número primo');
        }

        // Calcular n = p * q
        final n = p * q;

        // Calcular φ(n) = (p-1)(q-1)
        final phi = (p - 1) * (q - 1);

        // Verificar que e sea coprimo con φ(n)
        if (_gcd(e, phi) != 1) {
          throw Exception('e debe ser coprimo con φ(n)');
        }

        // Calcular d = e^(-1) mod φ(n)
        final d = _modInverse(e, phi);

        // Cifrar: c = m^e mod n
        final encrypted = _modPow(message, e, n);

        // Descifrar: m = c^d mod n
        final decrypted = _modPow(encrypted, d, n);

        setState(() {
          _result = '''
n = $n
φ(n) = $phi
d = $d
Mensaje cifrado: $encrypted
Mensaje descifrado: $decrypted
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
        title: const Text('RSA'),
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
                'RSA',
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
                controller: _qController,
                decoration: AppStyles.textFieldInputDecoration('q (número primo)', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor para q';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _eController,
                decoration: AppStyles.textFieldInputDecoration('e (exponente público)', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un valor para e';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: AppStyles.textFieldInputDecoration('Mensaje (número)', Icons.message),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un mensaje';
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
    _qController.dispose();
    _eController.dispose();
    _messageController.dispose();
    super.dispose();
  }
} 