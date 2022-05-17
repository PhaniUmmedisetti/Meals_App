import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
// import './screens/meal_detail_screen.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) { 
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex != -1) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      print("eneted else meal id $mealId");
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DeliMeals',
        theme: ThemeData(
            canvasColor: const Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(21, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(21, 51, 51, 1),
                ),
                headline1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                )),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
                .copyWith(secondary: Colors.amber)),
        // home: CategoriesScreen(),
        routes: {
          '/': (ctx) => TabsScreen(_favouriteMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavourite, _isMealFavourite),
          FiltersScreen.routeName: (ctx) =>
              FiltersScreen(_setFilters, _filters),
        },
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        onGenerateRoute: (RouteSettings) {
          print(RouteSettings.arguments);
          // if(RouteSettings.name == '/meal-detail') {
          //   return ...;
          // } else if (settings.name == 'something=else') {
          //   return ...;
          // }
          // return MaterialPageRoute(
          //   builder: (ctx) => CategoriesScreen(),
          // );
        },
        // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
        onUnknownRoute: (RouteSettings) {
          return MaterialPageRoute(
            builder: (ctx) => CategoriesScreen(),
          );
        });
  }
}
