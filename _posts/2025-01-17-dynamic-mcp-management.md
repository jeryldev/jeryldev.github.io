---
layout: post
title: "Automated Server-Dependent MCP Management for Phoenix LiveView Projects"
date: 2025-01-17
tags: [Elixir, Phoenix, AI, DevTools, Automation, MCP, Claude, Tidewave]
excerpt: "Most Claude Code CLI MCPs work great once configured, but server-dependent MCPs like Tidewave need to connect to specific project endpoints. Here's how I automated the connection management for seamless project switching."
---

## The Server-Dependent MCP Challenge

Working with Claude Code CLI across multiple Phoenix LiveView projects, I discovered an interesting distinction in how different MCPs behave:

**Global MCPs work perfectly once configured:**
- context7 (documentation) - always useful, no endpoint dependency
- supabase - connects to my account, works across all projects
- flymcp - deployment tool, project-agnostic

**But then there's Tidewave** - a powerful Phoenix runtime introspection tool that connects directly to your running Phoenix server via endpoints like `http://localhost:4000/tidewave/mcp`.

The problem? When I switch between projects, Tidewave keeps trying to connect to the previous project's endpoint:

*"Working on Project A at localhost:4000, switch to Project B running on localhost:3000, but Tidewave MCP is still configured for localhost:4000. Result: connection failures and wasted Claude context."*

My typical workflow involves:
- Working on my main Phoenix LiveView application during the day
- Switching to proof-of-concept projects after work with different server configurations
- Following along with "Ash Framework: Create Declarative Elixir Web Apps"
- Experimenting with hobby projects that run on different ports
- Dealing with custom host configurations in some projects

Each project switch meant manually reconfiguring or disabling the Tidewave MCP.

## The Real Problem: Endpoint-Dependent MCPs

Unlike most MCPs that are "set once and forget," **server-dependent MCPs need dynamic endpoint management**:

1. **Tidewave only works when connected to the correct Phoenix server endpoint**
2. **Different projects run on different ports** (4000, 3000, custom ports)
3. **Some projects have custom host configurations** beyond localhost  
4. **Projects without Tidewave shouldn't have the MCP active at all**
5. **Failed connections clutter Claude conversations** with error messages

This isn't about general MCP management - it's specifically about **automated endpoint detection and connection management** for server-dependent tools.

The automation opportunity was clear: *Can the computer detect which Phoenix project I'm in and automatically configure the correct Tidewave endpoint?*

## My Solution: Automated Endpoint Detection for Server-Dependent MCPs

I built two complementary Bash scripts to solve this endpoint management challenge for myself:

### 1. Global MCP Management (`claude-mcps-generic.sh`)
Handles the "set once and forget" MCPs that work across all projects:
- **context7**: Documentation lookup - no endpoint dependency
- **supabase**: Account-based connection - works everywhere
- **flymcp**: Deployment tool - project-agnostic

```bash
# Simple on/off controls for global tools
./claude-mcps-generic.sh on    # Add all stable MCPs
./claude-mcps-generic.sh off   # Remove all MCPs
./claude-mcps-generic.sh status # Check what's configured
```

### 2. Automated Tidewave Endpoint Management (`claude-tidewave-auto-generic.sh`)
This is the solution to the server-dependent MCP problem - **automatic endpoint detection and configuration**:

```bash
# Analyzes current Phoenix project and configures correct Tidewave endpoint
./claude-tidewave-auto-generic.sh auto
```

The script automatically:
- Detects if you're in a Phoenix project that uses Tidewave
- Reads the project's server configuration (host, port, scheme)
- Checks if the Phoenix server is actually running
- Tests if the Tidewave endpoint is responding
- Adds/removes the MCP based on the current project state
- Supports custom project configurations for non-standard setups

## How I Built the Endpoint Detection

The key insight was that **server-dependent MCPs need automated endpoint detection**. Here's how the Tidewave automation works:

### 1. **Project Detection**
```bash
# Checks if we're in a Phoenix project
check_phoenix_project() {
    if [[ ! -f "mix.exs" ]]; then
        print_error "Not in a Phoenix/Elixir project"
        exit 1
    fi
}
```

### 2. **Dependency Analysis**
```bash
# Scans mix.exs for Tidewave dependency
project_has_tidewave() {
    grep -q "{:tidewave" mix.exs 2>/dev/null
}
```

### 3. **Runtime Environment Check**
```bash
# Detects if Phoenix server is running
server_is_running() {
    detect_phoenix_config
    lsof -ti:$PHOENIX_PORT >/dev/null 2>&1
}
```

### 4. **Endpoint Verification**
```bash
# Tests if Tidewave endpoint is responding
endpoint_is_responding() {
    local url="${PHOENIX_SCHEME}://${test_host}:${PHOENIX_PORT}/tidewave/mcp"
    local http_code=$(curl $curl_opts -o /dev/null -w "%{http_code}" "$url")
    [[ "$http_code" == "200" || "$http_code" == "405" ]]
}
```

### 5. **The Decision Matrix for Server-Dependent MCPs**

The script uses this logic to manage Tidewave connections:

| Project Has Tidewave | Server Running | Endpoint Responds | MCP Status | Action |
|----------------------|----------------|-------------------|------------|---------|
| ✅ | ✅ | ✅ | ❌ | **Add MCP with correct endpoint** |
| ✅ | ✅ | ✅ | ✅ | **Keep MCP (already correct)** |
| ❌ | N/A | N/A | ✅ | **Remove MCP (wrong project)** |
| ✅ | ❌ | N/A | ✅ | **Remove MCP (server down)** |

The key benefit: automatic endpoint management. When I switch projects or restart servers, the Tidewave MCP automatically connects to the right endpoint or gets removed when not needed.

For projects with completely custom configurations that can't be auto-detected, the script includes support for manual overrides - just add your specific project to the custom configuration section.


## How I Use These Scripts

For day-to-day use, I set up the scripts with proper permissions and added them to my shell profile:

```bash
# Added to ~/.zshrc for quick access
alias tidewave-auto='/path/to/claude-tidewave-auto-generic.sh auto'
```

For truly seamless automation, I integrated the Tidewave script with my shell's directory change hooks:

```bash
# Auto-configure when entering directories
precmd() {
    if [[ -f mix.exs ]]; then
        /path/to/claude-tidewave-auto-generic.sh auto >/dev/null 2>&1
    fi
}
```

Now the endpoint configuration happens automatically whenever I switch between Phoenix projects.


## Conclusion: Solving the Server-Dependent MCP Problem

What started as curiosity about automating Tidewave endpoint management evolved into a broader solution for any server-dependent MCP in Claude Code CLI.

The impact on my Phoenix LiveView development workflow:
- **Project switches**: Tidewave automatically connects to the correct endpoint
- **Server restarts**: MCP reconnects when the server comes back up  
- **Non-Tidewave projects**: Clean Claude sessions without connection errors
- **Custom configurations**: Handles projects with non-standard host/port setups

This solution addresses a real gap I discovered in MCP tooling. While most MCPs work great as "set once and forget," server-dependent tools like Tidewave need automated endpoint management. 

The core principle I learned applies beyond just Tidewave: any MCP that connects to project-specific local servers can benefit from this pattern of automatic endpoint detection and configuration.

The scripts have made my multi-project Phoenix development workflow much smoother, and the approach could work for other server-dependent MCPs in different tech stacks too.

---

## Downloads

If you're interested to learn more about the scripts I mentioned in this article, you may refer to the following links:

- [claude-tidewave-auto-generic.sh](/assets/scripts/claude-tidewave-auto-generic.sh) - Automated context-aware MCP management
- [claude-mcps-generic.sh](/assets/scripts/claude-mcps-generic.sh) - Global MCP management

Make sure to read the setup instructions at the top of each script before using them.