# Quick Start Guide - DEV Environment CI/CD

## For Azure DevOps Users

### Setup (One-time)
1. Open Azure DevOps portal
2. Navigate to Pipelines → New Pipeline
3. Select your repository
4. Choose "Existing Azure Pipelines YAML file"
5. Select `/azure-pipelines-dev.yml`
6. Save and run

### Create DEV Environment
1. Go to Pipelines → Environments
2. Click "New environment"
3. Name: `DEV`
4. Resource: None
5. Save

### Run Pipeline
- **Automatic**: Push to `develop` or `feature/*` branch
- **Manual**: Pipelines → Select pipeline → Run pipeline

---

## For GitHub Actions Users

### Setup (One-time)
1. Go to repository Settings
2. Navigate to Environments
3. Click "New environment"
4. Name: `DEV`
5. Configure protection rules (optional)
6. Save

### Run Workflow
- **Automatic**: Push to `develop` or `feature/**` branch
- **Manual**: Actions tab → "DEV Environment CI/CD" → Run workflow

---

## Viewing Build Artifacts

### Azure DevOps
Pipeline run → Artifacts tab → Download `dev-apk-{BuildId}`

### GitHub Actions
Workflow run → Artifacts section → Download `dev-apk-{SHA}`

---

## Configuration Files

| File | Purpose |
|------|---------|
| `azure-pipelines-dev.yml` | Azure DevOps pipeline |
| `.github/workflows/dev-cicd.yml` | GitHub Actions workflow |
| `lib/config/dev_config.dart` | DEV environment settings |
| `docs/CICD-DEV-SETUP.md` | Detailed documentation |

---

## Common Commands

```bash
# Check Flutter version
flutter --version

# Install dependencies
flutter pub get

# Run analysis
flutter analyze

# Run tests
flutter test

# Build DEV APK
flutter build apk --debug
```

---

## Deployment Targets (Optional)

Uncomment and configure in pipeline files:

- **Firebase App Distribution**: For beta testing
- **App Center**: For distribution management
- **Google Play Internal Testing**: For Play Store testing
- **Custom Server**: For internal hosting

See `docs/CICD-DEV-SETUP.md` for detailed instructions.

---

## Support

**Issues?** Check `docs/CICD-DEV-SETUP.md` → Troubleshooting section

**Questions?** Contact DevOps team or create an issue
