// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'UserRepository.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _user = Provider.of<UserRepository>(context);

    var isLargeScreen;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth > 800 && screenWidth > screenHeight) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }

    // } else {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: isLargeScreen ? 800 : screenWidth * 0.8,
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _user.locations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RaisedButton(
                            child: AutoSizeText(
                              _user.locations.values.toList()[index],
                              minFontSize: isLargeScreen ? 50 : 30,
                            ),
                            onPressed: () {
                              _user.chosenLocation =
                                  _user.locations.keys.toList()[index];
                              Navigator.pushNamed(context, '/dashboard');
                            },
                            textColor: Colors.white,
                            color: Colors.teal,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.teal)),
                            padding: const EdgeInsets.all(10.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
