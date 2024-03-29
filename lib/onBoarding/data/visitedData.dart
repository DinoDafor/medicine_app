import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';



class VisitedIndicator{

 bool _flagVisited = false;

final _myBox =Hive.box('mybox');

void updateData()
{
  _flagVisited=true;
  try{
  _myBox.put("FLAG", _flagVisited);
  }
  catch(e)
  {
    print("My error $e");
  }
}

void loadData()
{
  _flagVisited = _myBox.get("FLAG");
}
 
bool  flagVisitedGet()  
{
  return _flagVisited;
}
}