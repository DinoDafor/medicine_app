import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';

class PillModel extends PillEntity {
  PillModel({
    required id,
    required name,
    required countOfPills,
    required repetition,
    required timeToDrink,
    required specificToDrink,
    required description,
    required status,
    required image,
  }) : super(
          id: id,
          name: name,
          countOfPills: countOfPills,
          description: description,
          repetition: repetition,
          timeToDrink: timeToDrink,
          specificToDrink: specificToDrink,
          status: status,
          image: image,
        );
  // factory PillModel.fromJson(Map<String, dynamic> json){
  //   return PillModel(

  //     name: json['name'] as String,
  //     countOfPills: json['countOfPills'] as int,
  //     durationToTake: json['durationToTake'] as int,
  //     repetition: json['repetition'] as String,
  //     nigthTimeToDrink: DateTime.parse(json['nightTimeTDrink'] as String),
  //     morningTimeToDrink: DateTime.parse(json['morningTimeTDrink'] as String),
  //     afternoonTimeToDrink: DateTime.parse(json['afternoonTimeToDrink'] as String),
  //     eveningTimeToDrink: DateTime.parse(json['eveningTimeToDrink'] as String),
  //     specificToDrink: json['specificToDrink'] as String,
  //     description: json['description'] as String,
  //     status: StatusEnum.values[json['status'] as int],
  //     image: [json['image'] as String],
  //     creatingDate: DateTime.parse(json['creatingDate'] as String)
  //   );
  // }
  // Map<String, dynamic> toJson() {
  //   return {

  //     "name" : name,
  //     'countOfPills' : countOfPills,
  //     'durationToTake' : durationToTake,
  //     'repetition' : 3,
  //     'nightTimeToDrink' :(nightTimeToDrink == null) ?"none" : nightTimeToDrink.toString(),
  //     'morningTimeToDrink' : (morningTimeToDrink == null) ? "none" : nightTimeToDrink.toString(),
  //     'afternoonTimeToDrink':(afternoonTimeToDrink == null) ? "none" : afternoonTimeToDrink.toString(),
  //     'eveningTimeToDrink': (eveningTimeToDrink == null) ? "none" : eveningTimeToDrink.toString() ,
  //     'specificToDrink' : specificToDrink,
  //     'description' : description,
  //     'status' : status.index,
  //     'image' : 0,
  //     'creatingDate': "${creatingDate.toString()}"
  //   };
}
