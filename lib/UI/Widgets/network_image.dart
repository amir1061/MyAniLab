import 'package:flutter/material.dart';

class MalNetworkImage extends StatefulWidget {
  final String link;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget errorWidget;
  final Widget loadingWidget;

  const MalNetworkImage({
    Key? key,
    this.link = '',
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.errorWidget = const Icon(Icons.error),
    this.loadingWidget = const SizedBox(),
  }) : super(key: key);
  @override
  _MalNetworkImageState createState() => _MalNetworkImageState();
}

class _MalNetworkImageState extends State<MalNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.link.replaceFirst('https', 'http'),
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : widget.loadingWidget,
      errorBuilder: (_, __, ___) => widget.errorWidget,
    );
  }
}
