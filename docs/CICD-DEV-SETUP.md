# CI/CD Setup for DEV Environment

## Overview
This document describes the CI/CD pipeline setup for the DEV (Development) environment.

## Pipeline Files

### Azure Pipelines
- **File**: `azure-pipelines-dev.yml`
- **Trigger**: Commits to `develop` branch or `feature/*` branches
- **Purpose**: Build and deploy to DEV environment using Azure DevOps

### GitHub Actions
- **File**: `.github/workflows/dev-cicd.yml`
- **Trigger**: Push to `develop` or `feature/**` branches, PRs to `develop`
- **Purpose**: Build and deploy to DEV environment using GitHub Actions

## Pipeline Stages

### 1. Build Stage
- **Flutter SDK Installation**: Installs Flutter SDK version 3.19.0
- **Dependency Installation**: Runs `flutter pub get`
- **Code Analysis**: Runs `flutter analyze` to check code quality
- **Testing**: Executes unit tests with `flutter test`
- **APK Build**: Creates a debug APK for DEV environment
- **Artifact Publishing**: Publishes the APK as a build artifact

### 2. Deploy Stage
- **Artifact Download**: Retrieves the built APK
- **Verification**: Verifies the APK integrity
- **Deployment**: Deploys to DEV environment (configurable)

## Environment Configuration

### DEV Configuration
Location: `lib/config/dev_config.dart`

Features enabled in DEV:
- Debug mode enabled
- Verbose logging enabled
- Analytics disabled (for testing)
- Crash reporting disabled (for testing)

### Configuration Manager
Location: `lib/config/environment_config.dart`

Manages switching between different environments (DEV, STAGING, PRODUCTION).

## How to Use

### Azure DevOps Setup

1. **Create Pipeline**:
   - Go to Azure DevOps > Pipelines
   - Click "New Pipeline"
   - Select your repository
   - Choose "Existing Azure Pipelines YAML file"
   - Select `azure-pipelines-dev.yml`

2. **Configure Environment**:
   - Create an environment named "DEV" in Azure DevOps
   - Add any required approvals or checks

3. **Variables** (Optional):
   - Set pipeline variables if needed
   - Add secret variables in Pipeline settings

### GitHub Actions Setup

1. **Environment Configuration**:
   - Go to Repository Settings > Environments
   - Create a new environment named "DEV"
   - Configure protection rules if needed

2. **Secrets** (Optional):
   - Add repository secrets if needed for deployment
   - Example: `FIREBASE_TOKEN`, `APP_CENTER_TOKEN`, etc.

3. **Manual Trigger**:
   - Go to Actions tab
   - Select "DEV Environment CI/CD" workflow
   - Click "Run workflow"

## Deployment Options

The pipelines are configured with placeholders for various deployment targets:

### Option 1: Firebase App Distribution
Uncomment and configure the Firebase deployment step in the workflow files.

Required secrets:
- `FIREBASE_APP_ID_DEV`
- `FIREBASE_TOKEN`

### Option 2: App Center
Add App Center distribution task in Azure Pipelines.

Required configuration:
- App Center service connection
- App slug
- Distribution group

### Option 3: Google Play Internal Testing
Configure Google Play deployment.

Required:
- Service account credentials
- Package name

### Option 4: Custom Deployment
Add your own deployment steps based on your infrastructure.

## Build Artifacts

### Azure DevOps
Artifacts are available in the Pipeline run under "Artifacts" tab:
- Name: `dev-apk-{BuildId}`
- Contents: Debug APK for DEV environment
- Retention: 30 days

### GitHub Actions
Artifacts are available in the Workflow run:
- Name: `dev-apk-{SHA}`
- Contents: Debug APK for DEV environment
- Retention: 30 days

## Monitoring and Logs

### Azure DevOps
- View pipeline runs: Pipelines > Recent runs
- Check logs: Click on a run > View logs

### GitHub Actions
- View workflow runs: Actions tab
- Check logs: Click on a workflow run > View job logs

## Triggering Builds

### Automatic Triggers
Both pipelines automatically trigger on:
- Push to `develop` branch
- Push to `feature/*` branches (Azure) or `feature/**` (GitHub)
- Pull requests to `develop` (GitHub only)

### Manual Triggers
- **Azure DevOps**: Click "Run pipeline" button
- **GitHub Actions**: Use "workflow_dispatch" from Actions tab

## Troubleshooting

### Common Issues

1. **Flutter SDK Installation Fails**
   - Check Flutter version compatibility
   - Verify network connectivity

2. **Build Fails**
   - Check dependencies in `pubspec.yaml`
   - Review build logs for specific errors

3. **Tests Fail**
   - Review test logs
   - Tests are set to continue-on-error in DEV

4. **Artifact Upload Fails**
   - Check artifact path configuration
   - Verify build output location

## Next Steps

1. Configure actual deployment target (Firebase, App Center, etc.)
2. Add integration tests
3. Set up notifications for build failures
4. Configure code coverage reporting
5. Add security scanning

## Support

For issues or questions about the CI/CD setup, please contact the DevOps team or create an issue in the repository.

---

**Last Updated**: December 2024
**Environment**: DEV
**Version**: 1.0
