import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rra_mobile/services/aduanDetailService.dart';

class AduanDetailReceipt extends StatefulWidget {
  final String aduanId;

  const AduanDetailReceipt({Key? key, required this.aduanId}) : super(key: key);

  @override
  _AduanDetailReceiptState createState() => _AduanDetailReceiptState();
}

class _AduanDetailReceiptState extends State<AduanDetailReceipt> {
  Map<String, dynamic>? aduan;
  bool isLoading = true;
  late AduanDetailService aduanDetailService;

  @override
  void initState() {
    super.initState();
    aduanDetailService = AduanDetailService();
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
        Navigator.of(context).pop(); 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Aduan has been cancelled.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to cancel Aduan.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: _getStatusColor(aduan?['status']),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Aduan Details',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Divider(thickness: 2, color: Colors.black),
                  SizedBox(height: 8),
                  Text(
                    'Aduan Title:',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    aduan?['title'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aduan Content:',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    aduan?['content'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Conditional display for Pegawai Name and Hasil
                  if (aduan?['status'] == 3) ...[
                    Text(
                      'Pegawai Name:',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      aduan?['pegawaiName'] ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Hasil:',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      aduan?['hasil'] ?? 'N/A',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                  SizedBox(height: 8),
                  Divider(thickness: 2, color: Colors.black),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status:',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _getStatusLabel(aduan?['status']),
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Created At:',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    _formatCreatedAt(aduan?['created_at']),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Show Batal Aduan button if status is Terima (1) or Dalam Siasatan (2)
                  if (_shouldShowBatalAduanButton(aduan?['status']))
                    Center(
                      child: ElevatedButton(
                        onPressed: _cancelAduan,
                        child: Text('Batal Aduan'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent, 
                        ),
                      ),
                    )
                  else
                    Center(
                      child: Text(
                        'Thank You!',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  SizedBox(height: 8),
                  Divider(thickness: 2, color: Colors.black),
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

  // Condition to show the Batal Aduan button
  bool _shouldShowBatalAduanButton(int? status) {
    return status == 1 || status == 2;
  }
}
