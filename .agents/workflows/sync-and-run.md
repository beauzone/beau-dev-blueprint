---
description: Essential first steps after cloning or returning to a project
---

# Sync & Run Workflow

1. **Pull Latest Changes**
   - Ensure you are on the latest `main` or `dev` branch.

   ```bash
   git pull origin $(git branch --show-current)
   ```

2. **Environment Setup**
   - Install dependencies if `package.json` or `requirements.txt` changed.
   - Verify `.env` file exists and matches `.env.example`.

3. **Run Health Check**
   - Start the dev server and verify the core landing page or API health endpoint.

4. **Review Roadmap**
   - Check `docs/roadmap/` and `CLAUDE.md` to identify the current focus.
