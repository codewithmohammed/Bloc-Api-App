import 'package:bloc_api_app/features/home/home_page.dart';
import 'package:bloc_api_app/features/posts/ui/post_page.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> _selectedIndexNotifier = ValueNotifier(0);

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // void _onItemTapped(int index) {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const PostPage(),
      // const MessagePage(),
      // const SettingsPage(),
    ];
    return Scaffold(
        body: ValueListenableBuilder<int>(
          valueListenable: _selectedIndexNotifier,
          builder: (context, selectedIndex, _) {
            return IndexedStack(
              index: selectedIndex,
              children: pages,
            );
          },
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedIndexNotifier,
              builder: (context, selectedIndex, _) {
                return BottomNavigationBar(
                  currentIndex: _selectedIndexNotifier.value,

                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  //backgroundColor: Color(0xFF6200EE),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black.withOpacity(0.50),
                  selectedFontSize: 16,
                  selectedIconTheme: const IconThemeData(
                      color: Colors.black, size: 25, opacity: 1),
                  unselectedIconTheme: const IconThemeData(
                      color: Colors.black, size: 20, opacity: 0.5),

                  unselectedFontSize: 14,
                  onTap: (index) {
                    _selectedIndexNotifier.value = index;
                  },
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: 'Post Page',
                      icon: Icon(Icons.post_add_outlined),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
