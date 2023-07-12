import 'package:flutter/material.dart';
import 'package:postman/pages/network_page.dart';

import '../service/http_service.dart';
import '../service/log_service.dart';
import '../service/model/humans_model.dart';

class EmployeeInfoPage extends StatefulWidget {
  static const String id = 'EmployeeInfoPage';

  const EmployeeInfoPage({super.key});

  @override
  State<EmployeeInfoPage> createState() => _EmployeeInfoPageState();
}

class _EmployeeInfoPageState extends State<EmployeeInfoPage> {
  var isLoading = false;
  var users = [];

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  void _apiPostUpdate(Humans humans) {
    Network.PUT(Network.API_UPDATE + humans.id.toString(),
            Network.paramsUpdate(humans))
        .then((response) => {
              _apiPostList(),
              LogService.i(response.toString()),
            });
  }

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      users = Network.parsePostList(response);
      setState(() {});
    }

    setState(() {
      isLoading = false;
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Center(
              child: Container(
                  width: 300,
                  height: 300,
                  child: Column(children: [
                    Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'name'),
                          controller: nameController,

                        ), // TextFormField
                        TextFormField(
                          decoration: InputDecoration(labelText: 'age'),
                          controller: ageController,
                        ),

                        TextFormField(
                          decoration: InputDecoration(labelText: 'id'),
                          controller: idController,
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            var humans = Humans(
                              id: idController.text.toString().trim(),
                              name: nameController.text.toString().trim(),
                              age: ageController.text.toString().trim(),
                            );
                            _apiPostUpdate(humans);
                            _apiPostList();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const NetworkPage();
                            }));
                          });
                        },
                        child: Text('Save')),

                  ])),
            )));
  }
}
