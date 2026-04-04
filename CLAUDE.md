# CLAUDE.md

## Project Overview

Go pub/sub messaging example demonstrating a publisher-subscriber pattern implementation.

**Owner:** AndriyKalashnykov/go-pub-sub

## Tech Stack

- Language: Go 1.26
- Linter: golangci-lint (config: `.golangci.yml`)
- CI: GitHub Actions (`.github/workflows/ci.yml`)
- Dependency management: Renovate (`renovate.json`)

## Build / Test / Lint Commands

```bash
make build       # Build binary
make test        # Run tests
make lint        # Run golangci-lint
make deps        # Install tool dependencies (golangci-lint, gocritic, gosec)
make update      # Update Go dependencies
make run         # Build and run locally
make critic      # Run gocritic checks
make sec         # Run gosec security scanner
```

## Project Structure

```
main/           # Application entry point
pubsub/         # Core PubSub implementation (subscribe, publish, close)
publisher/      # Publisher wrapper
subscriber/     # Subscriber wrapper
```

## Code Style

- Follow standard Go conventions (gofmt, goimports)
- Use `golangci-lint` for linting
- Immutable patterns preferred; avoid mutation where possible

## Improvement Backlog

- [ ] Add LICENSE file (MIT recommended)
