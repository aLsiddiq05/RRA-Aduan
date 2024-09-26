import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rra_mobile/services/allAduanService.dart';

class AllAduan extends StatefulWidget {
  const AllAduan({super.key});

  @override
  State<AllAduan> createState() => _AllAduanState();
}

class _AllAduanState extends State<AllAduan> {
  List<Aduan> _aduans = [];
  int _activeStatus = 0;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadMyAduan();
  }

  Future<void> _loadMyAduan() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    final res = await fetchAduans(_currentPage, _activeStatus);

    if (res != null) {
      print('load success');
      // print('Status active:' + widget.status.toString());
      setState(() {
        _aduans.addAll(res.result);
        _currentPage = res.currentPage + 1;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // status
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Terima"), Text("0")],
                          ),
                          onTap: () {
                            setState(() {
                              _activeStatus = 1;
                              // _aduans.clear();
                              _loadMyAduan();
                            });
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Siasatan"), Text("0")],
                          ),
                          onTap: () {},
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Selesai"), Text("0")],
                          ),
                          onTap: () {},
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
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Batal"), Text("0")],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          // allAduans
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
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
                            return Card(
                              color: cardColor,
                              child: ListTile(
                                  title: Text(aduan.title),
                                  subtitle: Text(aduan.content),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(DateFormat('dd/MM/yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              aduan.createdAt * 1000))),
                                      Text(DateFormat('hh:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              aduan.createdAt * 1000))),
                                    ],
                                  )),
                            );
                          },
                        ),
                ),
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
          )
        ],
      ),
    );
  }
}
