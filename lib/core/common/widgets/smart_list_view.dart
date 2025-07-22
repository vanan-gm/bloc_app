import 'package:bloc_app/core/common/widgets/three_dots_animation.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SmartListView<T> extends StatefulWidget {
  final ScrollController scrollController;
  final RefreshCallback? onRefresh;
  final Function(int page)? onLoadMore;
  final List<T> dataList;
  // final int totalItem;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets? padding;
  final bool hasReachedEnd;
  final Widget? loadingWidget;

  late final int itemCount;
  late bool isLimitedData;
  late bool isLoadMore;
  late bool isRefresh;

  SmartListView({
    super.key,
    required this.scrollController,
    required this.itemBuilder,
    required this.dataList,
    // required this.totalItem,
    this.onRefresh,
    this.onLoadMore,
    this.padding,
    this.hasReachedEnd = false,
    this.loadingWidget,
  }) {
    isLimitedData = false;
    isLoadMore = false;
    isRefresh = false;

    // if (dataList.length >= totalItem) {
    //   isLimitedData = true;
    // }

    if(hasReachedEnd){
      isLimitedData = true;
    }

    itemCount = (dataList.isEmpty || isLimitedData || dataList.length % AppConstants.itemPerPage != 0) ? dataList.length : dataList.length + 1;
  }

  @override
  State<SmartListView> createState() => _SmartListViewState();
}

class _SmartListViewState extends State<SmartListView> {
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    widget.isLoadMore = false;
    widget.isRefresh = false;

    widget.scrollController.addListener(() {
      if (!widget.isLimitedData &&
          !widget.isLoadMore &&
          widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent) {
        widget.isLoadMore = true;

        _currentPage++;
        widget.onLoadMore?.call(_currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    color: AppColors.gradient1,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 2));
      _currentPage = 1;
      widget.isLimitedData = false;
      widget.isLoadMore = false;
      widget.isRefresh = true;

      if (widget.isRefresh) {
        widget.onRefresh?.call();
      }

    },
    child: ListView.builder(
      itemBuilder: (context, index) {
        if (index == widget.dataList.length) {
          return widget.loadingWidget ?? Center(
            child: ThreeDotsAnimation(
              color: AppColors.gradient1,
              size: 12.0,
              bounceHeight: 12.0,
            ),
          );
        } else {
          return widget.itemBuilder(context, index);
        }
      },
      itemCount: widget.itemCount,
      padding: widget.padding,
      controller: widget.scrollController,
    ),
  );
}