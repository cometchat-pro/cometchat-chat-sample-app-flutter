import 'package:cometchat_uikit_shared/cometchat_uikit_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

///Common Controller Class which holds the logic to fetch data from different request builders
abstract class CometChatListController<T1, T2> extends GetxController
    with CometChatListProtocol<T1>, KeyIdentifier<T1, T2> {
  List<T1> list = [];
  bool isLoading = true;
  bool hasMoreItems = true;
  bool hasError = false;
  Exception? error;
  late dynamic request;
  Function(Exception)? onError;
  bool isFetchNext = true;

  CometChatListController(this.request,
      {this.onError, this.isFetchNext = true});

  @override
  List<T1> getList() {
    return list;
  }

  @override
  void onInit() {
    loadMoreElements();
    super.onInit();
  }

  @override
  int getMatchingIndex(T1 element) {
    int matchingIndex = list.indexWhere((item) => match(item, element));
    return matchingIndex;
  }

  @override
  int getMatchingIndexFromKey(String key) {
    int matchingIndex = list.indexWhere((item) => getKey(item) == key);
    return matchingIndex;
  }

  _onSuccess(List<T1> fetchedList, bool Function(T1 element)? isIncluded) {
    if (fetchedList.isEmpty) {
      isLoading = false;
      hasMoreItems = false;
      update();
    } else {
      isLoading = false;
      hasMoreItems = true;

      if (isIncluded == null) {
        list.addAll(fetchedList);
      } else {
        for (var element in fetchedList) {
          if (isIncluded(element) == true) {
            list.add(element);
          }
        }
      }

      update();
    }
  }

  _onError(CometChatException e) {
    if (kDebugMode) {
      print("Error ${e.details}");
    }
    error = e;
    hasError = true;
    update();
  }

  @override
  loadMoreElements({bool Function(T1 element)? isIncluded}) async {
    isLoading = true;
    try {
      if (isFetchNext) {
        await request.fetchNext(
            onSuccess: (List<T1> fetchedList) {
              _onSuccess(fetchedList, isIncluded);
            },
            onError: onError ?? _onError);
      } else {
        await request.fetchPrevious(
            onSuccess: (List<T1> fetchedList) {
              _onSuccess(fetchedList, isIncluded);
            },
            onError: onError ?? _onError);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("Error in Catch$e}");
      }
      error = CometChatException("ERR", s.toString(), "Error");
      hasError = true;
      isLoading = false;
      hasMoreItems = false;
      update();
    }
  }

  @override
  updateElement(T1 element, {int? index}) {
    int result;
    if (index == null) {
      result = getMatchingIndex(element);
    } else {
      result = index;
    }

    if (result != -1) {
      list[result] = element;
      update();
    }
  }

  @override
  addElement(T1 element, {int index = 0}) {
    list.insert(index, element);
    update();
  }

  @override
  removeElement(T1 element) {
    int matchingIndex = getMatchingIndex(element);
    if (matchingIndex != -1) {
      list.removeAt(matchingIndex);
      update();
    }
  }

  updateElementAt(T1 element, int index) {
    list[index] = element;
    update();
  }

  @override
  removeElementAt(int index) {
    list.removeAt(index);
    update();
  }
}
