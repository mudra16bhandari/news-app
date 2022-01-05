import 'package:flutter/material.dart';
import 'package:news/widgets/favourites.dart';
import 'package:news/widgets/news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = -1;
  List<int> favs = [];

  onTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }

  getFavs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? storedFavs = sharedPreferences.getStringList('favs');
    if (storedFavs == null) {
      sharedPreferences.setStringList('favs', []);
    } else {
      favs = storedFavs.map((e) => int.parse(e)).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   getFavs();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getFavs(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? currentTab == -1
                  ? LoadingScreen(favs: favs)
                  : currentTab == 0
                      ? NewsScreen(favs: favs)
                      : Favourites(favs: favs)
              : const CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentTab == -1 ? 0 : currentTab,
        onTap: onTapped,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "News",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              label: "Favs")
        ],
      ),
    );
  }
}
