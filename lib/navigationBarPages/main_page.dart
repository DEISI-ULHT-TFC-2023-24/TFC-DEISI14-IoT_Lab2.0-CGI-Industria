import 'package:flutter/material.dart';
import 'package:tfc_industria/navigationBarPages/navigationsBarList.dart';

class MainPages extends StatefulWidget {
  MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50), // Aumenta a altura do AppBar
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            // Ajusta o título para baixo
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(width: 20),
                Text(
                  'Assets',
                  style: TextStyle(
                      color:
                          Colors.black), // Ajuste para sua preferência de cor
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Implementar ação de pesquisa
              },
            ),
            IconButton(
              icon: Icon(Icons.precision_manufacturing),
              onPressed: () {
                // Implementar mais opções
              },
            ),
            IconButton(
              icon: Icon(Icons.message_outlined),
              onPressed: () {
                // Implementar mais opções
              },
            ),
          ],
        ),
      ),
      body: navigationsBarList[_selectedIndex].widget,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: navigationsBarList
            .map((pages) => NavigationDestination(
                icon: Icon(pages.icon), label: pages.title))
            .toList(),
      ),
    );
  }
}
