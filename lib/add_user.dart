import 'package:database_crud_demo/database/my_database.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  Map<String,Object?>? map;
  AddUser(map){
    this.map = map;
  }

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var nameController = TextEditingController();
  var cityIdController = TextEditingController();
  void initState(){
    nameController.text=widget.map==null?'':widget.map!["UserName"].toString();
    cityIdController.text=widget.map==null?'':widget.map!["CityId"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Card(
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Enter User Name"),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: cityIdController,
                  decoration: InputDecoration(hintText: "Enter City Id"),
                ),
              ),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(widget.map==null){
                        insertUser().then((value) => Navigator.of(context).pop(true));
                      }
                      else{
                        editUser(widget.map!["UserId"].toString()).then((value) => Navigator.of(context).pop(true));
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<int> insertUser() async {
    Map<String, Object?> map = Map<String, Object?>();
    map["UserName"]=nameController.text;
    map["CityId"]=cityIdController.text;

    var res = await MyDatabase().insertUser(map);
    return res;
  }

  Future<int> editUser(id) async {
    Map<String, Object?> map = Map<String, Object?>();
    map["UserName"]=nameController.text;
    map["CityId"]=cityIdController.text;

    var res = await MyDatabase().editUser(map, id);
    return res;
  }

}
