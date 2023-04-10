import 'package:database_crud_demo/database/my_database.dart';
import 'package:flutter/material.dart';

import 'add_user.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Database Demo"),
          actions: [
            InkWell(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddUser(null);
                  },
                )).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              child: Container(
                child: Icon(Icons.add),
                margin: EdgeInsets.only(right: 10),
              ),
            )
          ],
        ),
        body: Container(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]["UserName"]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      child: Icon(Icons.delete),
                                      onPressed: () async {
                                        await MyDatabase()
                                            .deleteUser(
                                                snapshot.data![index]["UserId"])
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      child: Icon(Icons.edit),
                                      onPressed: () async {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                          return AddUser(snapshot.data![index]);
                                        },)).then((value) {
                                          setState(() {

                                          });
                                        });

                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                  future: MyDatabase().getDetails(),
                );
              } else {
                return Center(
                  child: Container(
                    child: Text("Coping..."),
                  ),
                );
              }
            },
            future: MyDatabase().copyPasteAssetFileToRoot(),
          ),
        ),
      ),
    );
  }
}
