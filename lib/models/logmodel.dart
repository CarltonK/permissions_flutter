class LOG {
  String name;
  int duration;
  DateTime date;

  LOG({this.name, this.duration, this.date});

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'duration': duration,
      'date': date
    };
  }

  factory LOG.fromJson(Map<String, dynamic> json) => LOG(
      name: json['name'],
      duration: json['duration'],
      date: json['date']
  );
}