import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  int getCurrentIndex(BuildContext context){
    final String location = GoRouterState.of(context).matchedLocation;

    switch(location){
      case '/': return 0;
      case '/populares': return 1;
      case '/favorites': return 2;
      default: return 0;
    }
  }

  void onItemTab(BuildContext context, int index){
    switch(index){
      case 0: context.go('/');
      case 1: context.go('/populares');
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
        icon: Icon(Icons.thumbs_up_down_outlined),
        label: "Populares",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        label: "Favourites",
      ),
    ]);
  }
}
