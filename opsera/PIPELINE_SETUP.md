# Opsera Pipeline Configuration Guide

## Folder-Based Trigger Configuration

### Option 1: Git Webhook Path Filtering (Recommended)

Configure each pipeline with a webhook filter:

**Dev Pipeline:**
```
Trigger Condition: File path matches /dev/** OR /modules/**
```

**QA Pipeline:**
```
Trigger Condition: File path matches /qa/** OR /modules/**
```

**Prod Pipeline:**
```
Trigger Condition: File path matches /prod/** OR /modules/**
```

**Common Pipeline:**
```
Trigger Condition: File path matches /common/** OR /modules/**
```

### Option 2: Orchestrator Pattern

If Opsera doesn't support direct path filtering:

1. Create a **main orchestrator pipeline** triggered on any push to main
2. Add a **script step** that inspects changed files:
   ```bash
   git diff --name-only HEAD~1 HEAD
   ```
3. Based on output, trigger specific environment pipelines via Opsera API

### Option 3: Conditional Pipeline Steps

Each pipeline includes a conditional check:
```bash
CHANGED_FILES=$(git diff --name-only HEAD~1 HEAD)
if echo "$CHANGED_FILES" | grep -q "^dev/\|^modules/"; then
  echo "Running dev pipeline"
  cd dev && terraform plan
else
  echo "Skipping - no relevant changes"
  exit 0
fi
```

## Questions for Opsera Support

1. Does Opsera support webhook path filtering for Git triggers?
2. Can we configure regex patterns for triggering based on changed files?
3. What's the recommended approach for mono-repo folder-based triggers?
4. Is there an orchestrator/dispatcher pattern we should use?

## Testing the Setup

1. Make a change in `/dev/main.tf`
   - Expected: Only dev pipeline triggers
2. Make a change in `/modules/sample_module/main.tf`
   - Expected: All pipelines (dev, qa, prod, common) trigger
3. Make a change in `/prod/main.tf`
   - Expected: Only prod pipeline triggers
