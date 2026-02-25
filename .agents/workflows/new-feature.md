---
description: How to create a new feature branch, implement changes, and open a pull request
---

# New Feature Workflow

1. **Sync with Main**
   - Ensure the local `main` branch is up to date.

   ```bash
   git checkout main
   git pull origin main
   ```

2. **Branch Creation**
   - Create a descriptive feature branch.

   ```bash
   git checkout -b feature/<feature-name>
   ```

3. **Implementation**
   - Perform the code changes based on the task requirement.
   - Run local checks (lint/test) before committing.

4. **Commit & Push**
   - Commit with a clear, descriptive message.
   - Push to the remote.

   ```bash
   git add -A
   git commit -m "[feature] <descriptive message>"
   git push -u origin feature/<feature-name>
   ```

5. **PR & Review**
   - Open a Pull Request on GitHub.
   - After approval, merge and delete the local branch.
