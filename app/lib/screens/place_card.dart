import 'package:flutter/material.dart';
import 'dart:math';

class PlaceCard extends StatefulWidget {
  final String uid;
  final dynamic userData;
  final String imagePath;
  final String text;
  final int likesCount;
  final int initialDislikesCount;

  const PlaceCard({
    Key? key,
    required this.uid,
    required this.userData,
    required this.imagePath,
    required this.text,
    this.likesCount = 0,
    this.initialDislikesCount = 0,
  }) : super(key: key);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  int _likesCount = 0;
  int _dislikesCount = 0;
  bool _isLiked = false;
  bool _isDisliked = false;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.likesCount;
    _dislikesCount = widget.initialDislikesCount;
  }

  void _incrementLikesCount() {
    setState(() {
      if (_isLiked) {
        _likesCount--;
        _isLiked = false;
      } else {
        _likesCount++;
        _isLiked = true;
        if (_isDisliked) {
          _dislikesCount--;
          _isDisliked = false;
        }
      }
    });
  }

  void _incrementDislikesCount() {
    setState(() {
      if (_isDisliked) {
        _dislikesCount--;
        _isDisliked = false;
      } else {
        _dislikesCount++;
        _isDisliked = true;
        if (_isLiked) {
          _likesCount--;
          _isLiked = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(widget.imagePath, height: 150),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: _incrementLikesCount,
                color: _isLiked ? Colors.blue : null,
              ),
              Text('Likes: $_likesCount'),
              IconButton(
                icon: Icon(Icons.thumb_down),
                onPressed: _incrementDislikesCount,
                color: _isDisliked ? Colors.red : null,
              ),
              Text('Dislikes: $_dislikesCount'),
            ],
          ),
        ],
      ),
    );
  }
}



