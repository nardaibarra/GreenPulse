class Plant {
  String id;
  String name;
  final String pid;
  final String display_pid;
  final String alias;
  final String category;
  final int max_light_lux;
  final int min_light_lux;
  final int max_temp;
  final int min_temp;
  final int max_env_humid;
  final int min_env_humid;
  final int max_soil_moist;
  final int min_soil_moist;
  final String image_url;
  Plant(
      {this.id = '',
      this.name = '',
      required this.pid,
      required this.display_pid,
      required this.alias,
      required this.category,
      required this.max_light_lux,
      required this.min_light_lux,
      required this.max_temp,
      required this.min_temp,
      required this.max_env_humid,
      required this.min_env_humid,
      required this.max_soil_moist,
      required this.min_soil_moist,
      required this.image_url});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image_url': image_url,
        'alias': alias,
        'pid': pid,
        'display_pid': display_pid,
        'category': category,
        'max_light_lux': max_light_lux,
        'min_light_lux': min_light_lux,
        'max_temp': max_temp,
        'min_temp': min_temp,
        'max_env_humid': max_env_humid,
        'min_env_humid': min_env_humid,
        'max_soil_moist': max_soil_moist,
        'min_soil_moist': min_soil_moist,
        'selected': false
      };
}
