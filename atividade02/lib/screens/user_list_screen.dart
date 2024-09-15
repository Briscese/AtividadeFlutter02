import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user_model.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedUsers = await ApiService.fetchUsers();
    setState(() {
      users = fetchedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                // Verifica se o ID do usuário é par ou ímpar
                final Color cardColor = user.id.isEven
                    ? Colors.lightBlueAccent // Cor azul clara para IDs pares
                    : Colors.lightGreenAccent; // Cor verde clara para IDs ímpares

                return Card(
                  color: cardColor, // Define a cor do Card com base no ID
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${user.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Name: ${user.name}'),
                        Text('Username: ${user.username}'),
                        Text('Email: ${user.email}'),
                        SizedBox(height: 10),
                        Text('Address:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('  Street: ${user.address.street}'),
                        Text('  Suite: ${user.address.suite}'),
                        Text('  City: ${user.address.city}'),
                        Text('  Zipcode: ${user.address.zipcode}'),
                        Text('  Geo: (${user.address.geo.lat}, ${user.address.geo.lng})'),
                        SizedBox(height: 10),
                        Text('Phone: ${user.phone}'),
                        Text('Website: ${user.website}'),
                        SizedBox(height: 10),
                        Text('Company:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('  Name: ${user.company.name}'),
                        Text('  CatchPhrase: ${user.company.catchPhrase}'),
                        Text('  BS: ${user.company.bs}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
