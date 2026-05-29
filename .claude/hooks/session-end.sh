#!/bin/bash
# Session-end hook — performs mechanical cleanup on task files.
# Intelligent summarization (decisions, progress narrative) must be done
# by the orchestrator agent before the session ends. This script handles
# the file-move side of the orchestrator's session-end checklist.

set -euo pipefail

CLAUDE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TASKS_DIR="$CLAUDE_DIR/tasks"
MEMORY_DIR="$CLAUDE_DIR/memory"

echo "=== [orchestrator] Session ending — running cleanup ==="

# 1. Move tasks with status: done to tasks/done/
for task_file in "$TASKS_DIR"/in-progress/*.md "$TASKS_DIR"/in-review/*.md "$TASKS_DIR"/backlog/*.md; do
  [ -f "$task_file" ] || continue
  if grep -qP '^\*\*status\*\*:\s*done' "$task_file" 2>/dev/null; then
    filename=$(basename "$task_file")
    mv "$task_file" "$TASKS_DIR/done/$filename"
    echo "  [moved] $filename → tasks/done/"
  fi
done

# 2. Move blocked tasks whose depends_on are all done
for task_file in "$TASKS_DIR"/blocked/*.md; do
  [ -f "$task_file" ] || continue
  deps=$(grep -oP 'depends_on:\s*\[(.*?)\]' "$task_file" 2>/dev/null | head -1 || true)
  if echo "$deps" | grep -qP '\[\]'; then
    filename=$(basename "$task_file")
    mv "$task_file" "$TASKS_DIR/backlog/$filename"
    echo "  [unblocked] $filename → tasks/backlog/ (no remaining deps)"
  fi
done

# 3. Report current task distribution
echo ""
echo "=== Task distribution ==="
for dir in backlog in-progress in-review blocked done; do
  count=$(find "$TASKS_DIR/$dir" -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
  echo "  tasks/$dir: $count"
done

echo ""
echo "=== [orchestrator] Cleanup complete ==="
echo "Reminder: if orchestrator has not yet updated memory/progress.md,"
echo "memory/decisions.md, or memory/known-issues.md, do so now."
