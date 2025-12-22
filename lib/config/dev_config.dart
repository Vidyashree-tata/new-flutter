// DEV Environment Configuration
// This file contains configuration for the DEV environment

const String environment = 'DEV';
const String apiBaseUrl = 'https://api-dev.yourapp.com';
const String appName = 'Calculator - DEV';

// Feature flags for DEV environment
const bool enableDebugMode = true;
const bool enableAnalytics = false;
const bool enableCrashReporting = false;

// API Configuration
const int apiTimeout = 30; // seconds
const bool useSecureConnection = true;

// Database Configuration
const String databaseName = 'calculator_dev.db';

// Logging Configuration
const bool enableVerboseLogging = true;
const String logLevel = 'DEBUG';

// Environment-specific settings
class DevConfig {
  static const String environment = 'DEV';
  static const String apiBaseUrl = apiBaseUrl;
  static const String appName = appName;
  static const bool debugMode = enableDebugMode;
  static const bool analytics = enableAnalytics;
  static const bool crashReporting = enableCrashReporting;
  static const int timeout = apiTimeout;
  static const bool secureConnection = useSecureConnection;
  static const String dbName = databaseName;
  static const bool verboseLogging = enableVerboseLogging;
  static const String logLevel = logLevel;
}
