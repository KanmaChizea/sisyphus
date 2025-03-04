import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';

class CustomTab extends StatefulWidget {
  const CustomTab({
    super.key,
    this.scrollable = false,
    this.tabWidth,
    required this.tabTitles,
    this.tabHeight,
    required this.children,
  }) : assert(
         children.length == tabTitles.length,
         'children and tabTitles must have the same length', // so the tabs can have equal width
       );
  final bool scrollable;
  final double? tabWidth;
  final List<String> tabTitles;
  final double? tabHeight;
  final List<Widget> children;
  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.tabTitles.length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.tabHeight ?? 40,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Theme.of(context).appColors.border,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 1,
                color: Colors.black12.withValues(alpha: 0.04),
              ),
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 8,
                color: Colors.black12.withValues(alpha: 0.12),
              ),
            ],
          ),
          child: TabBar(
            isScrollable: widget.scrollable,
            tabAlignment:
                widget.scrollable ? TabAlignment.start : TabAlignment.fill,
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).appColors.foreground,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            dividerHeight: 0,
            labelColor: Theme.of(context).appColors.text,
            unselectedLabelColor: Theme.of(context).appColors.grey1,
            labelStyle: const TextStyle(
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w500,
            ),
            tabs:
                widget.tabTitles
                    .map(
                      (title) => SizedBox(
                        width: widget.tabWidth,
                        child: Tab(text: title),
                      ),
                    )
                    .toList(),
          ),
        ),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: _tabController,
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
