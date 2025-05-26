import 'package:flutter/material.dart';

class PwaVirtualizedList extends StatefulWidget {
  final int itemCount;
  final double itemHeight;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const PwaVirtualizedList({
    required this.itemCount,
    required this.itemHeight,
    required this.itemBuilder,
    super.key,
  });

  @override
  PwaVirtualizedListState createState() => PwaVirtualizedListState();
}

class PwaVirtualizedListState extends State<PwaVirtualizedList> {
  late ScrollController _scrollController;
  int _startIndex = 0;
  int _endIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateVisibleItems);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateVisibleItems();
    });
  }

  void _calculateVisibleItems() {
    if (!mounted || !_scrollController.hasClients) return;

    final double viewportHeight =
        context.size?.height ?? MediaQuery.of(context).size.height;

    final int firstVisibleIndex =
        (_scrollController.offset / widget.itemHeight).floor();
    final int lastVisibleIndex =
        ((_scrollController.offset + viewportHeight) / widget.itemHeight)
            .ceil();

    setState(() {
      _startIndex = firstVisibleIndex.clamp(0, widget.itemCount - 1);
      _endIndex = lastVisibleIndex.clamp(0, widget.itemCount - 1);
    });
  }

  void _updateVisibleItems() {
    if (_scrollController.hasClients) {
      _calculateVisibleItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const Key('virtualized_list'),
      controller: _scrollController,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        if (index >= _startIndex && index <= _endIndex) {
          return widget.itemBuilder(context, index);
        }
        return SizedBox(height: widget.itemHeight);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
