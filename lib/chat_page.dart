import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'users.dart';

const List<User> users = const <User>[
  const User('Jack', Colors.greenAccent),
  const User('Lucy', Colors.green),
  const User('Luna', Colors.black26),
  const User('Oliver', Colors.blue),
  const User('Lily', Colors.amberAccent),
  const User('Milo', Colors.purple),
  const User('Max', Colors.pink),
  const User('Kitty', Colors.yellowAccent),
  const User('Simba', Colors.red),
  const User('Zoe', Colors.blueAccent),
  const User('Jasper', Colors.deepOrange),
  const User('Stella', Colors.cyan),
  const User('Lola', Colors.lightBlue),
  const User('Halsey', Colors.deepPurpleAccent),
  const User('Taylor', Colors.indigoAccent),
];

class UserTile extends StatelessWidget {
  final User _product;

  const UserTile(
    this._product,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: _product.backgroundColor,
            radius: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _product.name,
                style: TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CupertinoChatPage extends StatefulWidget {
  const CupertinoChatPage({Key? key}) : super(key: key);

  @override
  _CupertinoChatPageState createState() => _CupertinoChatPageState();
}

class _CupertinoChatPageState extends State<CupertinoChatPage> {
  List<User> _filteredUsers = users;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateUserList(String value) {
    debugPrint('$value');

    if (value.length > 0) {
      _filteredUsers = _filteredUsers
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      _controller.text = '';
      _filteredUsers = users;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Chats'),
          leading: Text(
            'Edit',
            style: TextStyle(color: CupertinoColors.link),
          ),
          middle: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(width: 8),
              Text('Waiting for network')
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: ClipRect(
                child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CupertinoSearchTextField(
                controller: _controller,
                onChanged: (value) {
                  _updateUserList(value);
                },
                onSubmitted: (value) {
                  _updateUserList(value);
                },
                onSuffixTap: () {
                  _updateUserList('');
                },
              ),
            )),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return UserTile(_filteredUsers[index]);
            },
            childCount: _filteredUsers.length,
          ),
        ),
      ],
    );
  }
}
