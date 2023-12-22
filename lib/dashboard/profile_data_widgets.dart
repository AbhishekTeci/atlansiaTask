import 'package:flutter/material.dart';

class EmployeeProfile extends StatelessWidget {
  String? address;
  String? name;
  String? username;
  String? email;
  String? company;
  String? phoneNumber;
  String? website;

  EmployeeProfile({
    super.key,
    required this.address,
    required this.name,
    required this.username,
    required this.email,
    required this.company,
    required this.phoneNumber,
    required this.website,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(

          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              userData(username, 'User Name'),
              userData(name, 'Name'),
              userData(email, 'Email'),
              userData(phoneNumber, 'Phone No'),
              userData(address, 'Address'),
              userData(company, 'Company'),
              userData(website, 'Website')
            ],
          ),
        ),
      ),
    );
  }

  Widget userData(String? data, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$value : ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        data != null
            ? Text(
                data,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 14,
                  letterSpacing: 1
                ),
              )
            : const Text(''),
      ],
    );
  }
}
