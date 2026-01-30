import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operation = '';
  bool _shouldResetDisplay = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_shouldResetDisplay) {
        _display = number;
        _shouldResetDisplay = false;
      } else {
        if (_display == '0') {
          _display = number;
        } else {
          _display += number;
        }
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (_operation.isNotEmpty && !_shouldResetDisplay) {
        _calculate();
      } else {
        _firstNumber = double.parse(_display);
      }
      _operation = operation;
      _shouldResetDisplay = true;
    });
  }

  void _calculate() {
    if (_operation.isEmpty) return;

    _secondNumber = double.parse(_display);
    double result = 0;

    switch (_operation) {
      case '+':
        result = _firstNumber + _secondNumber;
        break;
      case '-':
        result = _firstNumber - _secondNumber;
        break;
      case '×':
        result = _firstNumber * _secondNumber;
        break;
      case '÷':
        if (_secondNumber == 0) {
          _display = 'Error';
          _operation = '';
          _shouldResetDisplay = true;
          return;
        }
        result = _firstNumber / _secondNumber;
        break;
    }

    setState(() {
      _display = result % 1 == 0
          ? result.toInt().toString()
          : result.toString();
      _firstNumber = result;
      _operation = '';
      _shouldResetDisplay = true;
    });
  }

  void _onEqualsPressed() {
    if (_operation.isNotEmpty) {
      _calculate();
    }
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _firstNumber = 0;
      _secondNumber = 0;
      _operation = '';
      _shouldResetDisplay = false;
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.grey[200],
            foregroundColor: textColor ?? Colors.black,
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Text(
                  _display,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Buttons
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Row 1: Clear, ÷, ×
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(
                            text: 'C',
                            onPressed: _onClearPressed,
                            backgroundColor: Colors.grey[400],
                          ),
                          _buildButton(
                            text: '÷',
                            onPressed: () => _onOperationPressed('÷'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '×',
                            onPressed: () => _onOperationPressed('×'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 2: 7, 8, 9, -
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(
                            text: '7',
                            onPressed: () => _onNumberPressed('7'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '8',
                            onPressed: () => _onNumberPressed('8'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '9',
                            onPressed: () => _onNumberPressed('9'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '-',
                            onPressed: () => _onOperationPressed('-'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 3: 4, 5, 6, +
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(
                            text: '4',
                            onPressed: () => _onNumberPressed('4'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '5',
                            onPressed: () => _onNumberPressed('5'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '6',
                            onPressed: () => _onNumberPressed('6'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '+',
                            onPressed: () => _onOperationPressed('+'),
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 4: 1, 2, 3, =
                    Expanded(
                      child: Row(
                        children: [
                          _buildButton(
                            text: '1',
                            onPressed: () => _onNumberPressed('1'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '2',
                            onPressed: () => _onNumberPressed('2'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '3',
                            onPressed: () => _onNumberPressed('3'),
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                          _buildButton(
                            text: '=',
                            onPressed: _onEqualsPressed,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    // Row 5: 0, .
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              child: ElevatedButton(
                                onPressed: () => _onNumberPressed('0'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _buildButton(
                            text: '.',
                            onPressed: _onDecimalPressed,
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
