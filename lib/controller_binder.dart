import 'package:get/get.dart';
import 'package:hackernews/controller/latest_news_controller.dart';
import 'package:hackernews/controller/top_news_controller.dart';
import 'package:hackernews/repo/latest_story_repo.dart';
import 'package:hackernews/repo/top_story_repo.dart';
import 'package:hackernews/services/remote_services.dart';

init() async {
  Get.lazyPut(() => RemoteServices());

  //repo
  Get.lazyPut(() => TopStoryRepo(remoteServices: Get.find()));
  Get.lazyPut(() => LatestStoryRepo(remoteServices: Get.find()));

  //Controller
  Get.lazyPut(() => TopNewsController(topStoryRepo: Get.find()));
  Get.lazyPut(() => LatestNewsController(latestStoryRepo: Get.find()));
}
