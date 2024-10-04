import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rra_mobile/services/aduanListService.dart';
import 'package:rra_mobile/widget/aduanDetailReceipt.dart';
import 'package:rra_mobile/widget/customappbar.dart';

class AduanListPage extends StatefulWidget {
  const AduanListPage({Key? key}) : super(key: key);

  @override
  _AduanListPageState createState() => _AduanListPageState();
}

class _AduanListPageState extends State<AduanListPage> {
  final AduanListService aduanService = AduanListService();
  int currentPage = 1;
  int totalPages = 1;
  final int pageSize = 4;
  List aduanList = [];
  bool isLoading = false;
  bool showPaginationBox =
      false; // State variable to control pagination box visibility

  @override
  void initState() {
    super.initState();
    fetchAduans();
  }

  Future<void> fetchAduans() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await aduanService.fetchAduanList(currentPage, pageSize);
      setState(() {
        aduanList = response['aduanList'];
        totalPages = response['totalPages'];

        print(aduanList);
      });
    } catch (e) {
      print("Error fetching aduan list: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void changePage(int page) {
    if (page >= 1 && page <= totalPages && !isLoading) {
      setState(() {
        currentPage = page;
        fetchAduans();
      });
    }
  }

  String getAduanStatus(int status) {
    switch (status) {
      case 1:
        return 'Terima';
      case 2:
        return 'Dalam Siasatan';
      case 3:
        return 'Selesai';
      case 4:
        return 'Batal';
      default:
        return 'Unknown';
    }
  }

  Color getBadgeColor(int status) {
    switch (status) {
      case 1:
        return Colors.grey;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Aduan Pengguna',
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: aduanList.length,
                      itemBuilder: (context, index) {
                        final aduan = aduanList[index];
                        return GestureDetector(
                          onTap: () async {
                            if (aduan.containsKey('id')) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AduanDetailReceipt(
                                    aduanId: aduan['id'].toString(),
                                    onAduanCanceled: fetchAduans,
                                  );
                                },
                              );
                            } else {
                              print("Aduan id is missing");
                              // Optionally show a message to the user
                            }
                          },
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    aduan['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    aduan['content'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Chip(
                                        label: Text(
                                            getAduanStatus(aduan['status'])),
                                        backgroundColor:
                                            getBadgeColor(aduan['status']),
                                      ),
                                      Text(
                                        _formatCreatedAt(aduan['created_at']),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            _buildPaginationIndicator(),
            if (showPaginationBox)
              _buildPaginationBox(), // Show pagination box conditionally
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            changePage(currentPage - 1);
          },
          tooltip: 'Previous',
        ),
        Text('Page $currentPage of $totalPages'),
        TextButton(
          onPressed: () {
            setState(() {
              showPaginationBox =
                  !showPaginationBox; // Toggle pagination box visibility
            });
          },
          child: const Text('...'), // Indicator button
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            changePage(currentPage + 1);
          },
          tooltip: 'Next',
        ),
      ],
    );
  }

  Widget _buildPaginationBox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 8.0, // Space between items
        alignment: WrapAlignment.center,
        children: List.generate(totalPages, (index) {
          return GestureDetector(
            onTap: () {
              changePage(index + 1);
            },
            child: Container(
              width: 30, // Fixed width for buttons
              height: 30, // Fixed height for buttons
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    currentPage == index + 1 ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue),
              ),
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  color: currentPage == index + 1 ? Colors.white : Colors.blue,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _formatCreatedAt(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }
}
