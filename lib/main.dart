import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sharedpreferences_example/styles.dart' as styles;

main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  final String title;

  const Home({
    Key key,
    this.title = 'Shared Preferences',
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _dataController = TextEditingController();
  String _savedData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 25,
          right: 25,
          bottom: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: _dataController,
                    decoration: InputDecoration(
                        labelText: 'Type Something',
                        labelStyle: styles.hintStyle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: styles.dataTextStyle.color,
                          ),
                        )),
                  ),
                  Text(
                    '${_savedData ?? 'Empty Data'}',
                    style: styles.dataTextStyle,
                  ),
                  FlatButton(
                      color: Colors.deepOrange,
                      onPressed: () {
                        saveData(_dataController.text);
                        setState(() {});
                      },
                      child: Text(
                        'Save',
                        style: styles.buttonTextWhite,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String info = preferences.getString('data');
    setState(() {
      if (info != null && info.isNotEmpty)
        _savedData = info;
      else
        _savedData = 'Empty';
    });
  }

  void saveData(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message);
  }
}
