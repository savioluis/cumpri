class TaskModel {
  final int? id;
  final String title;
  final String? description;
  final bool isDone;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    this.isDone = false,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: "$title", description: "$description", isDone: $isDone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ isDone.hashCode;
  }
}
