class User {
  late final int id;
  late final String name;
  late final String? picture;
  late final String? gender;
  late final DateTime? birthday;
  late final String? location;
  late final DateTime joinedAt;
  late final AnimeStatistics? animeStatistics;
  late final String? timeZone;
  late final bool? isSupporter;

  User({
    required this.id,
    required this.name,
    required this.picture,
    required this.gender,
    required this.birthday,
    required this.location,
    required this.joinedAt,
    required this.animeStatistics,
    required this.timeZone,
    required this.isSupporter,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picture = json['picture'];
    gender = json['gender'];
    birthday =
        json['birthday'] == null ? null : DateTime.parse(json['birthday']);
    location = json['location'];
    joinedAt = DateTime.parse(json['joined_at']);
    animeStatistics = json['anime_statistics'] == null
        ? null
        : AnimeStatistics.fromJson(json['anime_statistics']);
    timeZone = json['time_zone'];
    isSupporter = json['is_supporter'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['picture'] = picture;
    _data['gender'] = gender;
    _data['birthday'] = birthday;
    _data['location'] = location;
    _data['joined_at'] = joinedAt;
    _data['anime_statistics'] = animeStatistics?.toJson();
    _data['time_zone'] = timeZone;
    _data['is_supporter'] = isSupporter;
    return _data;
  }
}

class AnimeStatistics {
  late final int numItemsWatching;
  late final int numItemsCompleted;
  late final int numItemsOnHold;
  late final int numItemsDropped;
  late final int numItemsPlanToWatch;
  late final int numItems;
  late final double numDaysWatched;
  late final double numDaysWatching;
  late final double numDaysCompleted;
  late final double numDaysOnHold;
  late final double numDaysDropped;
  late final double numDays;
  late final int numEpisodes;
  late final int numTimesRewatched;
  late final double meanScore;

  AnimeStatistics({
    required this.numItemsWatching,
    required this.numItemsCompleted,
    required this.numItemsOnHold,
    required this.numItemsDropped,
    required this.numItemsPlanToWatch,
    required this.numItems,
    required this.numDaysWatched,
    required this.numDaysWatching,
    required this.numDaysCompleted,
    required this.numDaysOnHold,
    required this.numDaysDropped,
    required this.numDays,
    required this.numEpisodes,
    required this.numTimesRewatched,
    required this.meanScore,
  });

  AnimeStatistics.fromJson(Map<String, dynamic> json) {
    numItemsWatching = json['num_items_watching'];
    numItemsCompleted = json['num_items_completed'];
    numItemsOnHold = json['num_items_on_hold'];
    numItemsDropped = json['num_items_dropped'];
    numItemsPlanToWatch = json['num_items_plan_to_watch'];
    numItems = json['num_items'];
    numDaysWatched = json['num_days_watched'].toDouble();
    numDaysWatching = json['num_days_watching'].toDouble();
    numDaysCompleted = json['num_days_completed'].toDouble();
    numDaysOnHold = json['num_days_on_hold'].toDouble();
    numDaysDropped = json['num_days_dropped'].toDouble();
    numDays = json['num_days'].toDouble();
    numEpisodes = json['num_episodes'];
    numTimesRewatched = json['num_times_rewatched'];
    meanScore = json['mean_score'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['num_items_watching'] = numItemsWatching;
    _data['num_items_completed'] = numItemsCompleted;
    _data['num_items_on_hold'] = numItemsOnHold;
    _data['num_items_dropped'] = numItemsDropped;
    _data['num_items_plan_to_watch'] = numItemsPlanToWatch;
    _data['num_items'] = numItems;
    _data['num_days_watched'] = numDaysWatched;
    _data['num_days_watching'] = numDaysWatching;
    _data['num_days_completed'] = numDaysCompleted;
    _data['num_days_on_hold'] = numDaysOnHold;
    _data['num_days_dropped'] = numDaysDropped;
    _data['num_days'] = numDays;
    _data['num_episodes'] = numEpisodes;
    _data['num_times_rewatched'] = numTimesRewatched;
    _data['mean_score'] = meanScore;
    return _data;
  }
}
