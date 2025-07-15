import 'package:flutter/material.dart';

class AdminUserManager extends StatelessWidget {
  const AdminUserManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = [
      {
        'id': 1,
        'name': 'music_lover',
        'email': 'music@example.com',
        'role': 'User'
      },
      {
        'id': 2,
        'name': 'popqueen',
        'email': 'popqueen@example.com',
        'role': 'Admin'
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Tài khoản')),
      body: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name'] as String),
            subtitle: Text('${user['email']} - Vai trò: ${user['role']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ],
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
