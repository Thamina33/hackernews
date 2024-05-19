import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackernews/controller/latest_news_controller.dart';

import '../widgets/ShimmerLoadingScreen.dart';
import '../widgets/news_item_tile.dart';

class LatestNewsTab extends StatefulWidget {
  const LatestNewsTab({super.key});

  @override
  State<LatestNewsTab> createState() => _LatestNewsTabState();
}

class _LatestNewsTabState extends State<LatestNewsTab> {
  final ScrollController _scrollController = ScrollController();

  void _loadMoreData() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      if (kDebugMode) {
        print("=======>object");
      }
      Get.find<LatestNewsController>().loadMoreStories();
    }
  }
  @override
  void initState() {
    super.initState();
    Get.find<LatestNewsController>().getLatestNewsList();
    _scrollController.addListener(_loadMoreData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LatestNewsController>(builder: (latestNewsController) {
        return  ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          children: [
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              itemBuilder: (context, index) {
                var newsItem = latestNewsController.latestStoryItemList[index];
                return NewsItemTile(newsItem);
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 12,
              ),
              itemCount: latestNewsController.latestStoryItemList.length,
            ),
            if (latestNewsController.latestNewsLoading) ...[
              buildGridPlaceholder(context, size: 1)
            ]

          ],
        );

      }),
    );
  }
}
