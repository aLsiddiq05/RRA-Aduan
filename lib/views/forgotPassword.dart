import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _isLoading = false;
  String _selectedOption = 'user';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    _controllers['ID Pengguna'] = TextEditingController();
    _controllers['No. Telefon Bimbit'] = TextEditingController();
    _controllers['E-mel'] = TextEditingController();
  }

  void _clearUnusedFields() {
    _controllers.forEach((label, controller) {
      if ((_selectedOption == 'user' && label != 'ID Pengguna') ||
          (_selectedOption == 'phone' &&
              (label != 'ID Pengguna' && label != 'No. Telefon Bimbit')) ||
          (_selectedOption == 'email' && label != 'E-mel')) {
        controller.clear();
      }
    });
    // Manually reset form state for unused fields to remove error messages
    _formKey.currentState?.reset();
  }

  BoxDecoration _customBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  InputDecoration _customInputDecoration({
    required String label,
    required Icon prefixIcon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colors.transparent,
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }

  Widget _buildTextField({
    required String label,
    required Icon icon,
    bool isNumber = false,
    bool isEmail = false,
  }) {
    TextInputType keyboardType = isNumber
        ? TextInputType.number
        : isEmail
            ? TextInputType.emailAddress
            : TextInputType.text;
    List<TextInputFormatter>? inputFormatters =
        isNumber ? [FilteringTextInputFormatter.digitsOnly] : null;

    TextEditingController controller = _controllers[label]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(15.0),
        dashPattern: const [5, 3],
        color: Colors.grey,
        child: Container(
          width: 350,
          decoration: _customBoxDecoration(),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: _customInputDecoration(
              label: label,
              prefixIcon: icon,
            ),
            onChanged: (_) {
              setState(() {
                _formKey.currentState?.validate();
              });
            },
            validator: (value) {
              if (_selectedOption == 'user' && label == 'ID Pengguna') {
                if (value == null || value.isEmpty) {
                  return 'Sila masukkan $label';
                }
              } else if (_selectedOption == 'phone' &&
                  (label == 'ID Pengguna' || label == 'No. Telefon Bimbit')) {
                if (value == null || value.isEmpty) {
                  return 'Sila masukkan $label';
                }
              } else if (_selectedOption == 'email' && label == 'E-mel') {
                if (value == null || value.isEmpty) {
                  return 'Sila masukkan $label';
                }
                if (isEmail &&
                    !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Format e-mel tidak sah';
                }
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(String title, String value) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.blue[900]),
      ),
      value: value,
      groupValue: _selectedOption,
      onChanged: (newValue) {
        setState(() {
          _selectedOption = newValue!;
          _clearUnusedFields(); // Reset fields not relevant to the new selection
        });
      },
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Maklumat dihantar untuk penetapan semula kata laluan'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Kata Laluan'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sila pilih jenis penetapan kata laluan:',
                  style: TextStyle(fontSize: 18, color: Colors.blue[900]),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    _buildRadioTile('ID Pengguna', 'user'),
                    _buildRadioTile('No. Telefon Bimbit', 'phone'),
                    _buildRadioTile('E-mel', 'email'),
                  ],
                ),
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildUserInputFields(),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Hantar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildUserInputFields() {
    List<Widget> fields = [];

    switch (_selectedOption) {
      case 'user':
        fields.add(
          _buildTextField(
            label: 'ID Pengguna',
            icon: const Icon(Icons.person),
            isNumber: true,
          ),
        );
        break;
      case 'phone':
        fields.add(
          _buildTextField(
            label: 'ID Pengguna',
            icon: const Icon(Icons.person),
            isNumber: true,
          ),
        );
        fields.add(const SizedBox(height: 20));
        fields.add(
          _buildTextField(
            label: 'No. Telefon Bimbit',
            icon: const Icon(Icons.phone),
            isNumber: true,
          ),
        );
        break;
      case 'email':
        fields.add(
          _buildTextField(
            label: 'E-mel',
            icon: const Icon(Icons.email),
            isEmail: true,
          ),
        );
        break;
    }

    return fields;
  }
}
