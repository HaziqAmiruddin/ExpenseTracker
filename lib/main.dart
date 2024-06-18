//Below coding for lock rotation

// import 'package:flutter/material.dart';
// import 'widgets/expenses.dart';
// //package display responsive(rotate view)
// //lock view rotation
// import 'package:flutter/services.dart';

// var kColorScheme =
//     ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 56, 181));

// var kDarkColorScheme = ColorScheme.fromSeed(
//   //need to add this because as default flutter configure for light theme
//   //need to inform using this is color scheme for dark mode
//   brightness: Brightness.dark,
//   seedColor: const Color.fromARGB(255, 5, 99, 125),
// );

// void main() {
//   //to make sure the lock screen rotation function work fine
//   WidgetsFlutterBinding.ensureInitialized();
//   //for lock view
//   SystemChrome.setPreferredOrientations([
//     //lock screen rotation to only portraitup
//     DeviceOrientation.portraitUp,
//     //put all the coding inside the lock rotation part.
//     //so only lock rotation can read all the coding
//   ]).then((fn) {
//     runApp(
//       MaterialApp(
//         //remove bedug banner
//         debugShowCheckedModeBanner: false,
//         //default theme
//         //theme: ThemeData(useMaterial3: true),
//         //customize theme
//         //below is dark mode theme
//         darkTheme: ThemeData.dark().copyWith(
//           useMaterial3: true,
//           //need to add below because at expenses_list. we said margin will not be null using !
//           //so when dark mode enable and in dark mode have no information regarding the margin value.
//           //result error
//           colorScheme: kDarkColorScheme,
//           cardTheme: const CardTheme().copyWith(
//             //for dark mode
//             color: kDarkColorScheme.secondaryContainer,
//             //for light mode
//             //color: kColorScheme.secondaryContainer,
//             margin: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 8,
//             ),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               //background color
//               backgroundColor: kDarkColorScheme.primaryContainer,
//               //color inside the content
//               foregroundColor: kDarkColorScheme.onPrimaryContainer,
//             ),
//           ),
//         ),
//         //below is light mode
//         theme: ThemeData().copyWith(
//             useMaterial3: true,
//             //for color bacground
//             //scaffoldBackgroundColor: const Color.fromARGB(255, 81, 101, 202),
//             //for details such as the word color
//             colorScheme: kColorScheme,
//             appBarTheme: const AppBarTheme().copyWith(
//               backgroundColor: kColorScheme.onPrimaryContainer,
//               foregroundColor: kColorScheme.primaryContainer,
//             ),
//             cardTheme: const CardTheme().copyWith(
//               color: kColorScheme.secondaryContainer,
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 8,
//               ),
//             ),
//             elevatedButtonTheme: ElevatedButtonThemeData(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: kColorScheme.primaryContainer,
//               ),
//             ),
//             textTheme: ThemeData().textTheme.copyWith(
//                   titleLarge: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: kColorScheme.onSecondaryContainer,
//                     fontSize: 16,
//                   ),
//                 )),
//         //which theme to use ?
//         //use theme mode parameter to user select which mode want to use
//         //below is default, no need to write
//         //themeMode: ThemeMode.system,
//         home: const Expenses(),
//       ),
//     );
//   });
// }

//below coding for rotation improvement code

import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 56, 181));

var kDarkColorScheme = ColorScheme.fromSeed(
  //need to add this because as default flutter configure for light theme
  //need to inform using this is color scheme for dark mode
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      //remove bedug banner
      debugShowCheckedModeBanner: false,
      //default theme
      //theme: ThemeData(useMaterial3: true),
      //customize theme
      //below is dark mode theme
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        //need to add below because at expenses_list. we said margin will not be null using !
        //so when dark mode enable and in dark mode have no information regarding the margin value.
        //result error
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          //for dark mode
          color: kDarkColorScheme.secondaryContainer,
          //for light mode
          //color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //background color
            backgroundColor: kDarkColorScheme.primaryContainer,
            //color inside the content
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      //below is light mode
      theme: ThemeData().copyWith(
          useMaterial3: true,
          //for color bacground
          //scaffoldBackgroundColor: const Color.fromARGB(255, 81, 101, 202),
          //for details such as the word color
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16,
                ),
              )),
      //which theme to use ?
      //use theme mode parameter to user select which mode want to use
      //below is default, no need to write
      //themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
