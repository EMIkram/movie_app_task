
///later shift this data to .env file
final Map<String , String> _env = {
  "ENVIRONMENT" : "DEV",
  "APP_NAME" : "Ten twenty task",
  "API_BASE_URL" : "https://api.themoviedb.org/3",
  "API_KEY" : "a644bf1e55bbf9b18ed98b74468fb276"
};


class Environment {
  static final Environment _instance = Environment._internal();

  late EnvironmentType environmentType;
  late String appName;
  late String apiBaseUrl;
  late String apiKey;


  factory Environment() {
    return _instance;
  }

  Environment._internal();

  static Future<void> initialize() async {

    _instance.environmentType = getEnvironmentTypeFromString(_env['ENVIRONMENT'] ?? "DEV");

    ///App name
    _instance.appName = _env['APP_NAME'] ?? 'Carbee Dealership';

    ///API base url
    _instance.apiBaseUrl = _env['API_BASE_URL'] ?? '';

    _instance.apiKey = _env['API_KEY'] ?? '';
  }

  static  EnvironmentType getEnvironmentTypeFromString(String environment) {
    return EnvironmentType.values.firstWhere(
          (e) => e.toString().split('.').last.toUpperCase() == environment.toUpperCase(),
      orElse: () => EnvironmentType.DEV, // Default to DEV if no match found
    );
  }

  static Environment get instance => _instance;
}

enum EnvironmentType {
  DEV,
  SANDBOX,
  PRODUCTION
}