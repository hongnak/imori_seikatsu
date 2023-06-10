import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:imori_seikatsu/my_data_detail/my_data_detail_page.dart';
import 'package:imori_seikatsu/my_tank/my_tank_page.dart';
import 'package:imori_seikatsu/reminder/reminder_page.dart';
import 'package:imori_seikatsu/setting/setting_page.dart';
import 'calendar/calendar_page.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '水槽LIFE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: const [Locale("en"), Locale("ja")],
      home: const MyHomePage(title: '水槽LIFE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pageList = [const MyTankPage(), const CalendarPage(), const ReminderPage()];
  final List<String> _topLabelList = ['Myアクアリウム', 'カレンダー', 'リマインダ'];
  int selectedIndex = 0;
  final _auth = FirebaseAuth.instance;

  Future<void> _anonymousSignIn() async {
    UserCredential anonymousUser = await _auth.signInAnonymously();
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
          selectedIndex == 0
              ?
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingPage()));
              },
              icon: const Icon(Icons.settings)
          )
              :
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort))
        ],
      ),
      body: _pageList[selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: const Icon(Icons.home), label: _topLabelList[0]),
                BottomNavigationBarItem(icon: const Icon(Icons.calendar_month), label: _topLabelList[1]),
                BottomNavigationBarItem(icon: const Icon(Icons.note_alt_outlined), label: _topLabelList[2]),
              ],
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}