import 'package:flutter/material.dart';
import 'package:snake_navigation_bar/snake_navigation_bar.dart';

import 'custom_icons.dart';
import 'demo_page/demo_page.dart';

class SnakeBarExample extends StatefulWidget {
  const SnakeBarExample({super.key});

  @override
  State<SnakeBarExample> createState() => _SnakeBarExampleState();
}

class _SnakeBarExampleState extends State<SnakeBarExample> {
  ///region config
  final _borderRadius = const BorderRadius.vertical(
    top: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 2;
  SnakeShape snakeShape = SnakeShape.circle();

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.black;
  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient = const LinearGradient(
    colors: [Colors.red, Colors.amber],
  );
  Gradient unselectedGradient = const LinearGradient(
    colors: [Colors.red, Colors.blueGrey],
  );

  ///endregion

  int pageIndex = 0;
  final _pages = {
    const Color(0xFFFDE1D7): DemoPage(
      text: 'This is our beloved SnakeBar.',
      description: 'Swipe right to see different styles',
      image: Image.asset('images/flutter1.png'),
    ),
    const Color(0xFFE4EDF5): DemoPage(
      text: 'It comes in all shapes and sizes...',
      description: 'Change indicator and bottom bar shape at your will.',
      image: Image.asset('images/flutter2.png'),
    ),
    const Color(0xFFE7EEED): DemoPage(
      text: '...not only the ones you see here',
      description:
          'Combine different shapes for unique and personalized style!.',
      image: Image.asset('images/flutter3.png'),
    ),
    const Color(0xFFF4E4CE): DemoPage(
      text: 'And it\'s all open source!',
      description:
          'Get the Flutter library on github.com/GoltVik/SnakeBottomNavigationBar',
      image: Image.asset('images/flutter4.png'),
    ),
  };
  final _destinations = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: 'tickets',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.calendar),
      label: 'calendar',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.home),
      label: 'home',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.podcasts),
      label: 'microphone',
    ),
    BottomNavigationBarItem(
      icon: Icon(CustomIcons.search),
      label: 'search',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: AnimatedContainer(
        color: _pages.keys.elementAt(pageIndex),
        duration: const Duration(seconds: 1),
        child: PageView(
          onPageChanged: _onPageChanged,
          children: _pages.values.toList(),
        ),
      ),

      /// Important part
      bottomNavigationBar: SnakeNavigationBar.color(
        // useSafeArea: false,
        // height: 100,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape is IndicatorSnakeShape ? selectedColor : null,
        unselectedItemColor: unselectedColor,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: _selectedItemPosition,
        onTap: (index) => _selectedItemPosition = index,
        items: _destinations,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _onPageChanged(int page) {
    pageIndex = page;
    switch (page) {
      case 0:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.floating;
          snakeShape = SnakeShape.circle();
          padding = const EdgeInsets.all(12);
          bottomBarShape = RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          );
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;
      case 1:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.circle();
          padding = EdgeInsets.zero;
          bottomBarShape = RoundedRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;

      case 2:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.rectangle();
          padding = EdgeInsets.zero;
          bottomBarShape = BeveledRectangleBorder(borderRadius: _borderRadius);
          showSelectedLabels = true;
          showUnselectedLabels = true;
        });
        break;
      case 3:
        setState(() {
          snakeBarStyle = SnakeBarBehaviour.pinned;
          snakeShape = SnakeShape.indicator();
          padding = EdgeInsets.zero;
          bottomBarShape = null;
          showSelectedLabels = false;
          showUnselectedLabels = false;
        });
        break;
    }
  }
}
