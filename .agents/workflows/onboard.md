---
description: Onboard this workspace from the universal blueprint
---

# Onboarding Workflow

Use this workflow to instantly set up an existing repository with your universal standards.

1. **Copy Standard Configs**
   - Copy `.vscode/extensions.json` from the blueprint.
   - Copy essential workflows from the blueprint's `.agents/workflows/` to the local `.agents/workflows/`.
2. **Initialize Local Instructions**
   - Create or update `.agents/instructions.md` with the universal baseline.

3. **Verify Setup**
   - Check if the extensions are installed.
   - Verify workflow visibility.

// turbo 4. Run the final sync
`bash onboard.sh --sync-local`
