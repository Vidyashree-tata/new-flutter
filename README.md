# calculator

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## DevOps Vidya — reusable Java service pipeline

The Flutter pipelines above are unchanged. `devops/vidya/azure-pipelines.yml`
is a separate, parameterized Azure pipeline for the Java 21/Maven services in
the supplied example; it does **not** build this Flutter app.

### Immediate credential remediation

Revoke the PAT exposed in the Docker build logs and create a replacement only
if another integration still needs it. Restrict access to the exposed logs and
remove affected build caches according to your organization's incident policy.
The new pipeline needs **no PAT**: Azure repository checkout uses the pipeline's
job identity. Never place tokens in Git URLs, Docker build arguments or images.
The original URL treated the PAT as a username rather than a password; after
the redirect, Git attempted an interactive credential prompt in a noninteractive
Docker build.

### Configure each service

1. Copy `devops/vidya` into each Java service repository, and create an Azure
   pipeline selecting `devops/vidya/azure-pipelines.yml`. The trigger is
   `jiobp_develop` in that service repository, not this Flutter repository.
   This is a reusable pipeline entry point, not an installed AI agent or an
   automatic discovery system for services.
2. Change the parameter defaults per service: `serviceName`, `chartPrefix`,
   `serviceVariableGroup`, and `jarPattern`. Set the literal
   `resources.repositories` entry named `deployment` to that service's
   `<project>/<repository>` (Azure does not support parameters in repository
   resource names). The BCP
   defaults retain the supplied image, chart-directory and Helm-repository
   naming for `dev`, `test` and `release`. Use an explicit JAR pattern if Maven
   produces multiple JARs; the selected JAR must have a `Main-Class` manifest.
   Set `buildSharedLibraries: false` for services that do not use the two shared
   libraries. Change their resource refs if their default branches differ.
3. Authorize the pipeline's build-service identity to read the service,
   `transconnect/SecurityLibrary`, `transconnect/NotificationUtility` and the
   deployment repository (branch `deployment`) in the **same Azure organization**.
   Grant project-level permissions and explicitly authorize the repository
   resources when job-scope/repository protection is enabled. No write
   permission or deployment-branch push is required.
4. Authorize variable groups `nexusRegistry`, `nexusHelmRegistry`,
   `SonarQube_Test`, `NexusCredentials`, and the service-specific group.
   Required values: `nexusRegistry` (Docker registry host and optional port,
   without scheme), `nexusHelmRegistry` (Helm host and optional port, without
   scheme), `SONAR_PROJECT_KEY` (unique per service), `NEXUS_USERNAME`, and
   secret `NEXUS_PASSWORD`. Add other service-specific variable groups only
   when the build actually needs them; do not bake runtime secrets into images.
5. Configure service connections `nexus-docker-registry` and `sonarqube`.
   The Docker connection's registry must match `nexusRegistry`. Use a
   SonarQube edition that supports branch analysis for `jiobp_develop`, or run
   analysis from the configured main branch with Community Edition. Do not
   strip scanner branch properties or query a project's unrelated latest gate.
6. Provision **every** Linux agent in `on-prem-pool` with JDK 21 (`JAVA_HOME`),
   Maven, Python 3.9+, Docker with daemon access, Trivy, Helm 3 and Mike Farah
   `yq` 4. Install the Azure SonarQube extension. Agents need network access
   to Azure Repos, Maven dependencies, SonarQube, the container registry,
   Trivy databases and Nexus. Configure trusted corporate CA certificates;
   do not bypass TLS verification. Maven POMs must configure JaCoCo coverage,
   the Sonar Maven scanner, tests and executable-JAR packaging.
7. Create the Nexus Docker repository `jiobp-docker` and Helm **hosted**
   repositories `<serviceName>-<environment>-helm` with upload permission
   and HTTPS. Nexus manages the Helm index: the pipeline does not overwrite
   `index.yaml`. Charts must have `image.repository` and `image.tag` in
   `values.yaml` and use them in their workload templates. Commit `Chart.lock`
   for charts with dependencies. Chart versions use `1.0.<Build.BuildId>`;
   choose a different major/minor policy if required.
8. For actual deployment, set `deployToCluster: true`, choose a real
   `kubernetesServiceConnection` and an existing `namespace`, and configure
   Azure environment approvals/checks for `dev`, `test` and `release`.
   Configure Kubernetes image-pull credentials for the private Nexus registry
   in that namespace. Deployment waits for rollout and rolls back on failure.
   With the default `false`, the pipeline only builds and publishes artifacts.

Tests and coverage must pass, SonarQube must accept **this analysis**, and
Trivy must report no HIGH/CRITICAL vulnerabilities before the image is pushed.
All downstream stages depend on those gates. Docker packages the tested JAR
without cloning repositories, running Maven again, or receiving credentials.
It runs as a non-root user and uses `JAVA_TOOL_OPTIONS` for JVM settings.
Only the immutable build-ID tag is pushed; no unpushed `latest` tag is advertised.
Helm charts are updated in the staging directory, leaving deployment Git history
untouched. Each job downloads the artifacts it needs, so jobs may use different
agents without relying on shared workspaces.
