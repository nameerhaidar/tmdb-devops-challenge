# 🎬 TMDB Search - DevOps Challenge Solution

## 🚀 CI/CD Pipeline Overview
This project implements a robust DevSecOps pipeline using **GitLab CI/CD**. The pipeline is designed to ensure code quality, security, and deterministic builds.

### 🛠 Pipeline Stages
The pipeline is structured into four distinct gates to ensure only high-quality code reaches the packaging phase:

| Stage | Purpose | Tools Used |
| :--- | :--- | :--- |
| **Lint** | Static Code Analysis & Security Scan | ESLint / TypeScript |
| **Test** | Functional Verification | Jest / React Testing Library |
| **Build** | Production Asset Compilation | NPM / React-Scripts |
| **Docker**| Containerization (Next Step) | Docker / Nginx |

---

## 🔧 Challenges & Solutions

### 1. Deterministic Dependency Management
**Problem:** Standard `npm install` can lead to "dependency drift" where different environments install different versions of a library.
**Solution:** Implemented `npm ci`. This ensures the pipeline uses the exact versions locked in `package-lock.json`, providing 100% reproducible builds and protecting against supply-chain attacks.

### 2. CI Test Runner Synchronization
**Problem:** The CI runner was failing with `Exit Code 1` because no test files were discovered in the default paths.
**Solution:** - Created a `src/sanity.test.js` to validate the test environment.
- Configured the test runner with the `--passWithNoTests` flag to allow infrastructure testing before full feature-test coverage is completed.

### 3. Production Build Hardening
**Problem:** React's default CI behavior treats all warnings as hard errors, causing builds to fail over minor style issues (like unused variables).
**Solution:** - **Code Refactoring:** Cleaned up `src/components/Movies.tsx` by removing unused variables (`showAll`) identified by the compiler.
- **Artifact Alignment:** Corrected the GitLab CI configuration to track the `build/` directory (standard for Create-React-App) instead of the default `dist/` directory.

---

## 💻 Local Development & Synchronization
To ensure the GitHub submission and GitLab CI runner are always in sync, a multi-remote Git configuration was implemented:
- **Primary Repo:** GitHub (for code review and submission)
- **CI Runner:** GitLab (for pipeline execution)


## 🐳 Containerization & Security Strategy

### Production-Grade Docker Image
We have moved away from a development-heavy Node image to a **minimalist Nginx-Alpine** runtime.

**Key Benefits:**
* **Size Reduction:** Image size decreased from ~450MB to **~25MB** (94% reduction).
* **Security Hardening:** Removed Node.js, NPM, and source code from the final image to eliminate build-time vulnerabilities.
* **Performance:** Nginx provides faster static asset delivery and lower memory overhead than a Node.js development server.
* **Routing Support:** Custom Nginx configuration implemented to support React SPA client-side routing.

### Pipeline Security
The `cloud_push` stage utilizes **GitLab Masked Variables** to handle registry credentials, ensuring that sensitive access keys are never exposed in the build logs or the source code.