import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rra_mobile/services/aduanDetailService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import for FlutterSecureStorage

class AduanDetailReceipt extends StatefulWidget {
  final String aduanId;
  final VoidCallback onAduanCanceled;

  const AduanDetailReceipt({
    Key? key,
    required this.aduanId,
    required this.onAduanCanceled,
  }) : super(key: key);

  @override
  _AduanDetailReceiptState createState() => _AduanDetailReceiptState();
}

class _AduanDetailReceiptState extends State<AduanDetailReceipt> {
  Map<String, dynamic>? aduan;
  bool isLoading = true;
  late AduanDetailService aduanDetailService;
  String? roleId; // Role ID to control button display logic
  final storage = const FlutterSecureStorage(); // Secure storage instance
  final TextEditingController hasilController = TextEditingController();

  @override
  void initState() {
    super.initState();
    aduanDetailService = AduanDetailService();
    _fetchRoleAndAduanDetails();
  }

  Future<void> _fetchRoleAndAduanDetails() async {
    // Fetch the roleId from storage and then the aduan details
    roleId = await storage.read(key: 'roleId');
    _fetchAduanDetail();
  }

  Future<void> _fetchAduanDetail() async {
    setState(() {
      isLoading = true;
    });

    final fetchedAduan =
        await aduanDetailService.fetchAduanDetail(widget.aduanId);

    setState(() {
      aduan = fetchedAduan;
      isLoading = false;
    });
  }

  void _cancelAduan() {
    aduanDetailService.cancelAduan(widget.aduanId).then((success) {
      if (success) {
        widget.onAduanCanceled();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aduan has been cancelled.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to cancel Aduan.')),
        );
      }
    });
  }

  void _terimaAduan() {
    aduanDetailService.terimaAduan(widget.aduanId).then((success) {
      if (success) {
        widget.onAduanCanceled();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terima Aduan.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aduan tidak boleh diterima.')),
        );
      }
    });
  }

  void _selesaikanAduan() {
    final hasil = hasilController.text;
    if (hasil.isNotEmpty) {
      aduanDetailService.selesaikanAduan(widget.aduanId, hasil).then((success) {
        if (success) {
          widget.onAduanCanceled();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aduan has been completed.')),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to complete Aduan.')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan Hasil.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: _getStatusColor(aduan?['status']),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Aduan Details',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const Divider(thickness: 2, color: Colors.black),
                  const SizedBox(height: 8),
                  const Text(
                    'Aduan Title:',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    aduan?['title'] ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aduan Content:',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    aduan?['content'] ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (aduan?['status'] == 3) ...[
                    const Text(
                      'Pegawai Name:',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      aduan?['pegawaiName'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Hasil:',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      aduan?['hasil'] ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  const SizedBox(height: 8),
                  const Divider(thickness: 2, color: Colors.black),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Status:',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _getStatusLabel(aduan?['status']),
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Created At:',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _formatCreatedAt(aduan?['created_at']),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        if (_shouldShowCancelButton(aduan?['status']) ||
                            _shouldShowTerimaButton(aduan?['status']) ||
                            _shouldShowSelesaikanOption(aduan?['status']))
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (_shouldShowCancelButton(aduan?['status']))
                                    ElevatedButton(
                                      onPressed: _cancelAduan,
                                      child: const Text('Batal Aduan'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    ),
                                  if (_shouldShowTerimaButton(aduan?['status']))
                                    ElevatedButton(
                                      onPressed: _terimaAduan,
                                      child: const Text('Terima Aduan'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                    ),
                                ],
                              ),
                              if (_shouldShowSelesaikanOption(aduan?['status']))
                                Column(
                                  children: [
                                    TextField(
                                      controller: hasilController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: const InputDecoration(
                                        labelText: 'Hasil',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: _selesaikanAduan,
                                      child: const Text('Selesaikan'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.lightBlue[100],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        else
                          const Center(
                            child: Text(
                              'Thank You!',
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(thickness: 2, color: Colors.black),
                ],
              ),
            ),
    );
  }

  String _formatCreatedAt(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }

  Color _getStatusColor(int? status) {
    switch (status) {
      case 1:
        return Colors.grey;
      case 2:
        return Colors.blueAccent;
      case 3:
        return Colors.greenAccent;
      case 4:
        return Colors.redAccent;
      default:
        return Colors.white;
    }
  }

  String _getStatusLabel(int? status) {
    switch (status) {
      case 1:
        return 'Terima';
      case 2:
        return 'Dalam Siasatan';
      case 3:
        return 'Selesai';
      case 4:
        return 'Batal / Tolak';
      default:
        return 'Unknown';
    }
  }

  bool _shouldShowCancelButton(int? status) {
    // Show Cancel button for Pengadu (roleId == '3') and Pegawai (roleId == '2') based on the status
    return (roleId == '3' && (status == 1 || status == 2)) ||
        (roleId == '2' && status == 1);
  }

  bool _shouldShowSelesaikanOption(int? status) {
    if (roleId == '2' && status == 2) {
      return true;
    }
    return false;
  }

  bool _shouldShowTerimaButton(int? status) {
    // Show Terima button only for Pegawai (roleId == '2') when status == 1
    return roleId == '2' && status == 1;
  }
}
