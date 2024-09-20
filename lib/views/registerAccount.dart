import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:rra_mobile/services/registerservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Data class to represent a form field
class FormFieldData {
  final String label;
  final Icon icon;
  final bool isNumber;
  final bool isPassword;

  FormFieldData({
    required this.label,
    required this.icon,
    this.isNumber = false,
    this.isPassword = false,
  });
}

class RegisterAccountPage extends StatefulWidget {
  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

// List of form fields to be displayed
  final List<FormFieldData> _fields = [
    FormFieldData(
        label: 'No. Kad Pengenalan',
        icon: const Icon(FontAwesomeIcons.idCard),
        isNumber: true),
    FormFieldData(label: 'Nama', icon: const Icon(Icons.person)),
    FormFieldData(
        label: 'No. Telefon Bimbit', icon: const Icon(Icons.phone), isNumber: true),
    FormFieldData(label: 'E-mel', icon: const Icon(Icons.email)),
    FormFieldData(label: 'ID Pengguna', icon: const Icon(Icons.person)),
    FormFieldData(
        label: 'Kata Laluan', icon: const Icon(Icons.lock), isPassword: true),
    FormFieldData(
        label: 'Pastikan Kata Laluan',
        icon: const Icon(Icons.lock),
        isPassword: true),
  ];

  @override
  void initState() {
    super.initState();
    _fields.forEach((field) {
      _controllers[field.label] = TextEditingController();
      _controllers[field.label]!.addListener(() {
        if (_formKey.currentState?.validate() ?? false) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    // Dispose all controllers when the widget is removed
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  // Custom box decoration for the form fields
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

  // Custom input decoration for the form fields
  InputDecoration _customInputDecoration({
    required String label,
    required Icon prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.transparent,
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final service = RegisterService();
        await service.register(
          noKadPengenalan: _controllers['No. Kad Pengenalan']!.text,
          nama: _controllers['Nama']!.text,
          katalaluan: _controllers['Kata Laluan']!.text,
          emel: _controllers['E-mel']!.text,
          noTelBimbit: _controllers['No. Telefon Bimbit']!.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akaun berjaya didaftar')),
        );
        Navigator.pushReplacementNamed(
          context, '/login'
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pendaftaran gagal: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


// Method to build each text field
  Widget _buildTextField(FormFieldData field) {
    final isPassword = field.isPassword; // Check if the field is for password
    final controller =
        _controllers[field.label]!; // Get the controller for the field
    TextInputType keyboardType = TextInputType.text; // Default keyboardType
    List<TextInputFormatter>? inputFormatters;

    // Set keyboardType and inputFormatters based on field type
    if (field.isNumber) {
      keyboardType = TextInputType.number;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    } else if (field.label == 'Nama') {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
        FilteringTextInputFormatter.singleLineFormatter,
      ];
    }

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
            obscureText: isPassword &&
                !(field.label.contains('Pastikan')
                    ? _isConfirmPasswordVisible
                    : _isPasswordVisible),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: _customInputDecoration(
              label: field.label,
              prefixIcon: field.icon,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        field.label.contains('Pastikan')
                            ? (_isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility)
                            : (_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                      ),
                      onPressed: () {
                        setState(() {
                          if (field.label.contains('Pastikan')) {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          } else {
                            _isPasswordVisible = !_isPasswordVisible;
                          }
                        });
                      },
                    )
                  : null,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Sila masukkan ${field.label.toLowerCase()}';
              }
              if (field.label == 'E-mel' &&
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Format e-mel tidak sah';
              }
              if (field.label == 'Pastikan Kata Laluan' &&
                  value != _controllers['Kata Laluan']!.text) {
                return 'Kata laluan tidak sepadan';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  // Method to build section headers
  Widget _buildSectionHeader(String title) {
    return Container(
      color: Colors.blueGrey[50],
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.blue[900],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran Pengguna Baru'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // Enable auto-validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sila masukkan maklumat berikut untuk pendaftaran akaun baru:',
                  style: TextStyle(fontSize: 16, color: Colors.blue[900]),
                ),
                const SizedBox(height: 20),
                _buildSectionHeader('Profil'),
                const SizedBox(height: 20),
                ..._fields
                    .sublist(0, 4)
                    .map((field) => _buildTextField(field))
                    .toList(),
                const SizedBox(height: 20),
                _buildSectionHeader('Maklumat Log Masuk'),
                const SizedBox(height: 20),
                ..._fields
                    .sublist(4)
                    .map((field) => _buildTextField(field))
                    .toList(),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : _register, // Disable button if loading
                    child: _isLoading
                        ? const CircularProgressIndicator() // Show progress indicator if loading
                        : const Text('Daftar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
