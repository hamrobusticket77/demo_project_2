// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefresh extends StatefulWidget {
  final Widget child;

  final Future<void> Function() onRefresh;
  const PullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<PullToRefresh> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PullToRefresh> {
  RefreshController refreshController = RefreshController();

  @override
  void dispose() {
    refreshController.refreshCompleted();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: () async {
        widget.onRefresh();

        await Future.delayed(const Duration(seconds: 1)).whenComplete(() {
          refreshController.refreshCompleted();
        });
      },
      child: widget.child,
    );
  }
}
