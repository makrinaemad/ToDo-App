class TaskModel {
  String id;
  String title;
  String  time;
  int  date;
  String userId;
  bool isDone;

  TaskModel({this.id="", required this.title,
    required this.time,
    required this.date,
    required this.userId,
    this.isDone=false});

  TaskModel.fromJson(Map<String,dynamic>data):
  this(
        id: data['id'],
        title: data['title'],
        time: data['time'],
        date: data['date'],
        userId:data['userId'],
        isDone: data['isDone'],
    );
  Map<String,dynamic>toJson(){
    return{
    "id":id,
    "title":title,
    "time":time,
      "date":date,
      "userId":userId,
    "isDone":isDone};

  }
  }
