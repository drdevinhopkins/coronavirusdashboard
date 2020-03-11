import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firestore.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseService _data = Provider.of<DatabaseService>(context);

    var isLargeScreen;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth > 1024 && screenWidth > screenHeight) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: isLargeScreen
            ? Text('JGH ED - Coronavirus Screening Dashboard')
            : Text('Dashboard'),
        centerTitle: true,
        actions: <Widget>[
          isLargeScreen
              ? Text(' ')
              : FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/feed');
                  },
                  child: Icon(
                    Icons.rss_feed,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: isLargeScreen
          ? Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:
                      _buildLargeDataBreakdown(context, _data.fullDescStream),
                ),
                Expanded(
                  flex: 1,
                  child: _buildScreeningStream(context, _data.fullDescStream),
                )
              ],
            )
          : _buildSmallDataBreakdown(context, _data.fullDescStream),
    );
  }
}

Widget _buildLargeDataBreakdown(BuildContext context, screeningStream) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: StreamBuilder(
      stream: screeningStream,
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
        if (dataSnapshot.hasError) return Text('Error: ${dataSnapshot.error}');
        switch (dataSnapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            var totalScreenings = dataSnapshot.data.size;
            var totalWaitingRooms = dataSnapshot.data.docs
                .where((d) => (d.data()['result'] == 'Waiting Room'))
                .length;
            var totalCodeCs = dataSnapshot.data.docs
                .where((d) => (d.data()['result'] == 'Code C'))
                .length;
            var totalCodeAs = dataSnapshot.data.docs
                .where((d) => (d.data()['result'] == 'Code A'))
                .length;

            var now = new DateTime.now();
            var twentyFourHoursAgo = now.subtract(new Duration(hours: 24));
            var twentyFourHourTotalScreenings = dataSnapshot.data.docs
                .where(
                    (d) => (d.data()['timestamp'].isAfter(twentyFourHoursAgo)))
                .length;
            var twentyFourHourTotalWaitingRooms = dataSnapshot.data.docs
                .where((d) =>
                    (d.data()['timestamp'].isAfter(twentyFourHoursAgo) &&
                        d.data()['result'] == 'Waiting Room'))
                .length;
            var twentyFourHourTotalCodeCs = dataSnapshot.data.docs
                .where((d) =>
                    (d.data()['timestamp'].isAfter(twentyFourHoursAgo) &&
                        d.data()['result'] == 'Code C'))
                .length;
            var twentyFourHourTotalCodeAs = dataSnapshot.data.docs
                .where((d) =>
                    (d.data()['timestamp'].isAfter(twentyFourHoursAgo) &&
                        d.data()['result'] == 'Code A'))
                .length;

            Map<String, double> totalPieChartMap = new Map();
            totalPieChartMap.putIfAbsent(
                "Code C", () => totalCodeCs.toDouble());
            totalPieChartMap.putIfAbsent(
                "Code A", () => totalCodeAs.toDouble());
            totalPieChartMap.putIfAbsent(
                "Waiting Room", () => totalWaitingRooms.toDouble());

            Map<String, double> twentyFourHourPieChartMap = new Map();
            twentyFourHourPieChartMap.putIfAbsent(
                "Code C", () => twentyFourHourTotalCodeCs.toDouble());
            twentyFourHourPieChartMap.putIfAbsent(
                "Code A", () => twentyFourHourTotalCodeAs.toDouble());
            twentyFourHourPieChartMap.putIfAbsent("Waiting Room",
                () => twentyFourHourTotalWaitingRooms.toDouble());

            List<Color> colorList = [
              Colors.red[200],
              Colors.yellow[200],
              Colors.green[200],
            ];

            var totalEnglish = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'english'))
                .length;
            var totalFrench = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'french'))
                .length;
            var totalArabic = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'arabic'))
                .length;
            var totalSpanish = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'spanish'))
                .length;
            var totalChinese = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'chinese'))
                .length;

            Map<String, double> languageMap = new Map();
            languageMap.putIfAbsent("English", () => totalEnglish.toDouble());
            languageMap.putIfAbsent("French", () => totalFrench.toDouble());
            languageMap.putIfAbsent("Arabic", () => totalArabic.toDouble());
            languageMap.putIfAbsent("Spanish", () => totalSpanish.toDouble());
            languageMap.putIfAbsent("Chinese", () => totalChinese.toDouble());

            List<Color> languageColorList = [
              Colors.orange[200],
              Colors.pink[200],
              Colors.cyan[200],
              Colors.lime[200],
              Colors.indigo[200],
            ];

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Screening Breakdown',
                      style: Theme.of(context).textTheme.headline3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          PieChart(
                              dataMap: twentyFourHourPieChartMap,
                              colorList: colorList,
                              showChartValuesInPercentage: false,
                              showLegends: true,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 6),
                          Text(
                            'Last 24 Hours',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          PieChart(
                              dataMap: totalPieChartMap,
                              colorList: colorList,
                              showChartValuesInPercentage: false,
                              showLegends: false,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 6),
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Total Screenings since deployment: ${totalScreenings.toString()}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Languages',
                      style: Theme.of(context).textTheme.headline2),
                  SizedBox(
                    height: 20,
                  ),
                  PieChart(
                      dataMap: languageMap,
                      colorList: languageColorList,
                      showChartValuesInPercentage: false,
                      showLegends: true,
                      chartRadius: MediaQuery.of(context).size.width / 6),
                ],
              ),
            );
        }
      },
    ),
  );
}

Widget _buildSmallDataBreakdown(BuildContext context, screeningStream) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: StreamBuilder(
      stream: screeningStream,
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> dataSnapshot) {
        if (dataSnapshot.hasError) return Text('Error: ${dataSnapshot.error}');
        switch (dataSnapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            var totalScreenings = dataSnapshot.data.size;
            var totalWaitingRooms = dataSnapshot.data.docs
                .where((d) => (d.data()['result'] == 'Waiting Room'))
                .length;
            var totalCodeCs = dataSnapshot.data.docs
                .where((d) => (d.data()['result'] == 'Code C'))
                .length;
            var totalCodeAs = dataSnapshot.data.docs
                .where((d) => (d.data()['result'] == 'Code A'))
                .length;

            var now = new DateTime.now();
            var twentyFourHoursAgo = now.subtract(new Duration(hours: 24));
            var twentyFourHourTotalScreenings = dataSnapshot.data.docs
                .where(
                    (d) => (d.data()['timestamp'].isAfter(twentyFourHoursAgo)))
                .length;
            var twentyFourHourTotalWaitingRooms = dataSnapshot.data.docs
                .where((d) =>
                    (d.data()['timestamp'].isAfter(twentyFourHoursAgo) &&
                        d.data()['result'] == 'Waiting Room'))
                .length;
            var twentyFourHourTotalCodeCs = dataSnapshot.data.docs
                .where((d) =>
                    (d.data()['timestamp'].isAfter(twentyFourHoursAgo) &&
                        d.data()['result'] == 'Code C'))
                .length;
            var twentyFourHourTotalCodeAs = dataSnapshot.data.docs
                .where((d) =>
                    (d.data()['timestamp'].isAfter(twentyFourHoursAgo) &&
                        d.data()['result'] == 'Code A'))
                .length;

            Map<String, double> totalPieChartMap = new Map();
            totalPieChartMap.putIfAbsent(
                "Code C", () => totalCodeCs.toDouble());
            totalPieChartMap.putIfAbsent(
                "Code A", () => totalCodeAs.toDouble());
            totalPieChartMap.putIfAbsent(
                "Waiting Room", () => totalWaitingRooms.toDouble());

            Map<String, double> twentyFourHourPieChartMap = new Map();
            twentyFourHourPieChartMap.putIfAbsent(
                "Code C", () => twentyFourHourTotalCodeCs.toDouble());
            twentyFourHourPieChartMap.putIfAbsent(
                "Code A", () => twentyFourHourTotalCodeAs.toDouble());
            twentyFourHourPieChartMap.putIfAbsent("Waiting Room",
                () => twentyFourHourTotalWaitingRooms.toDouble());

            List<Color> colorList = [
              Colors.red[200],
              Colors.yellow[200],
              Colors.green[200],
            ];

            var totalEnglish = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'english'))
                .length;
            var totalFrench = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'french'))
                .length;
            var totalArabic = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'arabic'))
                .length;
            var totalSpanish = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'spanish'))
                .length;
            var totalChinese = dataSnapshot.data.docs
                .where((d) => (d.data()['language'] == 'chinese'))
                .length;

            Map<String, double> languageMap = new Map();
            languageMap.putIfAbsent("English", () => totalEnglish.toDouble());
            languageMap.putIfAbsent("French", () => totalFrench.toDouble());
            languageMap.putIfAbsent("Arabic", () => totalArabic.toDouble());
            languageMap.putIfAbsent("Spanish", () => totalSpanish.toDouble());
            languageMap.putIfAbsent("Chinese", () => totalChinese.toDouble());

            List<Color> languageColorList = [
              Colors.orange[200],
              Colors.pink[200],
              Colors.cyan[200],
              Colors.lime[200],
              Colors.indigo[200],
            ];

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Screening Breakdown',
                      style: Theme.of(context).textTheme.headline5),
                  Text(
                    'Last 24 Hours',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  PieChart(
                      dataMap: twentyFourHourPieChartMap,
                      colorList: colorList,
                      showChartValuesInPercentage: false,
                      showLegends: true,
                      chartRadius: MediaQuery.of(context).size.width / 2),
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  PieChart(
                      dataMap: totalPieChartMap,
                      colorList: colorList,
                      showChartValuesInPercentage: false,
                      showLegends: true,
                      chartRadius: MediaQuery.of(context).size.width / 2),
                  Text(
                    'Total Screenings since deployment: ${totalScreenings.toString()}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Languages',
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(
                    height: 20,
                  ),
                  PieChart(
                      dataMap: languageMap,
                      colorList: languageColorList,
                      showChartValuesInPercentage: false,
                      showLegends: true,
                      chartRadius: MediaQuery.of(context).size.width / 2),
                ],
              ),
            );
        }
      },
    ),
  );
}

Widget _buildScreeningStream(BuildContext context, screeningStream) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: StreamBuilder(
      stream: screeningStream,
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasError)
          return Text('Error: ${streamSnapshot.error}');
        switch (streamSnapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            return Scrollbar(
              child: ListView(
                children:
                    streamSnapshot.data.docs.map((DocumentSnapshot document) {
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
  );
}
