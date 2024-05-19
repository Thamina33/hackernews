import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hackernews/controller/top_news_controller.dart';
import 'package:hackernews/presentation/widgets/news_item_tile.dart';

import '../widgets/ShimmerLoadingScreen.dart';

class TopNewsTab extends StatefulWidget {
  const TopNewsTab({super.key});

  @override
  State<TopNewsTab> createState() => _TopNewsTabState();
}

class _TopNewsTabState extends State<TopNewsTab> {
  final ScrollController _scrollController = ScrollController();

  void _loadMoreData() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      if (kDebugMode) {
        print("=======>object");
      }
      Get.find<TopNewsController>().loadMoreStories();
    }
  }

  @override
  void initState() {
    super.initState();
    Get.find<TopNewsController>().getTopStoryList();
    _scrollController.addListener(_loadMoreData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<TopNewsController>(builder: (topNewsController) {
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
                var newsItem = topNewsController.topStoryItemList[index];
                return NewsItemTile(newsItem);
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 12,
              ),
              itemCount: topNewsController.topStoryItemList.length,
            ),
            if (topNewsController.topNewsLoading) ...[
              buildGridPlaceholder(context, size: 1)
            ]

          ],
        );

      }),
    );
  }
}
