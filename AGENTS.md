# AGENTS.md
## Blood Pressure Diary (Flutter)

This repository contains a Flutter mobile application for tracking blood pressure.

This file helps AI coding agents work correctly with the project.

Detailed rules are in `/docs`.

---

# Project Summary

Offline-first mobile app for:

- recording blood pressure measurements
- viewing statistics and trends
- generating AI analysis
- reminders and export

The app does NOT provide medical diagnosis.

---

# Tech Stack

- Flutter
- Bloc
- Drift (SQLite)
- Freezed
- fl_chart
- flutter_local_notifications
- pdf / printing

---

# Core Principles

- offline-first
- local data only
- minimal and calm UI
- no medical diagnosis

---

# Architecture

Feature-first structure.

Main folders:

```text
lib/
  app/
  core/
  features/
  shared/
```

See `/docs/project_structure.md`.

---

# Domain

Main entity: `Measurement`

See `/docs/domain_model.md`.

---

# Code Generation Rules

When generating code:

- use Bloc (not Cubit)
- use Freezed for Events and States
- use manual constructor injection
- use RepositoryProvider for repositories
- use BlocProvider for blocs
- do NOT use service locator
- do NOT use DI containers
- avoid unnecessary abstractions
- do not introduce layers "for architecture"
- keep business logic out of widgets

Always follow rules from `/docs` before generating code.

---

# Repository Design

By default:

- use concrete repositories
- do not create repository interfaces
- do not create `RepositoryImpl` classes unless abstraction gives real value
- do not add use cases by default

---

# AI Analysis

AI works on aggregated data, not raw measurement lists.

See `/docs/ai_analysis_algorithm.md`.

---

# Development Approach

Build incrementally:

1. Measurements
2. History
3. Home
4. Statistics
5. AI analysis
6. Reminders
7. Export

---

# When Unsure

- follow existing patterns
- keep code simple
- avoid over-engineering
