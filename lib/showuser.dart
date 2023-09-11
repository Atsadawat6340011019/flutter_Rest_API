import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  List<dynamic> users = [];

  @override
  void initState(){
    getUserInfo();
    super.initState();
  }

  Future getUserInfo() async{
    const url = "https://randomuser.me/api/?results=5";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = response.body;
    final data = jsonDecode(json);
    setState(() {
      users = data['results'];
      // users =[{},{},{}]
      
      
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API CALL'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          final user = users[index];
          final name = user['name'] ['first'];
          final email = user['email'];
          final imageUrl = user['picture'] ['thumbnail'];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(name),
            subtitle: Text(email),
            trailing: GestureDetector(
              child: Icon(Icons.delete), onTap: (){},
            ),

          );

        }
        ),
    );
  }
}