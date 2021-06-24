import 'package:example/SharedPrefEnum.dart';
import 'package:flutter/material.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SimpleSharedPref simpleSharedPref = SimpleSharedPref();
  await simpleSharedPref.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setDataToShared();
  }

  void setDataToShared() async {
    await SimpleSharedPref()
        .setInt(value: 2, key: SharedPrefEnum.id.toString());
    await SimpleSharedPref().setDouble(
        value: 2.2,
        key: SharedPrefEnum.price.toString());
    await SimpleSharedPref()
        .setBool(value: true, key: SharedPrefEnum.selected.toString());
    await SimpleSharedPref()
        .setString(value: 'Product', key: SharedPrefEnum.name.toString());
    await SimpleSharedPref().setStringList(
        value: ['Product1', 'Product2', 'Product3'],
        key: SharedPrefEnum.namesList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'simple shared pref',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'simple shared pref Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListView(
              padding: EdgeInsets.all(20.0),
              shrinkWrap: true,
              children: [
                Text(
                    'id: ${SimpleSharedPref().getInt(key: SharedPrefEnum.id.toString())!.toString()}'),
                Text(
                    'price: ${SimpleSharedPref().getDouble(key: SharedPrefEnum.price.toString())!.toString()}'),
                Text(
                    'product: ${SimpleSharedPref().getString(key: SharedPrefEnum.name.toString())!.toString()}'),
                Text(
                    'selected: ${SimpleSharedPref().getBool(key: SharedPrefEnum.selected.toString())!.toString()}'),
                Text(SimpleSharedPref()
                    .getStringList(key: SharedPrefEnum.namesList.toString())!
                    .toString()),
                Text(SimpleSharedPref().contain(key: SharedPrefEnum.namesList.toString()).toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
