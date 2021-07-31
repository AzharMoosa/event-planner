import 'package:flutter/material.dart';

class SearchScreenWidget extends StatefulWidget {
  const SearchScreenWidget({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Search Screen'),
    );
  }
}
