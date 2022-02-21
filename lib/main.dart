import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:listview_multiselection/nature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Nature> natureList = [
    Nature("Sea View", "Sea view resort",
        "https://images.unsplash.com/photo-1589779677460-a15b5b5790ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
    Nature("Awesome Nature", "Orange color fish",
        "https://images.unsplash.com/photo-1520301255226-bf5f144451c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80"),
    Nature("Yellow Fish", "Yellow Fish in blue water",
        "https://images.unsplash.com/photo-1504472478235-9bc48ba4d60f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
    Nature("Orange Fish", "Orange Fish in blue water",
        "https://images.unsplash.com/photo-1535591273668-578e31182c4f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Nature("Nature 1", "Nice tree in the nature",
        "https://images.unsplash.com/photo-1624964562918-0b8cf87deee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Nature("Sea Nature", "Nice beach nature",
        "https://images.unsplash.com/photo-1597499216184-b56bf75f84c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Nature("Awesome Beach", "Beach with trees",
        "https://images.unsplash.com/photo-1509057095372-215f8cc53d1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=874&q=80"),
    Nature("Blue Nature", "Beach with blue water",
        "https://images.unsplash.com/photo-1558102822-da570eb113ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
    Nature("Sea Nature 2", "Awesome beach with trees",
        "https://images.unsplash.com/photo-1545579133-99bb5ab189bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"),
  ];

  HashSet<Nature> selectedItem = HashSet();
  bool isMultiSelectionEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: isMultiSelectionEnabled ? false : true,
        leading: isMultiSelectionEnabled
            ? IconButton(
                onPressed: () {
                  selectedItem.clear();
                  isMultiSelectionEnabled = false;
                  setState(() {});
                },
                icon: Icon(Icons.close))
            : null,
        title: Text(isMultiSelectionEnabled
            ? getSelectedItemCount()
            : "Listview Multi Selection"),
        actions: [
          Visibility(
              visible: selectedItem.isNotEmpty,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  selectedItem.forEach((nature) {
                    natureList.remove(nature);
                  });
                  selectedItem.clear();
                  setState(() {});
                },
              )),
          Visibility(
              visible: selectedItem.isNotEmpty,
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              )),
          /*Visibility(
              visible: isMultiSelectionEnabled,
              child: IconButton(
                icon: Icon(
                  Icons.select_all,
                  color: selectedItem.length == natureList.length
                      ? Colors.black
                      : Colors.white,
                ),
                onPressed: () {
                  if (selectedItem.length == natureList.length) {
                    selectedItem.clear();
                  } else {
                    for (int index = 0; index < natureList.length; index++) {
                      selectedItem.add(natureList[index]);
                    }
                  }
                  setState(() {});
                },
              )),*/
        ],
      ),
      body: ListView(
        children: natureList.map((Nature nature) {
          return Card(
              elevation: 20,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                height: 70.0,
                child: getListItem(nature),
              ));
        }).toList(),
      ),
    );
  }

  String getSelectedItemCount() {
    return selectedItem.isNotEmpty
        ? selectedItem.length.toString() + " item selected"
        : "No item selected";
  }

  void doMultiSelection(Nature nature) {
    if (isMultiSelectionEnabled) {
      if (selectedItem.contains(nature)) {
        selectedItem.remove(nature);
      } else {
        selectedItem.add(nature);
      }
      setState(() {});
    } else {
      //Other logic
    }
  }

  InkWell getListItem(Nature nature) {
    return InkWell(
        onTap: () {
          doMultiSelection(nature);
        },
        onLongPress: () {
          isMultiSelectionEnabled = true;
          doMultiSelection(nature);
        },
        child: Stack(alignment: Alignment.centerRight, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                nature.url,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 18.0,
                      child: Text(nature.name),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 14.0,
                      child: Text(nature.description),
                    ),
                  ],
                ),
              )
            ],
          ),
          Visibility(
              visible: isMultiSelectionEnabled,
              child: Icon(
                selectedItem.contains(nature)
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 30,
                color: Colors.red,
              ))
        ]));
  }
}
