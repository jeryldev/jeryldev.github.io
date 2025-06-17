#!/bin/bash

# Claude Tidewave Auto-Configuration Script
# Automatically manages Tidewave MCP based on project needs
#
# SETUP INSTRUCTIONS:
# 1. Make this script executable: chmod +x claude-tidewave-auto-generic.sh
# 2. Install mcp-proxy if using stdio transport (default)
# 3. Ensure Claude Code CLI is installed and working: claude --version
# 4. Run from any Phoenix project directory: ./claude-tidewave-auto-generic.sh
# 5. (Optional) Add custom project configurations in add_tidewave_mcp() function
#
# CUSTOM PROJECT CONFIGURATION:
# If you have projects with custom host configurations that don't follow
# standard Phoenix config patterns, add them to the add_tidewave_mcp() function:
#
# Example:
#   if [[ "$(basename $(pwd))" == "my-special-project" ]]; then
#       local url="http://custom-host:3000/tidewave/mcp"
#   elif [[ "$(basename $(pwd))" == "another-project" ]]; then
#       local url="https://dev.example.com:4001/tidewave/mcp"
#   else
#       local url="${PHOENIX_SCHEME}://${mcp_host}:${PHOENIX_PORT}/tidewave/mcp"
#   fi
#
# REQUIREMENTS:
# - Claude Code CLI (https://docs.anthropic.com/en/docs/claude-code)
# - mcp-proxy binary (for stdio transport) or SSE support
# - Phoenix/Elixir project with mix.exs
# - Tidewave dependency in mix.exs (if using Tidewave)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default port for Phoenix
PHOENIX_PORT=${PHOENIX_PORT:-4000}
PHOENIX_HOST=${PHOENIX_HOST:-localhost}
PHOENIX_SCHEME=${PHOENIX_SCHEME:-http}

# MCP Transport configuration
MCP_TRANSPORT=${MCP_TRANSPORT:-stdio}  # stdio or sse
MCP_PROXY_PATH=${MCP_PROXY_PATH:-"$HOME/.config/mcp-proxy"}

# Function to print colored output
print_status() {
    echo -e "${GREEN}[TIDEWAVE]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[TIDEWAVE]${NC} $1"
}

print_error() {
    echo -e "${RED}[TIDEWAVE]${NC} $1"
}

# Check if we're in a Phoenix project
check_phoenix_project() {
    if [[ ! -f "mix.exs" ]]; then
        print_error "Not in a Phoenix/Elixir project (no mix.exs found)"
        exit 1
    fi
}

# Check if project has Tidewave dependency
project_has_tidewave() {
    grep -q "{:tidewave" mix.exs 2>/dev/null
}

# Check if project has Tidewave actually configured and ready
project_tidewave_ready() {
    project_has_tidewave && project_has_tidewave_configured
}

# Check if Phoenix server is running on the port
server_is_running() {
    detect_phoenix_config
    # Check both HTTP and HTTPS ports for Phoenix
    lsof -ti:$PHOENIX_PORT >/dev/null 2>&1 || \
    lsof -ti:4000 >/dev/null 2>&1 || \
    lsof -ti:4001 >/dev/null 2>&1
}

# Check if Tidewave MCP is currently configured
mcp_is_configured() {
    claude mcp list 2>/dev/null | grep -q "tidewave" 2>/dev/null
}

# Get the exact Tidewave MCP name (might be different case or format)
get_tidewave_mcp_name() {
    claude mcp list 2>/dev/null | grep -i tidewave | cut -d: -f1 | head -1
}

# Check if project has Tidewave configured in endpoint
project_has_tidewave_configured() {
    local endpoint_file=$(find lib -name "endpoint.ex" 2>/dev/null | head -1)
    if [[ -n "$endpoint_file" ]]; then
        # Look for either direct plug or conditional plug
        grep -q -E "(plug Tidewave|Code\.ensure_loaded\?\(Tidewave\))" "$endpoint_file" 2>/dev/null
    else
        false
    fi
}

# Extract Tidewave configuration from project
detect_project_tidewave_config() {
    if ! project_has_tidewave_configured; then
        return 1
    fi
    
    if [[ -f "config/dev.exs" ]]; then
        # Extract Tidewave-specific config if it exists
        local tidewave_config=$(grep -A 10 'config :tidewave' config/dev.exs 2>/dev/null)
        
        # Extract root domain from config
        local root_domain=$(grep 'root_domain.*=' config/dev.exs | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
        
        # Extract ports from port_http and port_https variables
        local config_port_http=$(grep 'port_http.*=' config/dev.exs | head -1 | sed -E 's/.*\|\| "([0-9]+)".*/\1/')
        local config_port_https=$(grep 'port_https.*=' config/dev.exs | head -1 | sed -E 's/.*\|\| "([0-9]+)".*/\1/')
        
        # Extract scheme from endpoint url config
        local config_scheme=$(grep -A 5 'config.*Endpoint' config/dev.exs | grep 'scheme:' | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
        
        # Extract configured host directly from dev.exs
        local config_host=$(grep '^host = ' config/dev.exs | head -1)
        if [[ "$config_host" =~ \"([^\"#]+)#\{([^}]+)\}\" ]]; then
            # Handle interpolated string like "app.#{root_domain}"
            local prefix="${BASH_REMATCH[1]}"
            local variable="${BASH_REMATCH[2]}"
            if [[ "$variable" == "root_domain" && -n "$root_domain" ]]; then
                config_host="${prefix}${root_domain}"
            fi
        else
            # Handle literal string
            config_host=$(echo "$config_host" | sed -E 's/host = "([^"]+)".*/\1/')
        fi
        
        local detected_host="localhost"
        if [[ -n "$config_host" ]]; then
            # Use the explicitly configured host from dev.exs
            detected_host="$config_host"
        elif [[ -n "$root_domain" ]]; then
            # Fallback: use root domain directly
            detected_host="$root_domain"
        fi
        
        PHOENIX_HOST="$detected_host"
        
        # Update scheme and ports
        [[ -n "$config_scheme" ]] && PHOENIX_SCHEME="$config_scheme"
        
        # Use HTTPS if configured, otherwise HTTP
        if [[ "$config_scheme" == "https" && -n "$config_port_https" ]]; then
            PHOENIX_PORT="$config_port_https"
        elif [[ -n "$config_port_http" ]]; then
            PHOENIX_PORT="$config_port_http"
        fi
        
        return 0
    fi
    
    return 1
}

# Fallback to global/default Phoenix configuration
detect_global_phoenix_config() {
    # Default values for typical Phoenix setup
    PHOENIX_HOST=${PHOENIX_HOST:-localhost}
    PHOENIX_PORT=${PHOENIX_PORT:-4000}
    PHOENIX_SCHEME=${PHOENIX_SCHEME:-http}
    
    # Try to detect if server is running on common ports
    if lsof -ti:4001 >/dev/null 2>&1; then
        PHOENIX_PORT=4001
        PHOENIX_SCHEME=https
    elif lsof -ti:4000 >/dev/null 2>&1; then
        PHOENIX_PORT=4000
        PHOENIX_SCHEME=http
    fi
}

# Main configuration detection
detect_phoenix_config() {
    # Try project-specific Tidewave config first
    if detect_project_tidewave_config; then
        print_status "Using project-specific Tidewave configuration"
        return 0
    fi
    
    # Fallback to global configuration
    print_warning "No project-specific Tidewave config found, using global defaults"
    detect_global_phoenix_config
}

# Test if Tidewave endpoint is responding
endpoint_is_responding() {
    detect_phoenix_config
    
    # Use localhost for endpoint testing (more reliable for local development)
    local test_host="localhost"
    local url="${PHOENIX_SCHEME}://${test_host}:${PHOENIX_PORT}/tidewave/mcp"
    
    # For HTTPS with self-signed certificates, use -k flag
    local curl_opts="-s --max-time 2"
    [[ "$PHOENIX_SCHEME" == "https" ]] && curl_opts="$curl_opts -k"
    
    # Test endpoint (405 Method Not Allowed is acceptable - means endpoint exists)
    local http_code=$(curl $curl_opts -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)
    
    # 200 = OK, 405 = Method Not Allowed (endpoint exists), 400 = Bad Request (endpoint exists), 500 = Server Error (endpoint exists but has issues)
    [[ "$http_code" == "200" || "$http_code" == "405" || "$http_code" == "400" || "$http_code" == "500" ]]
}

# Add Tidewave MCP
add_tidewave_mcp() {
    detect_phoenix_config
    
    local mcp_host="${PHOENIX_HOST}"
    
    # Custom project configurations
    # Add your specific projects here if they don't follow standard Phoenix config
    # Example:
    # if [[ "$(basename $(pwd))" == "my-special-project" ]]; then
    #     local url="http://custom-host:3000/tidewave/mcp"
    # elif [[ "$(basename $(pwd))" == "another-project" ]]; then
    #     local url="https://dev.example.com:4001/tidewave/mcp"
    # else
    #     local url="${PHOENIX_SCHEME}://${mcp_host}:${PHOENIX_PORT}/tidewave/mcp"
    # fi
    
    # Default: use detected configuration
    local url="${PHOENIX_SCHEME}://${mcp_host}:${PHOENIX_PORT}/tidewave/mcp"
    
    if [[ "$MCP_TRANSPORT" == "stdio" ]]; then
        if [[ ! -x "$MCP_PROXY_PATH" ]]; then
            print_error "mcp-proxy not found at $MCP_PROXY_PATH"
            return 1
        fi
        print_status "Adding Tidewave MCP connection via stdio transport to $url..."
        claude mcp add --scope user --transport stdio tidewave "$MCP_PROXY_PATH" "$url"
    else
        print_status "Adding Tidewave MCP connection via SSE transport to $url..."
        claude mcp add --scope user --transport sse tidewave "$url"
    fi
}

# Remove Tidewave MCP
remove_tidewave_mcp() {
    local mcp_name=$(get_tidewave_mcp_name)
    if [[ -n "$mcp_name" ]]; then
        print_status "Removing Tidewave MCP connection ($mcp_name)..."
        # Try different scopes
        claude mcp remove --scope user "$mcp_name" 2>/dev/null || \
        claude mcp remove --scope local "$mcp_name" 2>/dev/null || \
        claude mcp remove "$mcp_name" 2>/dev/null || true
    else
        print_warning "No Tidewave MCP found to remove"
    fi
}

# Main configuration logic
configure_tidewave() {
    check_phoenix_project
    
    local project_needs_tidewave=false
    local server_running=false
    local endpoint_working=false
    local mcp_configured=false
    
    print_status "Analyzing Tidewave configuration for $(basename $(pwd))..."
    
    # Check current state
    if project_has_tidewave; then
        project_needs_tidewave=true
        print_status "✓ Project has Tidewave dependency in mix.exs"
    else
        print_warning "✗ Project does not have Tidewave dependency"
        print_status "→ No action needed (project doesn't use Tidewave)"
        return 0
    fi
    
    if server_is_running; then
        server_running=true
        print_status "✓ Phoenix server is running on ${PHOENIX_SCHEME}://${PHOENIX_HOST}:${PHOENIX_PORT}"
    else
        print_warning "✗ Phoenix server is not running on port $PHOENIX_PORT"
    fi
    
    if mcp_is_configured; then
        mcp_configured=true
        print_status "✓ Tidewave MCP is currently configured in Claude Code"
    else
        print_warning "✗ Tidewave MCP is not configured in Claude Code"
    fi
    
    # Test endpoint if everything looks good
    if $project_needs_tidewave && $server_running; then
        print_status "→ Testing Tidewave endpoint connectivity..."
        if endpoint_is_responding; then
            endpoint_working=true
            print_status "✓ Tidewave endpoint is responding (localhost test successful)"
        else
            print_warning "✗ Tidewave endpoint is not responding (check Phoenix endpoint configuration)"
        fi
    fi
    
    # Decision logic with explanations
    if $project_needs_tidewave && $server_running && $endpoint_working; then
        if ! $mcp_configured; then
            print_status "→ All requirements met. Configuring Tidewave MCP..."
            add_tidewave_mcp
        else
            print_status "✓ Tidewave MCP already configured and working"
        fi
    elif $mcp_configured && ! $project_needs_tidewave; then
        print_warning "→ Removing Tidewave MCP (not needed for this project)"
        remove_tidewave_mcp
    elif $mcp_configured && ! $server_running; then
        print_warning "→ Phoenix server not running, removing Tidewave MCP"
        remove_tidewave_mcp
    else
        print_status "→ No action needed (requirements not met for MCP configuration)"
        if ! $server_running; then
            print_warning "  Reason: Phoenix server is not running"
        fi
        if ! $endpoint_working && $server_running; then
            print_warning "  Reason: Tidewave endpoint is not responding"
        fi
    fi
}

# Show current status
show_status() {
    check_phoenix_project
    detect_phoenix_config
    
    echo "=== Tidewave Configuration Status ==="
    echo "Project directory: $(pwd)"
    echo "Phoenix URL: ${PHOENIX_SCHEME}://${PHOENIX_HOST}:${PHOENIX_PORT}"
    
    if project_tidewave_ready; then
        echo "Config source: 📁 Project-specific Tidewave configuration"
    else
        echo "Config source: 🌐 Global/fallback configuration"
    fi
    echo
    
    if project_has_tidewave; then
        echo "✅ Project has Tidewave dependency"
    else
        echo "❌ Project does not have Tidewave dependency"
    fi
    
    if project_has_tidewave_configured; then
        echo "✅ Project has Tidewave configured in endpoint"
    else
        echo "❌ Project does not have Tidewave configured in endpoint"
    fi
    
    if server_is_running; then
        echo "✅ Phoenix server is running"
    else
        echo "❌ Phoenix server is not running"
    fi
    
    if mcp_is_configured; then
        echo "✅ Tidewave MCP is configured"
    else
        echo "❌ Tidewave MCP is not configured"
    fi
    
    if project_has_tidewave && server_is_running && endpoint_is_responding; then
        echo "✅ Tidewave endpoint is responding"
    else
        echo "❌ Tidewave endpoint is not responding"
    fi
}

# Manual override functions
force_enable() {
    check_phoenix_project
    if ! project_has_tidewave; then
        print_error "Cannot force enable: Project does not have Tidewave dependency"
        exit 1
    fi
    add_tidewave_mcp
}

force_disable() {
    remove_tidewave_mcp
}

# Main script logic
case "${1:-auto}" in
    "auto")
        configure_tidewave
        ;;
    "on"|"enable")
        force_enable
        ;;
    "off"|"disable")
        force_disable
        ;;
    "status"|"check")
        show_status
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [auto|on|off|status|help]"
        echo ""
        echo "Commands:"
        echo "  auto     - Automatically configure based on project (default)"
        echo "  on       - Force enable Tidewave MCP"
        echo "  off      - Force disable Tidewave MCP"
        echo "  status   - Show current configuration status"
        echo "  help     - Show this help message"
        echo ""
        echo "Environment variables:"
        echo "  PHOENIX_PORT     - Phoenix server port (default: 4000)"
        echo "  MCP_TRANSPORT    - Transport type: stdio or sse (default: stdio)"
        echo "  MCP_PROXY_PATH   - Path to mcp-proxy binary (default: ~/.config/mcp-proxy)"
        ;;
    *)
        print_error "Unknown command: $1"
        echo "Run '$0 help' for usage information"
        exit 1
        ;;
esac