import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rra_mobile/services/allAduanService.dart';
import 'package:rra_mobile/services/getStatusService.dart';
import 'package:rra_mobile/widget/aduanDetailReceipt.dart';

class AllAduan extends StatefulWidget {
  const AllAduan({super.key});

  @override
  State<AllAduan> createState() => _AllAduanState();
}

class _AllAduanState extends State<AllAduan> {
  List<Aduan> _aduans = [];
  int _activeStatus = 0;
  int _currentPage = 1;
  int terima = 0;
  int selesai = 0;
  int siasatan = 0;
  int batal = 0;
  bool _isLoading = false;
  bool _hasMoreData = true;
  late double mWidth;

  @override
  void initState() {
    super.initState();
    _loadMyAduan();
    _getAduanStatus();
  }

  Future<void> _getAduanStatus() async {
    final status = await loadMyAduanStatus();

    if (status != null) {
      int terima = status['terima'];
      int siasatan = status['siasatan'];
      int selesai = status['selesai'];
      int batal = status['batal'];

      print(
          'Terima: $terima, Siasatan: $siasatan, Selesai: $selesai, Batal: $batal');

      setState(() {
        this.terima = terima;
        this.siasatan = siasatan;
        this.selesai = selesai;
        this.batal = batal;
      });
    } else {
      print('Failed load status');
    }
  }

  Future<void> _loadMyAduan() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    final res = await fetchAduans(_currentPage, _activeStatus);

    if (res != null) {
      print('load success');
      print('Current Page: $_currentPage');
      print('Fetched ${res.result.length} aduans');
      // print('Status active:' + widget.status.toString());
      setState(() {
        _aduans.addAll(res.result);
        _currentPage = res.currentPage + 1;
        if (res.result.isEmpty) {
          _hasMoreData = false;
        }
      });
    } else {
      print('Failed to load aduan');
      setState(() {
        _hasMoreData = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _refreshAduanData() {
    setState(() {
      _aduans.clear();
      _currentPage = 1; 
      _hasMoreData = true;
    });

    _loadMyAduan();
    _getAduanStatus();
  }

  void resetnReload(int status) {
    setState(() {
      _activeStatus = status;
      _currentPage = 1;
      _hasMoreData = true;
      _aduans.clear();
      _loadMyAduan();
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _loadMyAduan();
      _getAduanStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.black,
      width: mWidth,
      margin: EdgeInsets.all(mWidth * 0.02),
      child: Column(
        children: <Widget>[
          // status
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 80,
                child: Card(
                  color: const Color.fromARGB(255, 169, 190, 200),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Terima"), Text(terima.toString())],
                      ),
                      onTap: () {
                        resetnReload(1);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                height: 80,
                child: Card(
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Siasatan"),
                          Text(siasatan.toString())
                        ],
                      ),
                      onTap: () {
                        resetnReload(2);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                height: 80,
                child: Card(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Selesai"),
                          Text(selesai.toString())
                        ],
                      ),
                      onTap: () {
                        resetnReload(3);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 90,
                height: 80,
                child: Card(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Batal"),
                          Text(batal.toString())
                        ],
                      ),
                      onTap: () => resetnReload(4),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),

          // allAduans
          Column(
            children: <Widget>[
              SizedBox(
                  height: 400,
                  child: _aduans.isEmpty && !_isLoading
                      ? Center(child: Text('No Aduan Available.'))
                      : ListView.builder(
                          itemCount: _aduans.length,
                          itemBuilder: (context, index) {
                            final aduan = _aduans[index];
                            Color cardColor;
                            switch (aduan.status) {
                              case 1:
                                cardColor = Colors.grey;
                                break;
                              case 2:
                                cardColor = Colors.blueAccent;
                                break;
                              case 3:
                                cardColor = Colors.greenAccent;
                                break;
                              case 4:
                                cardColor = Colors.redAccent;
                                break;
                              default:
                                cardColor = Colors.white;
                            }
                            return GestureDetector(
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AduanDetailReceipt(
                                      aduanId: aduan.id.toString(),
                                      onAduanCanceled: _refreshAduanData,
                                    );
                                  },
                                );
                              },
                              child: Card(
                                color: cardColor,
                                child: ListTile(
                                  title: Text(aduan.title),
                                  subtitle: Text(aduan.content),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(DateFormat('dd/MM/yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              aduan.createdAt * 1000))),
                                      Text(DateFormat('hh:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              aduan.createdAt * 1000))),
                                    ],
                                  ),
                                ),
                              ));
                            },
                          )),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (_hasMoreData && !_isLoading)
                  ElevatedButton(
                    onPressed: _loadMyAduan,
                    child: const Text('Load More'),
                  ),
              ],
            ),
          
        ],
      ),
    );
  }
}
