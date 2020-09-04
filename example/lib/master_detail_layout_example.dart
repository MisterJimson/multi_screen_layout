import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

class MasterDetailLayoutExample extends StatefulWidget {
  @override
  _MasterDetailLayoutExampleState createState() =>
      _MasterDetailLayoutExampleState();
}

class _MasterDetailLayoutExampleState extends State<MasterDetailLayoutExample> {
  int itemNumber = 0;

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
        return Navigator(
          onPopPage: (Route route, result) {
            return route.didPop(result);
          },
          pages: [
            CustomBuilderPage(
              key: Key('master'),
              routeBuilder: (context, settings) {
                return MaterialPageRoute(
                  builder: (_) {
                    return TwoPageLayout(
                      child: Master(
                        onItemSelected: (x) {
                          setState(() {
                            itemNumber = x;
                          });
                        },
                      ),
                      secondChild: Detail(itemNumber: itemNumber),
                    );
                  },
                  settings: settings,
                );
              },
            ),
            if (!info.isSpanned && itemNumber != 0)
              CustomBuilderPage(
                key: Key('detail'),
                routeBuilder: (context, settings) {
                  return MaterialPageRoute(
                    builder: (_) {
                      return Detail(itemNumber: itemNumber);
                    },
                    settings: settings,
                  );
                },
              ),
          ],
        );
      },
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
      ),
      body: MultiScreenInfo(
        builder: (info) {
          return ListView(
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
          );
        },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({
    Key key,
    @required this.itemNumber,
  }) : super(key: key);

  final int itemNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
      ),
      body: Center(
        child: Text(itemNumber == 0 ? 'No Selection' : 'Item #$itemNumber'),
      ),
    );
  }
}
