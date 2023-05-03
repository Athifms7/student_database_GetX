import 'package:flutter/material.dart';
import 'package:student_database/screens/screen_details.dart';
import 'package:student_database/screens/screen_search.dart';
import 'package:student_database/screens/screen_student_add.dart';

import '../db/functions/dbFunctions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Search();
                  },
                ));
              },
              icon: Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return StudentAdd();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (context, gettingStudendList, child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return StudentDetails(index: index);
                        },
                      ));
                    },
                    title: Text(gettingStudendList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          studentListNotifier.value.removeAt(index);
                          studentListNotifier.notifyListeners();
                        },
                        icon: Icon(Icons.delete)),
                    leading: Image(
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/660/660611.png')),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: gettingStudendList.length);
          },
        ),
      ),
    );
  }
}
