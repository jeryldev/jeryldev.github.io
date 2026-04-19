---
layout: post
title: "Automating tmux Setup with dev-session-manager"
date: 2026-01-25
tags: [tmux, Bash, Developer Tools, Homebrew, Productivity]
description: "A Bash utility that creates pre-configured tmux sessions from YAML. Published as a Homebrew tap to eliminate the 2-3 min of terminal setup friction on every project switch."
image: /images/jeryl.jpg
excerpt: "I got tired of manually creating the same tmux windows every time I switched projects, so I built a tool to automate it and published it as a Homebrew tap."
---

## The Problem: Repetitive Terminal Setup

Every time I started working on something, I'd go through the same motions:

```bash
tmux new-session -s work
# Ctrl-b c (create window)
# Ctrl-b , (rename to "editor")
# Ctrl-b c
# Ctrl-b , (rename to "server")
# Ctrl-b c
# Ctrl-b , (rename to "terminal")
```

Multiply this by switching between work projects, side projects, and personal stuff throughout the day. I was spending 2-3 minutes on setup every time I context-switched.

**I wanted one command that would give me a ready-to-code environment.**

## Enter dev-session-manager

A simple Bash utility that creates pre-configured tmux sessions:

```bash
dev work      # Creates session with editor, server, tests windows
dev hobby     # Creates session for side projects
dev personal  # Creates session for personal coding
```

That's it. No manual window creation. No renaming. Just ready to work.

## How It Works

The tool reads session configurations from `~/.config/dev-sessions/` and creates tmux sessions based on YAML templates:

```yaml
# ~/.config/dev-sessions/work.yml
name: work
windows:
  - name: editor
    commands:
      - cd ~/code/work-project
      - nvim
  - name: server
    commands:
      - cd ~/code/work-project
      - mix phx.server
  - name: terminal
    commands:
      - cd ~/code/work-project
```

When you run `dev work`, the script:

1. Checks if the session already exists
2. If not, creates a new tmux session
3. Spawns windows defined in the config
4. Runs startup commands in each window
5. Attaches to the session

The core logic is straightforward:

```bash
create_session() {
  local config=$1
  local session_name=$(yq eval '.name' "$config")

  # Create session
  tmux new-session -d -s "$session_name"

  # Create windows
  yq eval '.windows[] | .name' "$config" | while read -r window_name; do
    tmux new-window -t "$session_name:" -n "$window_name"

    # Run commands for this window
    yq eval ".windows[] | select(.name == \"$window_name\") | .commands[]" "$config" | \
    while read -r cmd; do
      tmux send-keys -t "$session_name:$window_name" "$cmd" C-m
    done
  done

  # Attach
  tmux attach-session -t "$session_name"
}
```

## Publishing to Homebrew

I wrote this on vacation and wanted to make it easy to install. Publishing to Homebrew taught me how package managers actually work.

### Creating a Homebrew Tap

Homebrew "taps" are just Git repositories with a `Formula/` directory:

```bash
# Create tap repository
mkdir -p homebrew-tap/Formula
cd homebrew-tap

# Write the formula
cat > Formula/dev-session-manager.rb <<'EOF'
class DevSessionManager < Formula
  desc "Automate tmux session creation from YAML configs"
  homepage "https://github.com/jeryldev/homebrew-tap"
  url "https://github.com/jeryldev/dev-session-manager/archive/v1.0.0.tar.gz"
  sha256 "..."

  depends_on "tmux"
  depends_on "yq"

  def install
    bin.install "dev"
  end
end
EOF
```

The tricky part was getting the SHA256 hash right. Homebrew requires exact checksums:

```bash
# Generate SHA256 for the release tarball
curl -L https://github.com/jeryldev/dev-session-manager/archive/v1.0.0.tar.gz | shasum -a 256
```

### Publishing Process

1. **Tag a release** on the main project repository
2. **Calculate SHA256** of the release tarball
3. **Update Formula** with new URL and hash
4. **Push to tap repository**
5. **Test installation** on a clean machine

Users can now install with:

```bash
brew tap jeryldev/tap
brew install dev-session-manager
dev help
```

## What I Learned

**1. YAML for configuration was the right choice**

I considered JSON, TOML, and even custom formats. YAML won because:
- Human-readable and editable
- Supports comments
- `yq` CLI makes parsing trivial in Bash

**2. Idempotency matters**

The tool checks if a session exists before creating it. Running `dev work` multiple times doesn't break anything - it just attaches to the existing session.

**3. Homebrew formulas are just Ruby**

Understanding that formulas are Ruby classes demystified the whole process. The DSL is syntactic sugar over standard Ruby.

**4. Dependencies need to be explicit**

The formula declares `tmux` and `yq` as dependencies. Homebrew installs them automatically if missing. This prevents cryptic errors.

## Real-World Usage

My typical workflow now:

```bash
# Morning: Start work session
dev work

# After lunch: Switch to side project
dev hobby

# Evening: Personal coding
dev personal
```

Each command gives me exactly the layout I need. No manual setup.

## The Rough Documentation

I mentioned the documentation might be rough - I wrote this in a few hours on vacation. The README is functional but could use:

- Better examples for complex configurations
- Troubleshooting section
- GIF demos showing actual usage
- Migration guide from manual tmux usage

But it works. And that's enough for version 1.0.

## Try It Out

If you use tmux and find yourself doing the same setup routine, give it a shot:

```bash
brew tap jeryldev/tap
brew install dev-session-manager
dev help
```

The tool is open source:

- **GitHub:** [github.com/jeryldev/homebrew-tap](https://github.com/jeryldev/homebrew-tap)
- **Requirements:** tmux, yq, Bash 4.0+

Feedback and contributions welcome. If something breaks, file an issue.

## What's Next

Potential improvements:

- Support for nested panes (not just windows)
- Template inheritance (reuse common configurations)
- Integration with project detection (auto-detect project type)
- Support for environment variables in configs

For now, it solves my daily friction. That's good enough.

---

**Links:**

- [Homebrew Tap Repository](https://github.com/jeryldev/homebrew-tap)
- [tmux Documentation](https://github.com/tmux/tmux/wiki)
- [yq Documentation](https://mikefarah.gitbook.io/yq/)
