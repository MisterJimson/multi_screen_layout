import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

class MasterDetailLayoutExample extends StatefulWidget {
  @override
  _MasterDetailLayoutExampleState createState() =>
      _MasterDetailLayoutExampleState();
}

class _MasterDetailLayoutExampleState extends State<MasterDetailLayoutExample> {
  int selectedItem;

  @override
  Widget build(BuildContext context) {
    return MasterDetailLayout(
      master: Master(onItemSelected: (selected) {
        setState(() {
          selectedItem = selected;
        });
      }),
      detail: Detail(itemNumber: selectedItem),
      isSelected: selectedItem != null,
    );
  }
}

class Master extends StatelessWidget {
  final void Function(int) onItemSelected;

  const Master({
    Key key,
    @required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
        actions: [
          FlatButton(
            child: Text(
              'CLEAR SELECTION',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => onItemSelected(null),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var i = 1; i <= 10; i++)
            ListTile(
              title: Text(i.toString()),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                onItemSelected(i);
              },
            ),
        ],
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final int itemNumber;

  const Detail({
    Key key,
    @required this.itemNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
      ),
      body: Center(
        child: Text(itemNumber == null ? 'No Selection' : 'Item #$itemNumber'),
      ),
    );
  }
}
