import 'package:flutter/material.dart';

///   created               : Fadqurrosyidik
///   originalFilename      : ex_sticky_scroll_view
///   date                  : 14 Sept 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            :
///
class ExStickyScrollView extends StatefulWidget {
  final Widget header;
  final double headerHeight;

  final Widget sticker;
  final double stickerHeight;
  final Widget body;
  final double appbarHeight;

  const ExStickyScrollView({Key? key, required this.header, required this.sticker, required this.stickerHeight, required this.body, this.appbarHeight = kToolbarHeight, required this.headerHeight}) : super(key: key);

  @override
  _ExStickyScrollViewState createState() => _ExStickyScrollViewState();
}

class _ExStickyScrollViewState extends State<ExStickyScrollView> {
  List<Widget> _buildContent(BuildContext context, bool innerBoxIsScrolled) {
    var children = <Widget>[];
    children.add(_buildHeader(context));
    children.add(
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          pinned: true,
          forceElevated: innerBoxIsScrolled,
          leading: SizedBox(),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(widget.stickerHeight - widget.appbarHeight),
            child: SizedBox.shrink(),
          ),
          flexibleSpace: widget.sticker,
        ),
      )
    );
    return children;
  }

  _buildHeader(BuildContext context) => SliverToBoxAdapter(
    child: widget.header
  );

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
          _buildContent(context, innerBoxIsScrolled),
      body: Padding(
        padding: EdgeInsets.only(top: widget.stickerHeight),
        child: widget.body,
      ),
    );
  }
}

