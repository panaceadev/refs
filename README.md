- [Terminal](#terminal)
  - [Bash](#bash)
  - [Nano and Less](#nano-and-less)
  - [Command equivalents](#command-equivalents)
- [SSH](#ssh)
- [Git](#git)
  - [Commands](#commands)
  - [Commit Message Emojis](#commit-message-emojis)
- [Python](#python)
- [Node.js](#nodejs)
- [Docker](#docker)
- [HTML Entities](#html-entities)
- [HTTP errors](#http-errors)
- [JavaScript](#javascript)
- [Claude](#claude)
- [AWS CLI](#aws-cli)
- [Mock personal data for testing](#mock-personal-data-for-testing)
- [Chrome](#chrome)
- [VM Specs](#vm-specs)


# Terminal

## Bash

- `ctrl+u`: Delete everything before the cursor
- `ctrl+k`: Delete everything after the cursor
- `shift+pageup` / `shift+pagedown`: Scroll up/down one page
- `shift+home` / `shift+end`: Scroll to top/bottom
- `ctrl+shift+t`: Open a new terminal tab
- `ctrl+shift+w`: Close the current terminal tab

```bash
sudo apt install package_name
sudo apt install ~/Downloads/package_name.deb

sudo apt purge package_name

> .env  # Clear content of file

sudo chown -R user:group /path
chmod 400 /path   # -r--------
chmod 600 /path   # -rw-------
chmod 700 /path   # -rwx------

ln -s /path/to/original /path/to/symlink

du -sh /path 
df -h / 
free -h 
echo $XDG_SESSION_TYPE # Xorg or Wayland

ls ~/.bash_history-*.tmp
rm ~/.bash_history-*.tmp

zip -e filename.zip file-to-zip
zip -er filename.zip folder-to-zip/
unzip filename.zip
unzip filename.zip -d path/to/extract/

# Generating secrets
openssl rand 32 | openssl base64 -A
python -c "import secrets; print(secrets.token_urlsafe(32))"

find . -name "*.ts" 2>/dev/null
grep -R "keyword" /path 2>/dev/null
rg --no-ignore --follow "keyword" /path 2>/dev/null 

tree -a -L 2 -I "node_modules|.git" .
tree -d -L 1 .

passwd # change password of current user
sudo passwd unclaimai # change password of other user

sudo apt-mark hold google-chrome-stable
sudo apt-mark unhold google-chrome-stable
sudo apt-mark showhold
```

## Nano and Less

```bash
nano -l file.md     # line numbers
nano -lv file.md    # read-only mode

alt+n         # toggle line numbers
alt+shift+3   # //
alt+\         # to the top
ctrl+home     # //
alt+/         # to the bottom
ctrl+end      # //
ctrl+k        # cut the selected text or current line if no selection
alt+down      # scroll one line down without moving cursor
alt+up        # scroll one line up without moving cursor
```

```bash
less -N file.md     # line numbers

-N            # toggle line numbers
/pattern      # search
n             # next occurrence 
N             # previous occurrence
```

## Command equivalents

| bash                    | powershell               | cmd                                   |
| ----------------------- | ------------------------ | ------------------------------------- |
| `ping -c 20 github.com` | `ping -n 20 github.com`  | `ping -n 20 github.com`               |
| `clear`                 | `cls`                    | `cls`                                 |
| `cd`                    | `cd`                     | `cd` / `cd /d D:\path` (change drive) |
| `ls`                    | `ls`                     | `dir`                                 |
| `ls -A`                 | `ls -Force`              | `dir /a`                              |
| `mkdir`                 | `mkdir`                  | `mkdir` / `md`                        |
| `pwd`                   | `pwd`                    | `cd`                                  |
| `cat file`              | `cat file`               | `type file`                           |
| `touch file`            | `ni file`                | `type nul > file`                     |
| `rm file`               | `rm file`                | `del file`                            |
| `rm -rf dir`            | `rm -Recurse -Force dir` | `rmdir /s /q dir`                     |
| `cp src dst`            | `cp src dst`             | `copy src dst`                        |
| `cp -r src dst`         | `cp -Recurse src dst`    | `robocopy src dst /e`                 |
| `mv`                    | `mv`                     | `move` / `ren` (rename)               |
| `echo $X`               | `$env:X`                 | `echo %X%`                            |
| `~`                     | `~`                      | `%USERPROFILE%`                       |
| `sudo`                  | `sudo`                   | `sudo` (Win 11 24H2+)                 |
| `apt install`           | `winget install`         | `winget install`                      |

> ℹ️ macOS zsh uses the same commands shown under Bash, except package installation typically uses `brew install` instead of `apt install`.

# SSH

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_github-ad -C "github-ad" -N ""
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_unclaimai-vps -C "unclaimai-vps" -N ""
ssh-keygen -R 2.25.65.247 # remove old SSH key from known_hosts

ssh -i ~/.ssh/myserver.pem ubuntu@203.0.113.10
ssh host # with ~/.ssh/config
ssh -o PubkeyAuthentication=no ubuntu@203.0.113.10 # force password auth
ssh -v ubuntu@203.0.113.10 # verbose/debug

scp path/to/file ubuntu@203.0.113.10:path/
scp -r path/to/dir/ ubuntu@203.0.113.10:path/
scp ubuntu@203.0.113.10:path/to/file ./
scp -r ubuntu@203.0.113.10:path/to/dir ./

scp -i ~/.ssh/myserver.pem ubuntu@203.0.113.10:path/to/file ./
scp -o PubkeyAuthentication=no -r path/to/dir vm_user@99.34.25.29:Documents/temp/

# Compare remote and local .env files
ssh unclaimai-ec2 cat /opt/unclaim-ai/.env | diff -u - deploy/.env
```

```bash
ssh -o UserKnownHostsFile=/dev/null -o PubkeyAuthentication=no sb@vps.irscpa.com
```

```ini
# ~/.ssh/config

# GitHub - aarondentrodev@gmail.com
Host github-ad
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_ad
    IdentitiesOnly yes

# GitHub - panaceadev88@gmail.com
Host github-pd
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_pd
    IdentitiesOnly yes

# Hostinger VPS - unclaimai
Host unclaimai-vps
    HostName 2.25.65.247
    User unclaimai
    IdentityFile ~/.ssh/id_ed25519_unclaimai-vps
    IdentitiesOnly yes

# AWS EC2 - unclaimai
Host unclaimai-ec2
    HostName 3.232.238.158
    User ubuntu
    IdentityFile ~/.ssh/unclaimai-ec2.pem
    IdentitiesOnly yes

# Fail fast, retry fast on connect (use when network is unstable)
Host *
    ConnectTimeout 3
    ConnectionAttempts 2
    ServerAliveInterval 5
    ServerAliveCountMax 2
```

# Git

## Commands

```bash
GIT_SSH_COMMAND="ssh -v -o ConnectTimeout=3 -o ConnectionAttempts=1" git fetch

git config user.name
git config user.email

git remote add origin git@github.com:username/repo-name.git
git remote set-url origin git@github.com:username/repo-name.git
git remote -v

git branch      # All local branches
git branch -r   # All remote branches
git branch -a   # All branches (local and remote)
git branch -vv  # All local branches with tracking info

git fetch --all --prune

git pull --rebase # Pull changes from remote and replays your local commits on top of them

git switch -c dev
git switch --track mainclone/nrm # useful when track other remote branch
git switch -d e4022a9

git status
git status -u # Show every untracked file

git reset # Unstage all
git restore . # Undo all changes
git reset --hard # Same as `git reset && git restore .`
git clean -fd # Remove untracked files and directories from the working directory

git reset --hard main # Make current branch point to exactly where main points.

git stash -u # Stash both tracked and untracked files
git stash pop
git stash list

git merge --squash dev # Merge all changes from 'dev' into a single commit

git reset --soft HEAD~1 # Undo the last commit and keep changes in the Index (staging area)

# Amend the last commit without changing its message
git add . # Need to stage changes first
git commit --amend --no-edit 

git push origin -d branch-to-delete # Delete a branch from the remote

# Squashing, Renaming and Changing Earlier Commits
git rebase -i --root
git rebase -i b21a362
squash  # squash
reword  # rename
edit    # change

# Worktree
git worktree add -b frontend ../my-project-frontend main
git worktree list
git worktree remove ../my-project-frontend
```

## Commit Message Emojis

| Type     | Emoji | Meaning                                    |
| -------- | ----- | ------------------------------------------ |
| feat     | ✨     | new functionality                          |
| fix      | 🐛     | bug fix                                    |
| refactor | ♻️     | restructure code without changing behavior |
| chore    | 🔧     | config, dependencies, tooling, maintenance |
| docs     | 📝     | documentation-only changes                 |
| style    | 🎨     | formatting-only changes                    |
| test     | ✅     | test-only changes                          |
| perf     | ⚡     | specific performance improvement           |

# Python

```bash
source .venv/bin/activate

# using system python
/bin/python3 --version
/usr/bin/python3 --version

which python
pyenv versions
pyenv which python
pyenv prefix

pyenv global 3.13
pyenv local 3.13
pyenv shell 3.13

pre-commit run # staged files only
pre-commit run --all-files
pre-commit run eslint
pre-commit run prettier -v # for debugging and logging
git commit --no-verify # bypass the hooks

uv sync --locked
uv sync --frozen
uv run fastapi dev app/main.py
```

# Node.js

```bash
node --version
yarn --version
pnpm --version

npm ci
yarn install --frozen-lockfile
pnpm install --frozen-lockfile

npm i axios
pnpm add axios

npx eslint
pnpm exec eslint

npm run dev -- -p 3001

# Use this command to avoid DNS resolution issues for any npm/yarn/pnpm install command.
NODE_OPTIONS="--dns-result-order=ipv4first --no-network-family-autoselection" npm install
```

# Docker 

```bash
sudo systemctl restart docker

docker stop container_name
docker start container_name
docker rm container_name
docker rm -f container_name # stop and remove in one command
docker exec -it container_name <sh|bash>

docker rmi image_name_or_id
docker image prune # removes dangling images, safe

docker volume rm volume-name
docker network rm network-name

# Set the Compose files to use by default.
# Same as: docker compose -f compose.yml -f compose.production.yml ...
# Option 1: Add to ./.env (preferred for project-specific configuration).
COMPOSE_FILE=compose.yml:compose.production.yml
# Option 2: Set for the current shell (add to ~/.bashrc to persist).
export COMPOSE_FILE=compose.yml:compose.production.yml

# --no-cache flag is usually not necessary here.
docker compose build

docker compose ps
docker compose up -d
docker compose up -d --wait db
docker compose down -v # remove containers, networks, volumes

docker compose stop backend
docker compose start backend

docker compose exec backend <sh|bash>

docker login ghcr.io -u username
docker manifest inspect ghcr.io/username/image-name:latest
docker logout ghcr.io
```

# HTML Entities
| Name       | Number     | Result | Description                        |
| ---------- | ---------- | ------ | ---------------------------------- |
| `&nbsp;`   | `&#160;`   | ` `    | Non-breaking space                 |
| `&amp;`    | `&#38;`    | `&`    | Ampersand                          |
| `&quot;`   | `&#34;`    | `"`    | Double quotation mark              |
| `&apos;`   | `&#39;`    | `'`    | Single quotation mark (Apostrophe) |
| `&lt;`     | `&#60;`    | `<`    | Less than                          |
| `&gt;`     | `&#62;`    | `>`    | Greater than                       |
| `&minus;`  | `&#8722;`  | `−`    | Minus sign                         |
| `&middot;` | `&#183;`   | `·`    | Middle dot                         |
| `&dollar;` | `&#36;`    | `$`    | Dollar                             |
| `&plus;`   | `&#43;`    | `+`    | Plus                               |
| `&mdash;`  | `&#8212;`  | `—`    | Em dash                            |
| `&ndash;`  | `&#8211;`  | `–`    | En dash                            |
| `&lsquo;`  | `&#8216;`  | `‘`    | Left single quotation mark         |
| `&rsquo;`  | `&#8217;`  | `’`    | Right single quotation mark        |
| `&ldquo;`  | `&#8220;`  | `“`    | Left double quotation mark         |
| `&rdquo;`  | `&#8221;`  | `”`    | Right double quotation mark        |
| `&bull;`   | `&#8226;`  | `•`    | Bullet                             |
| `&sect;`   | `&#167;`   | `§`    | Section sign                       |
| `&hellip;` | `&#8230;`  | `…`    | Horizontal ellipsis                |
| `&check;`  | `&#10003;` | `✓`    | Check mark                         |
| -          | `&#8209;`  | `‑`    | Non-breaking hyphen                |

# HTTP errors

| Code | Description                                                                 |
| ---- | --------------------------------------------------------------------------- |
| 200  | OK - successful GET/update                                                  |
| 201  | Created - successful POST/create                                            |
| 202  | Accepted - request has been accepted for processing but is not yet complete |
| 204  | No Content - successful request with no response body                       |
| 400  | Bad Request - validation error                                              |
| 401  | Unauthorized - login/token problem                                          |
| 403  | Forbidden - permission problem                                              |
| 404  | Not Found - resource missing                                                |
| 409  | Conflict - duplicate/conflicting data                                       |
| 500  | Internal Server Error - unexpected backend error                            |

# JavaScript

```ts
await new Promise((resolve) => setTimeout(resolve, 5000));

throw new Error("Error message");
```

# Claude

- `/btw`: Ask a quick side question without interrupting the main conversation.
- `/usage`: Account & Usage
- `shift+tab`: Cycle through permission modes, use to switch to auto mode

```bash
claude mcp list
claude mcp remove asana
```

# AWS CLI

- Install / Update: 
  - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Config files:
  - `~/.aws/config`: contains profile names and region settings
  - `~/.aws/credentials`: contains AWS access keys for each profile

```bash
aws --version
# Create or update the AWS CLI configuration for the specified profile
aws configure --profile profile_name
# Shows the current configuration
aws configure list # default profile
aws configure list --profile profile_name

# List all S3 buckets
aws s3 ls # default profile
aws s3 ls --profile profile_name
# List all objects in the specified S3 bucket
aws s3 ls s3://your-bucket-name --recursive --profile profile_name
```

# Mock personal data for testing

```json
{
  "first_name": "John",
  "middle_name": "Q",
  "last_name": "Doe",
  "initials": "JD",
  "email": "john.doe@example.com",
  "phone": "+1234567890",
  "date_of_birth": "1990-11-11",

  "address_line_1": "123 Main St",
  "address_line_2": "Apt 4B",
  "city": "Anytown",
  "state": "CA",
  "zip": "12345",
  "country": "USA",
  
  "ssn": "123-45-6789",
  "federal_tax_id": "12-3456789",
  "driver_license": "D1234567",
  "passport": "P1234567",

  "bank": "Example Bank",
  "bank_account": "1234567890",
  "credit_card": "4242424242424242",
  "expiration_date": "12/25",
  "cvv": "123",
  
  "company": "Example Corp",
}
```

# Chrome

<a href="chrome://password-manager/settings">Disable google password save prompt</a>

<a href="http://google.com/ncr">No country redirect</a>

# VM Specs

**System**
- 65536 20

**Ubuntu**
- 24576/24 6
- 32768/32 6 
- 36864/36 8 
- 40960/40 8 --- current
- 45056/44 12
- 49152/48 12

**Windows**
- 8192/8   4
- 12288/12 4
- 16384/16 4 --- current 
- 16384/16 8

**2 machines at the same time**
- 40960/40 8
- 16384/16 4

**3 machines at the same time**
- 32768/32 8
- 12288/12 4
- 12288/12 4
