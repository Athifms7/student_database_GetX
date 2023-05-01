// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          style: TextStyle(),
          autofocus: true,
          decoration: InputDecoration(
              label: Text('Search'), suffixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}
