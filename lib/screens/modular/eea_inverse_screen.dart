import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class EeaResult {
  final int gcd;
  final int x;
  final int y;
  final List<String> steps;

  EeaResult(this.gcd, this.x, this.y, this.steps);
}

class EeaInverseScreen extends StatefulWidget {
  const EeaInverseScreen({super.key});

  @override
  State<EeaInverseScreen> createState() => _EeaInverseScreenState();
}

class _EeaInverseScreenState extends State<EeaInverseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _nController = TextEditingController();
  String _result = '';
  List<String> _steps = [];

  EeaResult _calculateEea(int a, int b) {
    List<String> steps = [];
    int r0 = a;
    int r1 = b;
    int s0 = 1;
    int s1 = 0;
    int t0 = 0;
    int t1 = 1;
    int round = 1;

    steps.add('Inicio:');
    steps.add('r0 = $r0, s0 = $s0, t0 = $t0');
    steps.add('r1 = $r1, s1 = $s1, t1 = $t1');

    while (r1 != 0) {
      int q = r0 ~/ r1;
      int r2 = r0 - q * r1;
      int s2 = s0 - q * s1;
      int t2 = t0 - q * t1;

      steps.add('\nRonda $round:');
      steps.add('q = $q');
      steps.add('r2 = $r0 - $q * $r1 = $r2');
      steps.add('s2 = $s0 - $q * $s1 = $s2');
      steps.add('t2 = $t0 - $q * $t1 = $t2');

      r0 = r1;
      r1 = r2;
      s0 = s1;
      s1 = s2;
      t0 = t1;
      t1 = t2;
      round++;
    }

    return EeaResult(r0, s0, t0, steps);
  }

  int? _calculateEeaInverse(int a, int n) {
    // Primero verificamos si existe el inverso multiplicativo
    if (a <= 0 || n <= 0) {
      return null;
    }

    final eeaResult = _calculateEea(n, a);
    
    if (eeaResult.gcd != 1) {
      return null;
    }

    // El inverso multiplicativo es t0 mod n
    int inverse = eeaResult.y % n;
    if (inverse < 0) {
      inverse += n;
    }

    setState(() {
      _steps = eeaResult.steps;
    });

    return inverse;
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      try {
        final a = int.parse(_aController.text);
        final n = int.parse(_nController.text);
        
        final inverse = _calculateEeaInverse(a, n);
        
        setState(() {
          if (inverse != null) {
            _result = 'El inverso multiplicativo de $a mod $n es $inverse';
          } else {
            _result = 'No existe inverso multiplicativo para $a mod $n';
          }
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
        title: const Text('Inverso Multiplicativo con AEE'),
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
                'Calcular Inverso Multiplicativo con AEE',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _aController,
                decoration: AppStyles.textFieldInputDecoration('Número a', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nController,
                decoration: AppStyles.textFieldInputDecoration('Módulo n', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  if (int.parse(value) <= 0) {
                    return 'El módulo debe ser positivo';
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
              if (_steps.isNotEmpty) ...[
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pasos del Algoritmo',
                          style: AppStyles.cardTitleStyle,
                        ),
                        const SizedBox(height: 8),
                        ..._steps.map((step) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(step),
                        )),
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
    _aController.dispose();
    _nController.dispose();
    super.dispose();
  }
} 