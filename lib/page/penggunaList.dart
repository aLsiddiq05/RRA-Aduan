import 'package:flutter/material.dart';
import 'package:rra_mobile/page/detailPengguna.dart';
import 'package:rra_mobile/services/allPengguna.dart';
import 'package:rra_mobile/widget/customappbar.dart';

class PenggunaList extends StatefulWidget {
  PenggunaList({super.key});

  @override
  State<PenggunaList> createState() => _PenggunaListState();
}

class _PenggunaListState extends State<PenggunaList> {
  late double mWidth;
  List<Pengguna> _penggunas = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;
  int maxPage = 1;

  @override
  void initState() {
    super.initState();
    _getAllPengguna();
  }

  Future<void>_getAllPengguna() async{
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    final res = await fetchPengguna(_currentPage);

    if (res != null) {
      print('load sucess list $res');
      print('Current Page: $_currentPage');
      setState(() {
        _penggunas.addAll(res.result);
        _currentPage = res.currentPage + 1;
        maxPage = res.maxPage;
        if (res.result.isEmpty) {
          _hasMoreData = false;
        }
      });
    } else {
      print('Failed to load pengguna');
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
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Senarai Pengguna',
        backgroundColor: Colors.teal,
      ),
      
      body: Container(
        width: mWidth,
        margin: EdgeInsets.all(mWidth * 0.04),
        // color: Colors.greenAccent,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: _penggunas.isEmpty && !_isLoading
                        ? Center(child: Text('Wait!!!!'),)
                        : ListView.builder(
                          itemCount: _penggunas.length,
                          itemBuilder: (context, index) {
                            final pengguna = _penggunas[index];
                            return Card(
                              elevation: 10,
                              child: GestureDetector(
                                onTap: () {
                                  print('Profile ID: ${pengguna.id}');
                                  
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPengguna(id: pengguna.id,),));
                                },
                                child: ListTile(
                                  title: Text(pengguna.name),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(pengguna.id_no),
                                      Text(pengguna.email)
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Bil. Aduan'),
                                      Text(pengguna.aduanCount.toString())
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          )
              ),
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator(),),
            if (_hasMoreData && !_isLoading) ElevatedButton(onPressed: _getAllPengguna, child: Text('Load More'))
            
            // SizedBox(
            //   width: double.infinity,
            //   child: Card(
            //     child: ListTile(
            //       title: Text('Ahmad Idham'),
            //       subtitle: Text('021123040233'),
            //       trailing: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text('Total Aduan'),
            //           Text('10')
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}