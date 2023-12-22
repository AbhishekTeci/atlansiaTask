import 'dart:convert';
import 'package:atlansia/dashboard/profile_data_widgets.dart';
import 'package:atlansia/dashboard/serach_widgets.dart';
import 'package:atlansia/helper/database_helper.dart';
import 'package:atlansia/model/user_data_local_model.dart';
import 'package:atlansia/model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../notification/notification_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<UserDataModel> userDataList = [];
  List<UserDataModel> userLocalDataList = [];
  NotificationService notificationService = NotificationService();

  List<UserDataModel> searchList = [];
  var db = DatabaseHelper();


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                child: ListView.builder(
                    itemCount: userDataList.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EmployeeProfile(
                        name: userDataList[index].name,
                        username: userDataList[index].username,
                        email: userDataList[index].email,
                        phoneNumber: userDataList[index].phone,
                        company: userDataList[index].company!.name,
                        address: userDataList[index].address!.suite,
                        website: userDataList[index].website,
                      );
                    }),
              ),
              SearchWidgetView(
                txtController: controller,
                onSubmitted: (value) {
                  debugPrint('myValue2 $value');
                  controller.text = value;
                  searchByName(value);
                },
              ),
              ElevatedButton(onPressed: () async {

                await notificationService.showLocalNotification(
                    id: 0,
                    title: "Drink Water",
                    body: "Time to drink some water!",
                    payload: "You just took water! Huurray!");

              }, child: Text('Notify')),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final UserDataModel dataModel = UserDataModel.fromJson(data[0]);

      List<UserDataModel> items = [];
      List mainList = data;

      items.addAll(
          mainList.map((data) => UserDataModel.fromJson(data)).toList());
      setState(() {
        userDataList.addAll(items);
      });

      db.insertUserData(dataModel);

      debugPrint(userDataList.length.toString());
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }


  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Dashboard()));
      });

  void searchByName(String name) {
    for (int i = 0; i < userDataList.length; i++) {
      if (name.toLowerCase() == userDataList[i].name?.toLowerCase()) {
        setState(() {
          searchList.add(userDataList[i]);
          userDataList.clear();
          userDataList.addAll(searchList);
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    listenToNotificationStream();
    super.initState();
  }
}
