#!/bin/bash
# ============================================================================
# GitHub Actions - Complete Documentation Reference
# ============================================================================
# 
# Purpose: Comprehensive guide to GitHub Actions, Git, and CI/CD workflows
# Usage: Run this file to display the documentation, or open it as a reference
# ============================================================================

echo "================================================================================"
echo "                     GITHUB ACTIONS COMPLETE DOCUMENTATION"
echo "================================================================================"
echo ""
echo "This file contains comprehensive documentation about GitHub Actions."
echo "To view specific sections, search for section markers like '=== SECTION 1 ==='"
echo ""
echo "================================================================================"
echo ""

# ===============================================================================
# SECTION 1: GETTING STARTED
# ===============================================================================

cat << 'EOF'

========================================
SECTION 1: GETTING STARTED
========================================

WHAT IS GITHUB ACTIONS?
-----------------------
GitHub Actions is a workflow automation service that enables you to automate 
processes related to your code repositories. You can set up workflows that 
automatically build, test, and deploy your code.

Analogy: Like a fully automated assembly line in a factory. As soon as new code 
enters GitHub, robots automatically: Inspect → Test → Package → Deploy.

CI/CD EXPLANATION:
------------------
CI (Continuous Integration): Automatically merge, build, and test every code change
CD (Continuous Delivery/Deployment): Automatically release validated code

Analogy:
- CI = Gmail autosaving your draft and spell-checking it
- CD = "Schedule Send" at 9 AM exactly

GIT, GITHUB & GITHUB ACTIONS:
-----------------------------
| Concept        | Role                           | Analogy                    |
|----------------|--------------------------------|----------------------------|
| Git            | Version control system (engine)| Engine of a car           |
| GitHub         | Platform hosting Git repos     | Garage + Showroom         |
| GitHub Actions | Automation service             | Self-driving feature      |

========================================
SECTION 2: GIT & GITHUB CRASH COURSE
========================================

REVERTING CHANGES (git revert):
-------------------------------
- Creates a NEW commit that undoes changes
- Maintains project history
- Usage: git revert <commit-id>

RESETTING CODE (git reset):
---------------------------
- Modifies commit history directly (unlike revert)

STAGING MULTIPLE FILES:
-----------------------
- Individual: git add file1.txt file2.txt
- All files: git add . or git add *
- Specific folder: git add folder-name/

GITIGNORE:
----------
Create .gitignore file and add patterns:
  .vscode/
  .DS_Store
  node_modules/

BRANCHES:
---------
- Pointers to different commits
- Default branch: main or master
- Create & switch: git checkout -b <new-branch>
- View branches: git branch
- Delete: git branch -d <branch-name>

MERGING BRANCHES:
----------------
1. Switch to target branch: git checkout main
2. Merge: git merge <feature-branch>
3. Resolve conflicts if any
4. Commit changes

CONNECTING LOCAL & REMOTE:
-------------------------
- Add remote: git remote add origin <repository-url>
- Push: git push origin main
- Pull: git pull origin main

CLONING:
--------
git clone <repository-url>

MAKING CHANGES AS NON-OWNER:
---------------------------
Option 1: Be added as collaborator (direct push access)
Option 2: Fork repository → Clone → Push to fork → Create Pull Request

GITHUB ISSUES & COLLABORATORS:
-----------------------------
- Issues track bugs, features, tasks
- Collaborators can be added with push permissions

PULL REQUESTS PROCESS:
---------------------
1. Make changes on branch
2. Push to GitHub
3. Create Pull Request
4. Review process
5. Merge when approved

FORKS:
------
- Creates personal copy of another's repository
- Propose changes without affecting original
- Sync fork with upstream: git remote add upstream <original-url>

========================================
SECTION 3: BASIC BUILDING BLOCKS
========================================

KEY COMPONENTS:
---------------
1. WORKFLOWS:
   - Automated processes triggered by events
   - Defined in YAML files (.github/workflows/)
   - Can contain one or more jobs

2. JOBS:
   - Set of instructions on a specified environment
   - Run in parallel by default (can be sequential with 'needs')
   - Can be conditional

3. STEPS:
   - Individual tasks within a job
   - Execute commands or use Actions
   - Run in order; failure stops subsequent steps

4. ACTIONS:
   - Reusable units of code
   - Can be official, community, or custom

EXAMPLE WORKFLOW:
----------------
name: CI Workflow
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v2
      - name: Install Dependencies
        run: npm install
      - name: Run Tests
        run: npm test

CREATE FIRST WORKFLOW:
---------------------
1. Go to Actions tab in repository
2. Choose template or "Set up workflow yourself"
3. Configure YAML file
4. Commit the workflow
5. Test by triggering the event

PUSH EVENT:
----------
on: 
  push:
    branches:
      - main

JOBS: PARALLEL VS SEQUENTIAL:
----------------------------
- Parallel (default): All jobs run simultaneously
- Sequential: Use 'needs' keyword to define dependencies

MULTIPLE TRIGGERS:
-----------------
on: 
  push:
  workflow_dispatch:   # Allows manual triggering

EXPRESSIONS & CONTEXT OBJECTS:
-----------------------------
- Expressions evaluate variables and return values
- Context objects contain metadata about workflow, job, environment
- Common contexts: github, env, jobs, secrets, runner

========================================
SECTION 4: WORKFLOWS & EVENTS DEEP DIVE
========================================

AVAILABLE EVENT TYPES:
---------------------
- Push events
- Pull Request events
- Scheduled events (cron)
- Workflow Dispatch (manual)
- Repository Dispatch (API)
- And many more...

EVENT FILTERS:
-------------
Limit which occurrences trigger workflow:
  on:
    push:
      branches:
        - main
      paths:
        - 'src/**'

ACTIVITY TYPES:
--------------
Granular control for events:
  on:
    pull_request:
      types: 
        - opened
        - reopened

SPECIAL BEHAVIOR: FORKS & PRS:
----------------------------
- Workflows from forked PRs require maintainer approval
- Security feature to prevent malicious code execution

CANCELLING & SKIPPING WORKFLOWS:
-------------------------------
- Use 'concurrency' to auto-cancel old runs on same branch
- Skip with commit message: [skip ci] or [no ci]

========================================
SECTION 5: JOB ARTEFACTS & OUTPUTS
========================================

JOB ARTEFACTS:
-------------
- Files generated during workflow execution
- Upload: actions/upload-artifact@v3
- Download: actions/download-artifact@v3

UPLOAD ARTEFACTS:
----------------
- name: Upload Artifacts
  uses: actions/upload-artifact@v3
  with:
    name: my-artifact
    path: dist/

DOWNLOAD ARTIFACTS:
------------------
- name: Download Artifacts
  uses: actions/download-artifact@v3
  with:
    name: my-artifact

JOB OUTPUTS (Simple values, not files):
--------------------------------------
jobs:
  generate_version:
    runs-on: ubuntu-latest
    outputs:
      version_number: ${{ steps.setver.outputs.version }}
    steps:
      - name: Generate version
        id: setver
        run: echo "version=1.0.0" >> $GITHUB_OUTPUT

  use_version:
    needs: generate_version
    runs-on: ubuntu-latest
    steps:
      - run: echo "Version: ${{ needs.generate_version.outputs.version_number }}"

DEPENDENCY CACHING:
------------------
- name: Cache node modules
  uses: actions/cache@v3
  with:
    path: node_modules
    key: ${{ runner.os }}-node-${{ hashFiles('package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-

========================================
SECTION 6: ENVIRONMENT VARIABLES & SECRETS
========================================

ENVIRONMENT VARIABLES:
---------------------
- Dynamic values that change per environment
- Store config like database credentials

DEFINING IN WORKFLOWS:
--------------------
jobs:
  build:
    env:
      DB_USER: ${{ secrets.DB_USER }}
      DB_PASSWORD: ${{ secrets.DB_PASSWORD }}

DEFAULT ENVIRONMENT VARIABLES:
----------------------------
- GITHUB_ACTION: Name of current action
- GITHUB_EVENT_NAME: Event that triggered workflow
- GITHUB_WORKSPACE: Repository checkout path
- GITHUB_REPOSITORY: owner/repo format
- GITHUB_RUN_ID: Unique identifier
- GITHUB_REF: Git reference (branch/tag)

SECRETS:
--------
- Stored securely in GitHub
- Never exposed in logs or code
- Set in: Repository → Settings → Secrets

REPOSITORY ENVIRONMENTS:
-----------------------
- Create: Settings → Environments
- Add protection rules (manual approval)
- Environment-specific secrets
- Reference: environment: production

========================================
SECTION 7: CONTROLLING WORKFLOW EXECUTION
========================================

CONDITIONAL STEPS & JOBS (if keyword):
-------------------------------------
steps:
  - name: Run tests
    run: npm test
    if: github.ref == 'refs/heads/main'

CONDITIONAL JOBS:
----------------
jobs:
  deploy:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest

SPECIAL CONDITIONAL FUNCTIONS:
----------------------------
- success(): All previous jobs succeeded
- failure(): Any previous job failed
- always(): Always run regardless
- cancelled(): Workflow was cancelled

Examples:
  if: success() && github.ref == 'refs/heads/main'
  if: failure()
  if: always()
  if: cancelled()

CONTINUE-ON-ERROR:
-----------------
- name: Risky step
  run: might-fail.sh
  continue-on-error: true   # Job continues even if step fails

MATRIX STRATEGIES:
----------------
strategy:
  matrix:
    node-version: [14, 16, 18]
    os: [ubuntu-latest, windows-latest]
    exclude:
      - os: windows-latest
        node-version: 14

REUSABLE WORKFLOWS:
------------------
# reusable-workflow.yml
name: Reusable
on:
  workflow_call:
    inputs:
      environment:
        required: true
        type: string
    secrets:
      api_key:
        required: true

# Calling workflow
jobs:
  call-workflow:
    uses: ./.github/workflows/reusable-workflow.yml
    with:
      environment: production
    secrets:
      api_key: ${{ secrets.API_KEY }}

========================================
SECTION 8: JOBS & DOCKER CONTAINERS
========================================

WHAT ARE CONTAINERS?
-------------------
- Standardized units packaging code + dependencies
- Environment isolation
- Reproducibility across environments
- Efficient resource use

RUN JOBS IN CONTAINERS:
---------------------
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: node:14
    steps:
      - uses: actions/checkout@v2
      - run: npm install

SERVICE CONTAINERS:
------------------
services:
  postgres:
    image: postgres:latest
    ports:
      - 5432:5432
    env:
      POSTGRES_DB: mydb
      POSTGRES_PASSWORD: password
    options: >-
      --health-cmd "pg_isready"
      --health-interval 10s

========================================
SECTION 9: BUILDING & USING CUSTOM ACTIONS
========================================

TYPES OF CUSTOM ACTIONS:
-----------------------
| Type                 | Best for                          |
|----------------------|-----------------------------------|
| Docker container     | Complex environments, any OS     |
| JavaScript action    | Fast, cross-platform, simple logic|
| Composite action     | Workflow reuse without complex code|

COMPOSITE ACTION STRUCTURE:
--------------------------
# .github/actions/my-action/action.yml
name: 'My Composite Action'
description: 'Runs multiple steps'
inputs:
  input1:
    description: 'Input description'
    required: true
outputs:
  output1:
    description: 'Output description'
    value: ${{ steps.step1.outputs.result }}
runs:
  using: 'composite'
  steps:
    - name: Checkout
      uses: actions/checkout@v3
    - name: Run script
      id: step1
      run: echo "result=done" >> $GITHUB_OUTPUT
      shell: bash

JAVASCRIPT ACTION:
-----------------
# action.yml
name: 'JS Action'
runs:
  using: 'node16'
  main: 'main.js'

# main.js
const core = require('@actions/core');
try {
  const input = core.getInput('my-input');
  core.setOutput('result', input);
  core.info('Action completed!');
} catch (error) {
  core.setFailed(error.message);
}

DOCKER ACTION:
-------------
# action.yml
name: 'Docker Action'
runs:
  using: 'docker'
  image: 'Dockerfile'

# Dockerfile
FROM node:16
COPY . .
ENTRYPOINT ["node", "/main.js"]

========================================
SECTION 10: SECURITY BEST PRACTICES
========================================

SCRIPT INJECTION ATTACKS:
------------------------
- Occurs when external input is used without validation
- Example: Using issue title in a command
- Prevention: Validate and sanitize all external inputs

GITHUB_TOKEN & PERMISSIONS:
--------------------------
- Automatically generated token for GitHub API
- Configure permissions in workflow:

permissions:
  contents: read
  issues: write
  pull-requests: read

OPENID CONNECT (OIDC) WITH AWS:
------------------------------
1. Add OpenID Connect provider in AWS IAM
2. Create IAM role with trust policy for GitHub
3. Restrict with 'sub' claim to specific repo
4. Use in workflow:

jobs:
  deploy:
    permissions:
      id-token: write
      contents: read
    steps:
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          role-to-assume: arn:aws:iam::123456789:role/github-actions-role
          aws-region: us-east-1

SECURITY CHECKLIST:
------------------
☐ Limit permissions (least privilege principle)
☐ Use GitHub Secrets for sensitive data
☐ Validate all external inputs
☐ Keep dependencies updated
☐ Monitor security alerts
☐ Avoid publishing sensitive info
☐ Use OIDC instead of static credentials
☐ Review access permissions regularly

========================================
QUICK REFERENCE CHEAT SHEET
========================================

COMMON COMMANDS:
---------------
git add .                           Stage all changes
git commit -m "message"             Commit changes
git push origin main                Push to remote
git pull origin main                Pull from remote
git branch                          List branches
git checkout -b feature             Create & switch branch
git merge feature                   Merge branch
git log                             View commit history
git revert <commit-id>              Revert commit (new commit)
git reset <commit-id>               Reset history (destructive)

GITHUB ACTIONS SYNTAX:
---------------------
name: workflow-name                  Workflow name
on: [push, pull_request]            Triggers
jobs:                                Jobs container
  job-name:
    runs-on: ubuntu-latest          Runner
    needs: other-job                Dependency
    if: condition                   Conditional
    env:                            Environment variables
      VAR: value
    steps:
      - name: step-name
        uses: action/name@version    Use action
        run: command                 Run command
        with:                        Action parameters
          param: value

========================================
EOF

echo ""
echo "================================================================================"
echo "                     END OF DOCUMENTATION"
echo "================================================================================"
echo ""
echo "💡 TIP: Search for '===' to navigate between sections"
echo "📚 For official documentation: https://docs.github.com/actions"
echo "================================================================================"
