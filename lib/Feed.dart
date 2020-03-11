import 'package:coronavirusdashboard/DatabaseService.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase/firebase.dart';

class Feed extends StatelessWidget {
  final Stream<QuerySnapshot> jghStream =
      firestore().collection('jgh-ed').orderBy('timestamp', 'desc').onSnapshot;
  @override
  Widget build(BuildContext context) {
    // DatabaseService _data = Provider.of<DatabaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Screening Feed'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: jghStream,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasError)
              return Text('Error: ${streamSnapshot.error}');
            switch (streamSnapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return Scrollbar(
                  child: ListView(
                    children: streamSnapshot.data.docs
                        .map((DocumentSnapshot document) {
                      switch (document.data()['result']) {
                        case 'Waiting Room':
                          {
                            return Card(
                              color: Colors.green[200],
                              child: ListTile(
                                title: Text('WAITING ROOM'),
                                subtitle: new Text(
                                    document.data()['language'].toUpperCase()),
                                trailing: new Text(
                                    document.data()['timestamp'].toString()),
                              ),
                            );
                          }
                          break;
                        case 'Code A':
                          {
                            return Card(
                              color: Colors.yellow[200],
                              child: ListTile(
                                title: Text(
                                  'CODE A',
                                ),
                                subtitle: new Text(
                                    document.data()['language'].toUpperCase()),
                                trailing: new Text(
                                    document.data()['timestamp'].toString()),
                              ),
                            );
                          }
                          break;
                        case 'Code C':
                          {
                            return Card(
                              color: Colors.red[200],
                              child: ListTile(
                                title: Text('CODE C'),
                                subtitle: new Text(
                                    document.data()['language'].toUpperCase()),
                                trailing: new Text(
                                    document.data()['timestamp'].toString()),
                              ),
                            );
                          }
                          break;
                      }
                      return new Card(
                        color: Colors.teal,
                        child: ListTile(
                          title: new Text(document.data()['result']),
                          subtitle: new Text(document.data()['language']),
                          trailing:
                              new Text(document.data()['timestamp'].toString()),
                        ),
                      );
                    }).toList(),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
