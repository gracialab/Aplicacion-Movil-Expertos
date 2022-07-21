import 'package:flutter/material.dart';
import 'package:any_link_preview/parser/base.dart';
import 'package:any_link_preview/link_analyzer.dart';

class LinkPreview extends StatefulWidget {
  final Key? key;

  final String link;

  final Duration cache;

  final Widget Function(bool loading, BaseMetaInfo?) builder;

  const LinkPreview({
    this.key,
    this.cache = const Duration(days: 30),
    required this.link,
    required this.builder,
  }) : super(key: key);

  @override
  _LinkPreviewState createState() => _LinkPreviewState();
}

class _LinkPreviewState extends State<LinkPreview> {
  InfoBase? _info;
  String? _url;
  bool _loading = true;

  @override
  void initState() {
    _url = widget.link.trim();
    _info = LinkAnalyzer.getInfoFromCache(_url);
    if (_info == null) {
      _getInfo();
    } else {
      _loading = false;
    }
    super.initState();
  }

  void _getInfo() async {
    if (_url!.startsWith("http") || _url!.startsWith("https")) {
      _info = await LinkAnalyzer.getInfo(_url!, cache: widget.cache);
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final BaseMetaInfo? info = _info as BaseMetaInfo?;

    return widget.builder(_loading, info);
  }
}
