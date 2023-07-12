import 'package:flutter/material.dart';
import 'package:postman/pages/network_page.dart';

import '../service/http_service.dart';
import '../service/log_service.dart';
import '../service/model/humans_model.dart';

class PostPage extends StatefulWidget {
  static const String id = 'EmployeeInfoPage';

  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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

  void _apiPostCreate(Humans humans) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(humans))
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Center(
              child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Column(children: [
                    Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'name'),
                          controller: nameController,

                        ), // TextFormField
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'age'),
                          controller: ageController,
                        ),


                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            var humans = Humans(

                              name: nameController.text.toString().trim(),
                              age: ageController.text.toString().trim(),
                            );
                            _apiPostCreate(humans);
                            _apiPostList();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const NetworkPage();
                            }));
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            color: Colors.blueAccent
                             // No such attribute
                          ),child: const Center(child:Text('Save',style: TextStyle(fontSize: 14,color: Colors.white),), )

                        ), ),

                  ])),
            )));
  }
}
