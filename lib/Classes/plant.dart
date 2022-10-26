class Plant {
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
      {required this.pid,
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
}
