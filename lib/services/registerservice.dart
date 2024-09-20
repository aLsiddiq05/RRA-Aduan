import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String _url = 'https://sispaa-backend.ilaunch.my/pendaftaran-pelanggan/unsecured';

  Future<Map<String, dynamic>> register({
    required String noKadPengenalan,
    required String nama,
    required String katalaluan,
    required String emel,
    required String noTelBimbit,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'tenantId': 'bpa',
      },
      body: jsonEncode(<String, String>{
        'jenis_pengenalan': 'NRIC', // Fixed value
        'no_kad_pengenalan': noKadPengenalan,
        'nama': nama,
        'katalaluan': katalaluan,
        'emel': emel,
        'no_tel_bimbit': noTelBimbit,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to register. Status code: ${response.statusCode}');
    }
  }
}