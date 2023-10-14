import 'package:alakhdari/custom_button.dart';
import 'package:alakhdari/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:alakhdari/constants.dart';
// import 'package:alakhdari/pages/screens/home_screen.dart';
// import 'package:alakhdari/pages/widgets/rounded_button.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'ALAKHDARI',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: Theme.of(context).textTheme.apply(
//               displayColor: kBlackColor,
//             ),
//       ),
//       home: WelcomeScreen(),
//     );
//   }
// }

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/main.jpg"),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RichText(
//               text: TextSpan(
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 children: const [
//                   TextSpan(
//                     text: "Alakhdari\n",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 70,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * .2),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * .6,
//               child: RoundedButton(
//                 text: "start reading",
//                 fontSize: 20,
//                 press: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return HomeScreen();
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  NotificationManager().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((Message) => {
          if (Message != null) {print(Message.data['title'])}
        });

    FirebaseMessaging.onMessage.listen((Message) {
      if (Message.notification != null) {
        print(Message.notification!.body);
        print(Message.notification!.title);
      }
      NotificationManager().initNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Notification"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              onPressed: () {
                NotificationManager().simpleNotificationShow();
              },
              title: "Simple Notification"),
          const SizedBox(height: 30),
          CustomButton(
              onPressed: () {
                NotificationManager().bigPictureNotificationShow();
              },
              title: "Big Picture Notification"),
          const SizedBox(height: 30),
          CustomButton(
              onPressed: () {
                NotificationManager().multipleNotificationShow();
              },
              title: "Multiple Notification")
        ],
      ),
    );
  }
}
