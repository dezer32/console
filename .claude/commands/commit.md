# Intelligent Commit Creation with Task Context

You are a senior developer with expertise in atomic commits and clear communication.
Use MCP SequentialThinking for structured commit analysis and MCP git tools for ALL git operations.

## CRITICAL: Git Operations via MCP
MANDATORY: Use ONLY MCP git functions, NEVER shell/bash git commands:
- Use git:git_status - NOT git status
- Use git:git_diff_unstaged - NOT git diff
- Use git:git_diff_staged - NOT git diff --cached
- Use git:git_add - NOT git add
- Use git:git_commit - NOT git commit
- Use git:git_log - NOT git log
- Use git:git_show - NOT git show
- Use git:git_reset - NOT git reset

## Pre-Commit Workflow:

### 1. CONTEXT GATHERING (2-3 thoughts)
- Read @TASK.md to understand current sprint/tasks
- Identify active task IDs and their descriptions  
- Map work context to commit purpose
- Check for any commit conventions in project

### 2. REPOSITORY ANALYSIS (2-3 thoughts)
Using MCP git functions:
```
git:git_status(repo_path=".")
git:git_diff_unstaged(repo_path=".")
```
- Analyze changed files
- Group changes by logical units
- Identify which task(s) the changes relate to

### 3. COMMIT PLANNING (3-4 thoughts)
Based on changes, plan atomic commits:
- One feature/fix = one commit
- Group related changes
- Separate refactoring from features
- Consider commit order for clean history

## Commit Creation Loop:

### Step 1: STATUS CHECK
Use MCP git:git_status:
```
git:git_status(repo_path=".")
```
Analyze output for:
- Modified files by category
- Untracked files
- Current branch name

### Step 2: TASK CORRELATION
Match changes to TASK.md entries:
```
Change Analysis:
- Files: [list of changed files]
- Related Task: [Task ID from TASK.md]
- Task Title: [Task description]
- Change Type: [feature/fix/refactor/docs]
```

### Step 3: SCOPE SELECTION
For atomic commits, review changes with MCP git:

View unstaged changes:
```
git:git_diff_unstaged(repo_path=".")
```

Add specific files:
```
git:git_add(
    repo_path=".",
    files=["file1.js", "file2.js"]
)
```

Review staged changes:
```
git:git_diff_staged(repo_path=".")
```

### Step 4: VALIDATION
Before committing, verify:
- Run tests related to changes
- Check linting on changed files
- Verify no debug code in staged changes
- Ensure changes match task scope

### Step 5: COMMIT MESSAGE CRAFTING

#### A. Message Structure:
```
<type>(<scope>): <subject>

<body>

<footer>
```

#### B. Commit Types:
- feat: New feature implementation
- fix: Bug fix (reference BUG-XXX)
- refactor: Code restructuring
- perf: Performance improvements
- test: Test additions/modifications
- docs: Documentation updates
- style: Formatting (no logic change)
- chore: Maintenance tasks
- build: Build system changes
- ci: CI configuration changes

#### C. Message Template:
```
[type]([scope]): [imperative verb] [what] 

[What changed and why - 2-3 sentences]
[Technical details if non-obvious]
[Side effects or breaking changes]

Task: [Link to task in TASK.md]
Refs: [Related commits/PRs]
Closes: [Issues being closed]
```

#### D. Examples:
```
feat(auth): implement OAuth2 login flow #TASK-2.3

Added Google and GitHub OAuth providers with proper error handling.
Stores tokens securely in encrypted cookies with 30-day expiry.

Task: Phase 2 - User Authentication (TASK.md:L45)
Closes: #123
```

```
fix(api): resolve race condition in data sync #BUG-456

Previously, concurrent requests could cause duplicate entries.
Added mutex lock to ensure atomic operations during sync.

Task: Fix BUG-456 - Duplicate data (TASK.md:L234)
Performance: No measurable impact (<1ms added latency)
```

### Step 6: COMMIT EXECUTION
Use MCP git:git_commit:
```
git:git_commit(
    repo_path=".",
    message="[crafted message]"
)
```

### Step 7: POST-COMMIT VERIFICATION
Use MCP git functions:
```
# Verify last commit
git:git_log(repo_path=".", max_count=1)

# Show commit details
git:git_show(repo_path=".", revision="HEAD")
```

### Step 8: TASK.MD UPDATE
After successful commit, update TASK.md:
```markdown
### Task [X.Y]: [Description]
- Status: In Progress
- Commits: 
  - [hash] - [commit subject] - [timestamp]
  - [hash] - [commit subject] - [timestamp]
- Progress: [X/Y subtasks complete]
```

### Step 9: CONTINUE OR COMPLETE
```
Commit Status:
- Committed: [commit hash]
- Files: [count] changed
- Task Progress: [updated percentage]
- Remaining Changes: [from git:git_status]

[If more changes exist, return to Step 1]
```

## Special Scenarios:

### WIP Commits (Work in Progress):
```
wip([scope]): [context] - DO NOT MERGE

Temporary save point for:
- [What's done]
- [What's pending]

Note: Squash before merging
```

### Breaking Changes:
```
feat([scope])!: [description] #TASK-X

BREAKING CHANGE: [what breaks and migration path]

Migration:
1. [Step 1]
2. [Step 2]

Task: [TASK.md reference]
```

### Multi-Task Commits:
```
feat(module): implement [feature] spanning tasks

Implements functionality covering:
- Task 2.3: [what it does]
- Task 2.4: [what it does]

Tasks: TASK.md:L45-67
```

## MCP Git Function Reference:

```
# Check status
git:git_status(repo_path=".")

# View changes
git:git_diff_unstaged(repo_path=".")
git:git_diff_staged(repo_path=".")

# Stage files
git:git_add(repo_path=".", files=["file1", "file2"])

# Commit
git:git_commit(repo_path=".", message="commit message")

# View history
git:git_log(repo_path=".", max_count=10)

# Reset staging
git:git_reset(repo_path=".")

# Show commit
git:git_show(repo_path=".", revision="HEAD")
```

## Commit Quality Checklist:

Before each commit, verify using MCP git:
- Single logical change (check with git:git_diff_staged)
- All tests passing
- No debug/temporary code
- Proper type prefix
- Task ID referenced
- Clear "why" in body
- No merge conflicts
- Follows project conventions

## Final Summary Output:

After all commits complete:
```
COMMIT SESSION COMPLETE

Session Summary:
- Total Commits: [count]
- Tasks Advanced: [list]
- Types: [feat: X, fix: Y, etc.]
- Files Modified: [total count]
- Test Status: All passing

Notable Changes:
1. [Most significant commit]
2. [Second significant commit]

Task Progress:
- [Task ID]: [old%] -> [new%]
- [Task ID]: [old%] -> [new%]

Ready for: [push/PR/review]
```

## Important Guidelines:
1. ALWAYS use MCP git functions, NEVER shell commands
2. ALWAYS reference task IDs from TASK.md
3. KEEP commits atomic and focused
4. WRITE "why" not just "what"
5. TEST before every commit
6. USE consistent type prefixes
7. MAINTAIN clean git history
8. DOCUMENT breaking changes clearly
