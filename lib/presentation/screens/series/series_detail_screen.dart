import 'package:flutter/material.dart';

class SeriesDetailScreen extends StatelessWidget {
  
  static const name = 'series-detail';
  final String seriesId;

  const SeriesDetailScreen({
    super.key,
    required this.seriesId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SeriesID: $seriesId'),
      ),
    );
  }
}