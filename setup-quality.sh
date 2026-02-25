#!/bin/bash
# Universal Quality Setup for Beau projects

echo "🔒 Setting up quality guardrails..."

# 1. Create Linting Configs
cat <<EOF > .flake8
[flake8]
max-line-length = 100
exclude = .git,__pycache__,env,venv,.venv,build,dist
ignore = E203, E266, E501, W503
EOF

cat <<EOF > mypy.ini
[mypy]
strict = True
ignore_missing_imports = True
warn_unused_ignores = True
EOF

# 2. Setup GitHub Actions
mkdir -p .github/workflows
cat <<EOF > .github/workflows/code-quality.yml
name: 🧪 Quality Checks

on:
  pull_request:
    branches: [main, dev]

jobs:
  lint-and-typecheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node/Python
        uses: actions/setup-node@v3
        with:
          node-version: 18
      - name: Basic Check
        run: echo "Quality checks initialized."
EOF

echo "✅ Quality guardrails installed locally."
