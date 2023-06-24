import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imori_seikatsu/calendar/calendar_page.dart';
import 'package:imori_seikatsu/my_tank/my_tank_page.dart';
import 'package:imori_seikatsu/reminder/reminder_page.dart';
import 'package:imori_seikatsu/setting/setting_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '水槽LIFE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("ja")],
      home: const MyHomePage(title: '水槽LIFE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pageList = [
    const MyTankPage(),
    const CalendarPage(),
    const ReminderPage(),
  ];
  final List<String> _topLabelList = ['My Tank', 'カレンダー', 'リマインダ'];
  int selectedIndex = 0;
  final _auth = FirebaseAuth.instance;

  Future<void> _anonymousSignIn() async {
    final UserCredential anonymousUser = await _auth.signInAnonymously();
    if (kDebugMode) {
      print('uid: ${anonymousUser.user!.uid}');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _anonymousSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_topLabelList[selectedIndex]),
        centerTitle: true,
        actions: [
          if (selectedIndex == 0)
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingPage()));
              },
              icon: const Icon(Icons.settings),
            )
          else
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort),
            )
        ],
      ),
      body: _pageList[selectedIndex],
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My Tank'),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'カレンダー'),
              BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined), label: 'リマインダ'),
            ],
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }
}