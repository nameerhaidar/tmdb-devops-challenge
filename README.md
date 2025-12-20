# 🎬 TMDB Search — End-to-End DevOps Solution

## 📝 Project Overview

This repository contains a **professional-grade implementation** of a React-based **TMDB Search** application, integrated into a fully automated **DevSecOps lifecycle**.

The project demonstrates the complete transition from a **local development environment** to a **hardened, cloud-native deployment on Azure**, following industry best practices in CI/CD, security, and containerization.

---

## 🔗 CI/CD Pipeline & Runtime (Requirement)

The full execution history, stage runtimes, and deployment logs are publicly accessible via the link below:

👉 **View GitLab CI/CD Pipeline Runtime & History** https://gitlab.com/nameerhaidar/tmdb-devops-challenge/-/pipelines

The pipeline provides deterministic verification across the following runtimes:

- **Linting**: Static analysis for code quality  
- **Testing**: Functional verification using Jest  
- **Building**: Compilation of production-ready React assets  
- **Packaging**: Multi-stage Docker containerization  
- **Deployment**: Live orchestration to Microsoft Azure  

---

## 🛠️ Pipeline Architecture

The CI/CD pipeline is structured into **six strictly ordered gates**, ensuring that only verified and secure code reaches production:

| Stage | Purpose | Technology |
|------|--------|-----------|
| **Lint** | Code style enforcement | ESLint|
| **Test** | Functional verification | Jest / React Testing Library |
| **Build** | Asset compilation | Node.js 18 (Alpine) |
| **Docker Build** | Immutable packaging | Docker (DIND 28.0) |
| **Cloud Push** | Image versioning | Azure Container Registry (ACR) |
| **Deploy** | Live cloud orchestration | Azure Container Instances (ACI) |

⸻

🐳 Production-Grade Containerization
	•	Base Image: Nginx-Alpine (production-grade web server)
	•	Optimization: Final image size is < 30MB, representing a ~94% reduction compared to standard Node images
	•	Routing: Custom Nginx configuration to support Single Page Application (SPA) client-side routing
	•	Security: Final image contains no source code, only compiled static assets

    ## 📊 Project Badges

![Pipeline Status](https://gitlab.com/nameerhaidar/tmdb-devops-challenge/badges/devops-ci-solution/pipeline.svg)
![Docker](https://img.shields.io/badge/Docker-Multi--Stage-blue)
![Azure](https://img.shields.io/badge/Azure-Container%20Instances-blue)
![Security](https://img.shields.io/badge/Security-Least%20Privilege-green)
![CI/CD](https://img.shields.io/badge/CI/CD-GitLab-orange)

---

🎯 Why This Design?

1️⃣ Deterministic & Reproducible Deployments

This pipeline guarantees that what is tested is exactly what is deployed.
	•	Docker images are built once
	•	Saved and reused using GitLab artifacts
	•	No re-builds, no environment drift

This eliminates a common CI/CD anti-pattern where production runs code that was never tested.

⸻

2️⃣ Security by Default (DevSecOps)

Security is enforced at every layer:
	•	No credentials stored in source code
	•	Secrets injected using GitLab Masked Variables
	•	Azure Service Principal uses least-privilege Contributor access
	•	Final Docker image contains no source code
    •	Eliminating mutable dependencies and replacing them with immutable SHA-256 image    digests

This design aligns with Zero Trust and enterprise DevSecOps standards.

⸻

3️⃣ Cost-Efficient Cloud Architecture

The solution uses Azure Container Instances instead of Kubernetes:
	•	No cluster management overhead
	•	No idle resource costs
	•	Ideal for stateless frontend workloads

This demonstrates architectural judgment, not over-engineering.

⸻

4️⃣ Production-Optimized Container Strategy
	•	Multi-stage Docker build
	•	Nginx-Alpine runtime
	•	Final image size < 30MB
	•	SPA routing handled via Nginx config

This results in:
	•	Faster deployments
	•	Smaller attack surface
	•	Better cold-start performance

---

## 🔧 Challenges & Solutions

### 1️⃣ Infrastructure-as-Code (IaC) Hardening

**Problem**  
Recent Azure CLI updates caused deployment failures due to undefined OS types and missing resource requests.

**Solution**  
Hardened the deployment command with explicit flags:

```bash
--os-type Linux --cpu 1 --memory 1.5

This ensures the deployment remains platform-agnostic and resilient to future Azure CLI changes.

2️⃣ Docker Image Consistency

Problem
Rebuilding images in separate pipeline stages can introduce “bit-rot” or environmental drift.

Solution
Implemented Docker Save / Load via GitLab artifacts:
	•	The image is built once
	•	Saved as a .tar artifact
	•	Passed through the pipeline unchanged

This guarantees the exact image tested is the one deployed to Azure Container Registry.