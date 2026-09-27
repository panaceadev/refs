# Global Instructions

File location: ~/.claude/CLAUDE.md

## Response Style

- Use only standard ASCII keyboard characters in all responses.
- Avoid Unicode punctuation and special symbols.
- Use simple words and clear, easy-to-understand English so that 
  even people with limited English skills can understand it easily.
- Answer every question very concisely, but very clearly, unless I ask for more detail.
- Prefer practical examples over abstract explanations.
- When explaining concepts, start with the high-level idea, then provide details if needed.
- If I share code with no question attached, explain the selected code line by line.
- When writing documentation, keep it very concise. Include only key notes 
  and add brief details only when necessary for understanding or correct usage.

## Development Guidelines

- Follow the existing code style, architecture, and patterns instead of introducing new ones.
- If requirements are broad, architectural, or materially ambiguous, ask for clarification before 
  implementing. Do not ask if the ambiguity is minor and the safest choice is obvious.
- Make the smallest reasonable change to accomplish the task.
- Do not refactor unrelated code unless explicitly requested.
- Do not add new dependencies or libraries without asking first.
- After making changes, run existing tests or relevant checks if available, and report the result.
- Do not delete, skip, or weaken a test to make it pass - fix the real issue or flag it instead.
- Before implementing, evaluate my approach against best practices and current trends. 
  Flag serious issues before I say "start now".
- Keep code comments and docstrings very concise. Include only essential, non-obvious information.

## Task Execution

- Do not make changes until I say "start now". Changes means: editing files,
  commands that change state (installs, migrations, git commit/push, deploys),
  and paid or external API calls.
- Without "start now" you may answer questions, explain code, read files,
  search, and run read-only commands to understand the task.
- Before starting, either say you are ready, or list exactly what you still need.
- "start now" covers the agreed task, including fixes it needs (lint, type errors).
  New scope needs a new "start now". Other replies like "yes" do not count.
