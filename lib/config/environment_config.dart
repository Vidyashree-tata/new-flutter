// Environment Configuration Manager
// Manages different environment configurations

import 'dev_config.dart' as dev;

enum Environment { DEV, STAGING, PRODUCTION }

class EnvironmentConfig {
  static Environment current = Environment.DEV;

  static String get environment {
    switch (current) {
      case Environment.DEV:
        return dev.DevConfig.environment;
      default:
        return dev.DevConfig.environment;
    }
  }

  static String get apiBaseUrl {
    switch (current) {
      case Environment.DEV:
        return dev.DevConfig.apiBaseUrl;
      default:
        return dev.DevConfig.apiBaseUrl;
    }
  }

  static String get appName {
    switch (current) {
      case Environment.DEV:
        return dev.DevConfig.appName;
      default:
        return dev.DevConfig.appName;
    }
  }

  static bool get debugMode {
    switch (current) {
      case Environment.DEV:
        return dev.DevConfig.debugMode;
      default:
        return dev.DevConfig.debugMode;
    }
  }

  static bool get analytics {
    switch (current) {
      case Environment.DEV:
        return dev.DevConfig.analytics;
      default:
        return dev.DevConfig.analytics;
    }
  }

  static bool get crashReporting {
    switch (current) {
      case Environment.DEV:
        return dev.DevConfig.crashReporting;
      default:
        return dev.DevConfig.crashReporting;
    }
  }

  static void setEnvironment(Environment env) {
    current = env;
  }
}
