import 'package:cinemapedia/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context){
    final String location = GoRouterState.of(context).matchedLocation;

    switch(location){
      case '/': return 0;
      case '/categories': return 1;
      case '/favorites': return 2;
      default: return 0;
    }
  }

  void onItemTab(BuildContext context, int index){
    switch(index){
      case 0: context.go('/');
      //case 1: context.go('/categories');
      case 2: context.go('/favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: getCurrentIndex(context),
      onTap: (value)=> onItemTab(context, value),
      items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.tv),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.label_outline),
        label: "Categories",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        label: "Favourites",
      ),
    ]);
  }
}
