import 'package:flutter/material.dart';
import 'package:hackernews/presentation/screens/latest_news_tab.dart';
import 'package:hackernews/presentation/screens/top_news_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              floating: true,
              pinned: true,
              title: Text(
                'Hacker News',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: false,
              titleSpacing: 16,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.blueGrey,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [Tab(text: 'Top News'), Tab(text: 'Latest News')],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: [TopNewsTab(), LatestNewsTab()],
        ),
      )),
    );
  }
}
