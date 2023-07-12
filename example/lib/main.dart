import 'package:example/SharedPrefEnum.dart';
import 'package:flutter/material.dart';
import 'package:simple_shared_pref/simple_shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SimpleSharedPref().init(allowEncryptAndDecrypt: true);
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
    await SimpleSharedPref().setValue<int>(value: 2, key: SharedPrefEnum.id);
    await SimpleSharedPref()
        .setValue<double>(value: 2.2, key: SharedPrefEnum.price);
    await SimpleSharedPref()
        .setValue<bool>(value: true, key: SharedPrefEnum.selected);
    await SimpleSharedPref()
        .setValue<String>(value: 'Product', key: SharedPrefEnum.name);
    await SimpleSharedPref().setValue<List<String>>(
        value: ['Product1', 'Product2', 'Product3'],
        key: SharedPrefEnum.namesList);
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
                    'id: ${SimpleSharedPref().getValue<int>(key: SharedPrefEnum.id).toString()}'),
                Text(
                    'price: ${SimpleSharedPref().getValue<double>(key: SharedPrefEnum.price).toString()}'),
                Text(
                    'product: ${SimpleSharedPref().getValue<String>(key: SharedPrefEnum.name).toString()}'),
                Text(
                    'selected: ${SimpleSharedPref().getValue<bool>(key: SharedPrefEnum.selected).toString()}'),
                Text(SimpleSharedPref()
                    .getValue<List<String>>(key: SharedPrefEnum.namesList)
                    .toString()),
                Text(SimpleSharedPref()
                    .getValue<List<String>>(key: SharedPrefEnum.namesList)
                    .toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
