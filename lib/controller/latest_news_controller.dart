import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hackernews/data/model/ListOfIdResp.dart';
import 'package:hackernews/repo/latest_story_repo.dart';
import '../data/model/ItemModel.dart';

class LatestNewsController extends GetxController implements GetxService {
  LatestStoryRepo latestStoryRepo;

  LatestNewsController({required this.latestStoryRepo});

  bool _latestNewsLoading = false;

  bool get latestNewsLoading => _latestNewsLoading;

  List<int> _latestStoryIdList = List<int>.empty(growable: true);

  List<int> get latestStoryIdList => _latestStoryIdList;

  final List<ItemModel> _latestStoryItemList = List<ItemModel>.empty(growable: true);

  List<ItemModel> get latestStoryItemList => _latestStoryItemList;

  getLatestNewsList() async {
    _latestNewsLoading = true;
    update();
    var listResp = await latestStoryRepo.fetchLatestNewsList();
    if (listResp.statusCode == 200) {
      _latestStoryIdList = listOfIdRespFromMap(listResp.body);
      // taking 1st 8 item to load
      var tempList = _latestStoryIdList.take(8).toList();
      // fetching individual data
      fetchStoryObj(tempList);
    }
  }

  void loadMoreStories() {
    var currentLength = _latestStoryItemList.length;
    var startingIndex = currentLength;
    var endingIndex = (_latestStoryIdList.length < (startingIndex + 7))
        ? _latestStoryIdList.length
        : startingIndex + 8;
    if (currentLength < _latestStoryIdList.length) {
      var tempList = _latestStoryIdList.sublist(startingIndex, endingIndex);
      _latestNewsLoading = false;
      update();
      fetchStoryObj(tempList);
      print(currentLength);
      print(endingIndex);
    } else {
      Get.snackbar(
          snackPosition: SnackPosition.BOTTOM,
          'Don\'t Scroll',
          'You are in last page');
    }
  }

  Future<ItemModel> fetchSingleStory(int storyId) async {
    final response = await latestStoryRepo.fetchASingleStory(storyId);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      return itemModelFromMap(response.body);
    } else {
      throw Exception('Failed to load story');
    }
  }

  fetchStoryObj(List<int> idList) async {
    var latestStoryIds = idList;

    List<Future<ItemModel>> futureStories =
        latestStoryIds.map((id) => fetchSingleStory(id)).toList();

    List<ItemModel> stories = await Future.wait(futureStories);
    _latestStoryItemList.addAll(stories);
    _latestNewsLoading = false;
    update();
  }
}
