import 'dart:collection';
import 'package:flutter/material.dart';

class ProviderLike extends ChangeNotifier{
  final List<String> _likedPizzasId = [];

  UnmodifiableListView<String> get likedPizzasId => UnmodifiableListView(_likedPizzasId);



  void add(String id){
    if(_likedPizzasId.contains(id))
    {
      _likedPizzasId.remove(id);
    }
    else
    {
      _likedPizzasId.add(id);
    }
    notifyListeners();
  }

  void remove(String id){
    _likedPizzasId.remove(id);
    notifyListeners();
  }

  bool isFavorite(String id){
    return _likedPizzasId.contains(id);
  }

  List<String> showLikedPizzas(){
    return _likedPizzasId;
  }
}