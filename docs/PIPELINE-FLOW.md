# CI/CD Pipeline Flow - DEV Environment

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    CODE PUSH TO REPOSITORY                       │
│              (develop branch or feature/* branches)              │
└──────────────────────┬──────────────────────────────────────────┘
                       │
                       ▼
        ┌──────────────────────────────┐
        │   TRIGGER CI/CD PIPELINES    │
        └──────────────┬───────────────┘
                       │
           ┌───────────┴───────────┐
           │                       │
           ▼                       ▼
    ┌─────────────┐        ┌─────────────┐
    │   Azure     │        │   GitHub    │
    │  Pipelines  │        │   Actions   │
    └──────┬──────┘        └──────┬──────┘
           │                      │
           │                      │
    ┌──────▼──────────────────────▼──────┐
    │         BUILD STAGE - DEV           │
    ├─────────────────────────────────────┤
    │ 1. Setup Environment                │
    │    - Install Flutter SDK 3.19.0     │
    │    - Setup Java/Python              │
    │                                     │
    │ 2. Install Dependencies             │
    │    - flutter pub get                │
    │                                     │
    │ 3. Code Quality                     │
    │    - flutter analyze                │
    │                                     │
    │ 4. Testing                          │
    │    - flutter test                   │
    │                                     │
    │ 5. Build APK                        │
    │    - flutter build apk --debug      │
    │                                     │
    │ 6. Publish Artifacts                │
    │    - Upload APK (30 days retention) │
    └──────────────┬──────────────────────┘
                   │
                   ▼
    ┌──────────────────────────────────────┐
    │       DEPLOY STAGE - DEV             │
    ├──────────────────────────────────────┤
    │ 1. Download Artifacts                │
    │    - Retrieve built APK              │
    │                                      │
    │ 2. Verify Build                      │
    │    - Check APK integrity             │
    │                                      │
    │ 3. Deploy to Target                  │
    │    - Firebase / App Center / Custom  │
    │    - (Configurable)                  │
    │                                      │
    │ 4. Notification                      │
    │    - Build summary                   │
    │    - Deployment status               │
    └──────────────┬───────────────────────┘
                   │
                   ▼
    ┌──────────────────────────────────────┐
    │         DEV ENVIRONMENT              │
    │                                      │
    │  APK Available for Testing           │
    │  - Debug build                       │
    │  - DEV configuration                 │
    │  - Verbose logging enabled           │
    └──────────────────────────────────────┘
```

## Trigger Events

### Automatic Triggers
- Push to `develop` branch
- Push to `feature/*` or `feature/**` branches
- Pull request to `develop` (GitHub only)

### Manual Triggers
- Azure DevOps: "Run pipeline" button
- GitHub Actions: "workflow_dispatch" event

## Environment Configuration

```
┌──────────────────────────────────────────┐
│     lib/config/environment_config.dart   │
│              (Manager)                   │
└──────────────────┬───────────────────────┘
                   │
                   ▼
        ┌──────────────────┐
        │   DEV Config     │
        │                  │
        │ - Debug: ON      │
        │ - Logging: ON    │
        │ - Analytics: OFF │
        └──────────────────┘
```

## Build Artifacts

### Artifact Details
- **Name**: `dev-apk-{BuildId/SHA}`
- **Type**: Debug APK
- **Size**: ~20-50 MB (varies)
- **Retention**: 30 days
- **Location**: 
  - Azure: Pipeline run → Artifacts tab
  - GitHub: Workflow run → Artifacts section

## Deployment Options

```
┌────────────────────────┐
│    Built APK (DEV)     │
└───────────┬────────────┘
            │
    ┌───────┴───────┐
    │               │
    ▼               ▼
┌────────┐    ┌──────────┐
│Firebase│    │   App    │
│  App   │    │  Center  │
│Distrib.│    │          │
└────────┘    └──────────┘
    │               │
    ▼               ▼
┌────────┐    ┌──────────┐
│ Google │    │  Custom  │
│  Play  │    │  Deploy  │
│Internal│    │          │
└────────┘    └──────────┘
```

## Success Metrics

✅ Build completes in < 10 minutes  
✅ All tests pass  
✅ Code analysis passes  
✅ APK generated successfully  
✅ Artifacts published  
✅ Deployment successful  

## Monitoring

### Azure DevOps
- Dashboard: Pipelines → Recent runs
- Logs: Pipeline run → Logs tab
- Artifacts: Pipeline run → Artifacts tab

### GitHub Actions
- Dashboard: Actions tab
- Logs: Workflow run → Job logs
- Artifacts: Workflow run → Artifacts section

---

**Environment**: DEV  
**Version**: 1.0  
**Last Updated**: December 2024
