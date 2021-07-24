import 'package:flutter/material.dart';
import 'package:great_places/providers/GreatPlacesProvider.dart';
import 'package:great_places/routes/AppRoutes.dart';
import 'package:great_places/screens/PlaceDetailScreen.dart';
import 'package:great_places/screens/PlaceFormScreen.dart';
import 'package:great_places/screens/PlacesListScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AppRoutes.PlaceForm: (ctx) => PlaceFormScreen(),
          AppRoutes.PlaceDetail: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
