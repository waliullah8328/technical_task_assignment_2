class TodoModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  TodoModel({this.userId, this.id, this.title, this.completed});

  TodoModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];

    // Ensure 'completed' is a bool, handle potential String values
    if (json['completed'] is bool) {
      completed = json['completed'];
    } else if (json['completed'] is String) {
      completed = json['completed'].toLowerCase() == 'true';
    } else {
      completed = null; // Default value if type is unexpected
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}

