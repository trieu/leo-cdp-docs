# LEO CDP Documentation

This repository contains the **official documentation site** for **LEO CDP** — an open-source, AI-first Customer Data Platform.

The documentation is built using **MkDocs + Material**, generated as **static HTML**, and can also be exported to **PDF** for distribution, audits, and enterprise delivery.

---

## 📌 What This Repository Is

- 📖 Technical documentation for **LEO CDP**
- 🧱 Architecture, tutorials, and implementation guides
- 🌐 Static site served via Nginx (recommended)
- 📄 Optional PDF generation for offline or formal use

This repository **does not contain application code**.  
It exists solely to document how LEO CDP works and how to use it.

---

## 🧰 Technology Stack

- **Documentation Engine**: MkDocs
- **Theme**: MkDocs Material
- **Diagrams**: Mermaid
- **PDF Export**: mkdocs-to-pdf
- **Language**: Markdown
- **Deployment**: Static files (HTML + assets)

---

## 📂 Project Structure

```text
leo-cdp-docs/
├── docs/                   # Markdown source files
│   ├── index.md             # Documentation home
│   ├── architecture.md     # System architecture
│   └── tutorials/          # Step-by-step guides
│       └── getting_started.md
├── mkdocs.yml               # MkDocs configuration
├── build-docs.sh            # Build documentation
├── update-docs.sh           # Git update logic
├── update-and-build.sh      # Cron entry point
└── site/                    # Generated static site (ignored in Git)
```

---

## 🚀 Getting Started (Local Development)

This guide explains how to run the **LEO CDP documentation site locally** and enable **automatic updates and rebuilds** using `crontab`.

The setup is designed to be:
- Simple for local development
- Safe for long-running machines
- Easy to promote to staging or production

---

### 1. Clone the Documentation Repository

```bash
git clone git@github.com:trieu/leo-cdp-docs.git
cd leo-cdp-docs
````

Ensure you are on the `main` branch:

```bash
git branch
```

---

### 2. Preview Documentation Locally

For interactive development and live preview:

```bash
mkdocs serve
```

The documentation will be available at:

```text
http://127.0.0.1:8000
```

> `mkdocs serve` is intended **only for local development**.
> It should not be exposed to the public internet.

---

### 3. Build Static Documentation

To generate production-ready static files:

```bash
mkdocs build
```

This produces a `site/` directory containing HTML, CSS, and assets that can be served by Nginx or any static web server.

---

### 4. Enable Automated Updates with Crontab

The repository includes automation scripts for:

* Pulling documentation updates from Git
* Rebuilding the site only when changes are detected

These scripts are intended for **local servers, staging environments, or internal documentation hosts**.

#### Available Scripts

| Script                | Purpose                       |
| --------------------- | ----------------------------- |
| `update-docs.sh`      | Fetches and pulls Git updates |
| `build-docs.sh`       | Builds the MkDocs site        |
| `update-and-build.sh` | Orchestrates update + build   |

---

### 5. Configure Crontab (Every 2 Minutes)

Edit your crontab:

```bash
crontab -e
```

Add the following entry:

```cron
*/2 * * * * cd /path/to/leo-cdp-docs && ./update-and-build.sh >> docs-cron.log 2>&1
```

#### What This Does

* Runs every **2 minutes**
* Pulls changes from the remote Git repository
* Rebuilds documentation **only if changes are detected**
* Logs output to `docs-cron.log` for debugging and auditing

---

### 6. Verify Cron Execution

Check logs:

```bash
tail -f docs-cron.log
```

You should see entries similar to:

```text
[ORCHESTRATOR] Repository updated. Triggering build...
[BUILD] MkDocs build completed successfully.
```

---

### 7. Recommended Production Pattern

For production environments:

1. Use `mkdocs build`
2. Serve the `site/` directory via **Nginx**
3. Keep cron automation for updates only

> MkDocs should never run as a long-lived server process in production.

---

### Summary

* `mkdocs serve` → local preview
* `mkdocs build` → static site generation
* `cron + update-and-build.sh` → automated documentation updates

This setup ensures your documentation stays **up-to-date, reproducible, and operationally simple**.

