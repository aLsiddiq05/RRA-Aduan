import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllAduan extends StatefulWidget {
  const AllAduan({super.key});

  @override
  State<AllAduan> createState() => _AllAduanState();
}

class _AllAduanState extends State<AllAduan> {

  // static const _pageSize = 20;

  //  final PagingController<int, aduans> _pagingController =
  //     PagingController(firstPageKey: 0);

  // @override
  // void initState() {
  //   _pagingController.addPageRequestListener((pageKey) {
  //     _fetchPage(pageKey);
  //   });
  //   super.initState();
  // }

  //  Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final newItems = await RemoteApi.getBeerList(pageKey, _pageSize);
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       final nextPageKey = pageKey + newItems.length;
  //       _pagingController.appendPage(newItems, nextPageKey);
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Tajuk"),
                subtitle: Text("content"),
                trailing: Text("Status"),
              ),
            ),
            Card(
              color: Colors.green,
              child: ListTile(
                title: Text("Tajuk"),
                subtitle: Text("content"),
                trailing: Text("Status"),
              ),
            ),
             Card(
              color: Colors.blueAccent,
              child: ListTile(
                title: Text("Tajuk"),
                subtitle: Text("content"),
                trailing: Text("Status"),
              ),
            ),
             Card(
              color: Colors.redAccent,
              child: ListTile(
                title: Text("Tajuk"),
                subtitle: Text("content"),
                trailing: Text("Status"),
              ),
            ),
          ],
        ),
        ),
    );
  }
}