import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../data/model/ItemModel.dart';
import '../data/model/ListOfIdResp.dart';
import '../repo/top_story_repo.dart';

class TopNewsController extends GetxController implements GetxService {
  final TopStoryRepo topStoryRepo;

  TopNewsController({required this.topStoryRepo});

  bool _topNewsLoading = false;

  bool get topNewsLoading => _topNewsLoading;

  List<int> _topNewsIdList = List<int>.empty(growable: true);

  List<int> get topNewsIdList => _topNewsIdList;

  final List<ItemModel> _topStoryItemList =
      List<ItemModel>.empty(growable: true);

  List<ItemModel> get topStoryItemList => _topStoryItemList;

  getTopStoryList() async {
    _topNewsLoading = true;
    update();

    var listResp = await topStoryRepo.fetchTopNewsList();

    if (listResp.statusCode == 200) {
      _topNewsIdList = listOfIdRespFromMap(listResp.body);
      // taking 1st 8 time to load
      var tempList = _topNewsIdList.take(8).toList();
      // fetching individual data
      fetchTopStoryObj(tempList);
    }
  }

  void loadMoreStories() {
    var currentLength = _topStoryItemList.length;
    var startingIndex = currentLength;
    var endingIndex = (_topNewsIdList.length < (startingIndex + 7))
        ? _topNewsIdList.length
        : startingIndex + 8;

    if (currentLength < _topNewsIdList.length) {
      var tempList = _topNewsIdList.sublist(startingIndex, endingIndex);
      _topNewsLoading = false;
      update();
      fetchTopStoryObj(tempList);
      if (kDebugMode) {
        print(currentLength);
      }
      if (kDebugMode) {
        print(endingIndex);
      }
    } else {
      Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          'Don\'t Scroll',
          'You are in last page');
    }
  }

  Future<ItemModel> fetchSingleStory(int storyId) async {
    final response = await topStoryRepo.fetchASingleStory(storyId);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return itemModelFromMap(response.body);
    } else {
      throw Exception('Failed to load story');
    }
  }

  fetchTopStoryObj(List<int> idList) async {
    var topStoryIds = idList;

    List<Future<ItemModel>> futureStories =
        topStoryIds.map((id) => fetchSingleStory(id)).toList();
    List<ItemModel> stories = await Future.wait(futureStories);
    _topStoryItemList.addAll(stories);
    _topNewsLoading = false;
    update();
  }
}
