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
    this.tabStyle,
    this.tabContainerStyle,
    this.tabBarIndicatorSize,
    this.initialIndex = 0,
  }) : assert(
         children.length == tabTitles.length,
         'children and tabTitles must have the same length', // so the tabs can have equal width
       );

  /// Whether the tabs should be scrollable or not. Defaults to false
  /// If false, the tabs will occupy the width of the screen and each tab will be of equal width
  /// if true, the tabs will be scrollable and the tabTitles will be used to determine the width of the tabs
  final bool scrollable;

  /// The width of the tabs. Provide this if [isScrollable] is true and you want the tabs to have equal width.
  final double? tabWidth;

  final List<String> tabTitles;

  /// The height of the tabs
  final double? tabHeight;
  final List<Widget> children;

  /// Styles a single tab itself
  final BoxDecoration? tabStyle;

  /// Styles the container of the tab
  final BoxDecoration? tabContainerStyle;

  final TabBarIndicatorSize? tabBarIndicatorSize;

  final int initialIndex;
  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
    _tabController = TabController(
      vsync: this,
      length: widget.tabTitles.length,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  BoxDecoration buildTabDecoration() {
    return BoxDecoration(
      borderRadius: widget.tabStyle?.borderRadius ?? BorderRadius.circular(10),
      color: widget.tabStyle?.color ?? Theme.of(context).appColors.foreground,
      border: widget.tabStyle?.border,
      boxShadow: widget.tabStyle?.boxShadow,
      gradient: widget.tabStyle?.gradient,
      shape: widget.tabStyle?.shape ?? BoxShape.rectangle,
      image: widget.tabStyle?.image,
      backgroundBlendMode: widget.tabStyle?.backgroundBlendMode,
    );
  }

  BoxDecoration buildTabContainerDecoration() {
    return BoxDecoration(
      color:
          widget.tabContainerStyle?.color ?? Theme.of(context).appColors.border,
      borderRadius:
          widget.tabContainerStyle?.borderRadius ?? BorderRadius.circular(10),
      border: widget.tabContainerStyle?.border,
      image: widget.tabContainerStyle?.image,
      gradient: widget.tabContainerStyle?.gradient,
      boxShadow:
          widget.tabContainerStyle?.boxShadow ??
          [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 1,
              color: Colors.black12.withAlpha(10),
            ),
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 8,
              color: Colors.black12.withAlpha(30),
            ),
          ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.tabHeight ?? 40,
          padding: const EdgeInsets.all(3),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: buildTabContainerDecoration(),
          child: TabBar(
            isScrollable: widget.scrollable,
            labelPadding: EdgeInsets.zero,
            onTap: (idx) {
              setState(() {
                index = idx;
              });
            },
            tabAlignment:
                widget.scrollable ? TabAlignment.start : TabAlignment.fill,
            controller: _tabController,
            indicator: buildTabDecoration(),
            indicatorSize:
                widget.tabBarIndicatorSize ?? TabBarIndicatorSize.tab,
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
                      (title) => Container(
                        width: widget.tabWidth,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Tab(text: title),
                      ),
                    )
                    .toList(),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            return SlideTransition(position: offsetAnimation, child: child);
          },
          child: Container(
            key: ValueKey<int>(index),
            child: widget.children[index],
          ),
        ),
      ],
    );
  }
}
