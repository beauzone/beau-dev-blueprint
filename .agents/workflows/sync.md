# Sync Workflow (Cross-Machine)

Use this workflow when switching between your Mac Mini and MacBook Air to ensure everything is perfectly in sync.

## 1. Leaving Machine (Ritual)
Before you step away from your current machine:
1. **Push Feature Branches**: Ensure all work-in-progress is committed and pushed to GitHub.
2. **Sync Blueprint**: If you've modified your environment (e.g., added a new tool or MCP server):
   - Run `brew bundle dump --force --file=~/Desktop/antigravity/beau-dev-blueprint/Brewfile`
   - Push changes in `~/Desktop/antigravity/beau-dev-blueprint`.

## 2. Arriving Machine (Setup)
When you sit down at the other machine:
1. **Update Blueprint**: 
   - `cd ~/Desktop/antigravity/beau-dev-blueprint && git pull`
2. **Run Onboarding**:
   - `bash ~/Desktop/antigravity/beau-dev-blueprint/onboard.sh`
   - This will automatically sync your `mcp_config.json`, `Brewfile`, and VS Code settings.
3. **Pull Project**:
   - `git pull` on the project you are working on.
