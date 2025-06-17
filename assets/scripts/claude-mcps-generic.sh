#!/bin/bash

# Global MCP Management Script for Claude Code CLI
# Manages context7, supabase, and flymcp MCP servers
#
# SETUP INSTRUCTIONS:
# 1. Make this script executable: chmod +x claude-mcps-generic.sh
# 2. Create ~/.config/claude_env with your tokens:
#    echo 'SUPABASE_ACCESS_TOKEN="your_token_here"' > ~/.config/claude_env
#    chmod 600 ~/.config/claude_env
# 3. Install flymcp binary if needed: fly auth token | install at ~/.config/flymcp/flymcp
# 4. Ensure Claude Code CLI is installed: claude --version
# 5. Run: ./claude-mcps-generic.sh on
#
# REQUIREMENTS:
# - Claude Code CLI (https://docs.anthropic.com/en/docs/claude-code)
# - Supabase access token (optional, for Supabase MCP)
# - FlyCMP binary (optional, for Fly.io MCP)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Load environment variables for tokens
if [[ -f ~/.config/claude_env ]]; then
    source ~/.config/claude_env
fi

# Function to show usage
show_usage() {
    echo -e "${BLUE}Claude Code MCP Manager${NC}"
    echo -e "Usage: $0 {on|off|status|list}"
    echo -e ""
    echo -e "Commands:"
    echo -e "  ${GREEN}on${NC}      - Add all MCP servers (context7, supabase, flymcp)"
    echo -e "  ${YELLOW}off${NC}     - Remove all MCP servers"
    echo -e "  ${BLUE}status${NC}  - Show status of MCP servers"
    echo -e "  ${BLUE}list${NC}    - List all configured MCP servers"
}

# Function to add all MCP servers
add_mcps() {
    echo -e "${GREEN}[MCP] Adding MCP servers to Claude Code...${NC}"
    
    # Add context7 (remote SSE connection)
    echo -e "${BLUE}→${NC} Adding context7..."
    claude mcp add --transport sse context7 https://mcp.context7.com/sse
    
    # Add supabase (with token from environment)
    if [[ -n "$SUPABASE_ACCESS_TOKEN" ]]; then
        echo -e "${BLUE}→${NC} Adding supabase..."
        claude mcp add supabase -s local -e SUPABASE_ACCESS_TOKEN="$SUPABASE_ACCESS_TOKEN" -- npx @supabase/mcp-server-supabase@latest
    else
        echo -e "${YELLOW}⚠${NC} Supabase token not found in ~/.config/claude_env"
        echo -e "${YELLOW}  Please add: SUPABASE_ACCESS_TOKEN=\"your_token_here\"${NC}"
    fi
    
    # Add flymcp (local binary)
    if [[ -f ~/.config/flymcp/flymcp ]]; then
        echo -e "${BLUE}→${NC} Adding flymcp..."
        claude mcp add flymcp ~/.config/flymcp/flymcp
    else
        echo -e "${YELLOW}⚠${NC} FlyCMP binary not found at ~/.config/flymcp/flymcp"
    fi
    
    echo -e "${GREEN}✓ MCP servers added successfully${NC}"
}

# Function to remove all MCP servers
remove_mcps() {
    echo -e "${YELLOW}[MCP] Removing MCP servers from Claude Code...${NC}"
    
    echo -e "${BLUE}→${NC} Removing context7..."
    claude mcp remove context7 2>/dev/null || true
    
    echo -e "${BLUE}→${NC} Removing supabase..."
    claude mcp remove supabase 2>/dev/null || true
    
    echo -e "${BLUE}→${NC} Removing flymcp..."
    claude mcp remove flymcp 2>/dev/null || true
    
    echo -e "${GREEN}✓ MCP servers removed successfully${NC}"
}

# Function to show MCP status
show_status() {
    echo -e "${BLUE}[MCP] Checking MCP server status...${NC}"
    
    # Get list of configured MCPs
    mcp_list=$(claude mcp list 2>/dev/null)
    
    if [[ -z "$mcp_list" ]]; then
        echo -e "${YELLOW}No MCP servers configured${NC}"
        return
    fi
    
    echo -e "${GREEN}Configured MCP servers:${NC}"
    echo "$mcp_list"
    
    # Check individual server status
    echo -e "\n${BLUE}Server Status:${NC}"
    
    if echo "$mcp_list" | grep -q "context7"; then
        echo -e "${GREEN}✓${NC} context7 - configured"
    else
        echo -e "${RED}✗${NC} context7 - not configured"
    fi
    
    if echo "$mcp_list" | grep -q "supabase"; then
        echo -e "${GREEN}✓${NC} supabase - configured"
    else
        echo -e "${RED}✗${NC} supabase - not configured"
    fi
    
    if echo "$mcp_list" | grep -q "flymcp"; then
        echo -e "${GREEN}✓${NC} flymcp - configured"
    else
        echo -e "${RED}✗${NC} flymcp - not configured"
    fi
    
    # Check environment
    echo -e "\n${BLUE}Environment:${NC}"
    if [[ -n "$SUPABASE_ACCESS_TOKEN" ]]; then
        echo -e "${GREEN}✓${NC} Supabase token loaded"
    else
        echo -e "${RED}✗${NC} Supabase token not found"
    fi
    
    if [[ -f ~/.config/flymcp/flymcp ]]; then
        echo -e "${GREEN}✓${NC} FlyCMP binary found"
    else
        echo -e "${RED}✗${NC} FlyCMP binary not found"
    fi
}

# Function to list all MCP servers
list_mcps() {
    echo -e "${BLUE}[MCP] All configured MCP servers:${NC}"
    claude mcp list
}

# Main script logic
case "${1:-}" in
    "on")
        add_mcps
        ;;
    "off")
        remove_mcps
        ;;
    "status")
        show_status
        ;;
    "list")
        list_mcps
        ;;
    "")
        show_usage
        ;;
    *)
        echo -e "${RED}Error: Unknown command '$1'${NC}"
        show_usage
        exit 1
        ;;
esac