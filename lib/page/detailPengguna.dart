import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rra_mobile/services/detailPenggunaService.dart';
import 'package:rra_mobile/widget/aduanDetailReceipt.dart';
import 'package:rra_mobile/widget/customappbar.dart';

class DetailPengguna extends StatefulWidget {
  // DetailPangguna({super.key});
  final int id;

  const DetailPengguna({super.key, required this.id});

  @override
  State<DetailPengguna> createState() => _DetailPenggunaState();
}

class _DetailPenggunaState extends State<DetailPengguna> {
  late double mWidth;
  String name = '';
  String ic = '';
  String email = '';
  List<Aduan> _aduan = [];
  int? totalAduan;

  @override
  void initState() {
    super.initState();
    getProfileAduan();
  }

  Future<void> getProfileAduan() async {
    final res = await fetchProfile(widget.id);

    print('test res: $res');

    if (res != null) {
      print('load profile success: ${res.profile}');
      print('load aduan success: ${res.results}');
      setState(() {
        name = res.profile.name;
        ic = res.profile.id_no;
        email = res.profile.email;
        totalAduan = res.total;
        _aduan.addAll(res.results);
      });
    } else {
      print('Failed to load profile');
    }
  }

  void _refreshAduanData() {
    getProfileAduan(); // Refresh the aduan list
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Detail Pengguna',
        backgroundColor: Colors.teal,
      ),
      body: Container(
        margin: EdgeInsets.all(mWidth * 0.03),
        // color: Colors.teal,
        child: Center(
          child: Column(
            children: [
              //detail pengguna
              Card(
                color: Colors.teal[200],
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profil'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ic,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        email,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const DottedLine(
                alignment: WrapAlignment.center,
                dashLength: 10,
                dashGapLength: 10,
              ),
              const SizedBox(
                height: 15,
              ),

              //aduans
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: _aduan.length,
                  itemBuilder: (context, index) {
                    final aduan = _aduan[index];
                    Color cardColor;
                    var statusText;
                    switch (aduan.status) {
                      case 1:
                        cardColor = Colors.grey;
                        statusText = 'Terima';
                        break;
                      case 2:
                        cardColor = Colors.blueAccent;
                        statusText = 'Dalam Siasatan';
                        break;
                      case 3:
                        cardColor = Colors.greenAccent;
                        statusText = 'Selesai';
                        break;
                      case 4:
                        cardColor = Colors.redAccent;
                        statusText = 'Batal';
                        break;
                      default:
                        cardColor = Colors.white;
                        statusText = 'null';
                    }
                    return Card(
                      elevation: 10,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AduanDetailReceipt(
                                  aduanId: aduan.id.toString(),
                                  onAduanCanceled: _refreshAduanData);
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(aduan.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(aduan.content),
                              SizedBox(
                                height: 5,
                              ),
                              Card(
                                color: cardColor,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(statusText),
                                ),
                              )
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(DateFormat('dd/MM/yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      aduan.createdAt * 1000))),
                              Text(DateFormat('hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      aduan.createdAt * 1000)))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
