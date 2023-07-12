import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:postman/pages/post_page.dart';
import 'package:postman/service/model/humans_model.dart';
import 'package:postman/service/model/users_model.dart';

import '../service/http_service.dart';

import '../service/log_service.dart';
import '../service/model/cars_resonse.dart';

import 'info_page.dart';

class NetworkPage extends StatefulWidget {
  static const String id = "/network_page";
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  var isLoading = false;
  var users=[];

  @override
  void initState() {
    super.initState();
    _apiPostList();

  }

  void _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      users = Network.parsePostList(response) ;
      setState(() {});
    }

    setState(() {
      isLoading = false;
    });
    print(response);
  }



  void _apiPostGet(Cars cars) {
    Network.POST(Network.API_GET, Network.paramsEmpty()).then((response) => {});
  }

  void _apiPostCreate(Humans humans) {
    Network.POST(Network.API_CREATE, Network.paramsCreate(humans))
        .then((response) => {
      _apiPostList(),
      LogService.i(response.toString()),
    });
  }

  void _apiPostUpdate(Humans humans) {
    Network.PUT(Network.API_UPDATE + humans.id.toString(),
        Network.paramsUpdate(humans))
        .then((response) => {
      _apiPostList(),
      LogService.i(response.toString()),
    });
  }

  void _apiPostDelete(Humans? humans) {
    Network.DEL(Network.API_DELETE + (humans?.id.toString() ?? ""),
        Network.paramsEmpty())
        .then((response) => {_apiPostList(), print(response)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const PostPage();
        })),
        child: const Icon(Icons.add),


      ),

        appBar: AppBar(
          title: const Text('Networking'),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: users.length,
              itemBuilder: (ctx, index) {
                return itemHomePost(users[index]);

              },

            ),
            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink(),

          ],
        ));
  }

  Widget itemHomePost(Humans? humans) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              setState(() {
                _apiPostDelete(humans);
              });

            },
            flex: 3,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "delete",
          ),
        ],
      ),
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EmployeeInfoPage();
                }));
              });

            },
            flex: 3,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: "update",
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {

        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                humans?.name??'jj',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                humans?.age??'jj',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ), // SizedBox
              Text(humans?.id ?? '')
            ],
          ),
        ),
      ),
    );
  }
}