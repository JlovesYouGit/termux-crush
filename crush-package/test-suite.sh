#!/bin/bash
# Test suite for Termux Crush App
# This script runs a series of tests to verify the functionality of the Termux Crush App

echo "Termux Crush App Test Suite"
echo "==========================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TEST_COUNT=0
PASS_COUNT=0
FAIL_COUNT=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3"
    
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -n "Test $TEST_COUNT: $test_name ... "
    
    # Run the test command and capture output and exit code
    output=$(eval "$test_command" 2>&1)
    exit_code=$?
    
    # Check result
    if [ $exit_code -eq $expected_result ]; then
        echo -e "${GREEN}PASS${NC}"
        PASS_COUNT=$((PASS_COUNT + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Command: $test_command"
        echo "  Expected exit code: $expected_result"
        echo "  Actual exit code: $exit_code"
        echo "  Output: $output"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return 1
    fi
}

# Function to run a test with output checking
run_test_with_output() {
    local test_name="$1"
    local test_command="$2"
    local expected_output="$3"
    
    TEST_COUNT=$((TEST_COUNT + 1))
    echo -n "Test $TEST_COUNT: $test_name ... "
    
    # Run the test command and capture output
    output=$(eval "$test_command" 2>&1)
    exit_code=$?
    
    # Check if output contains expected text
    if echo "$output" | grep -q "$expected_output"; then
        echo -e "${GREEN}PASS${NC}"
        PASS_COUNT=$((PASS_COUNT + 1))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Command: $test_command"
        echo "  Expected output to contain: $expected_output"
        echo "  Actual output: $output"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        return 1
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Starting tests..."
echo ""

# Check prerequisites
echo "Checking prerequisites..."
if ! command_exists termux-info; then
    echo -e "${RED}ERROR: This test suite must be run within Termux environment${NC}"
    exit 1
fi

# Test 1: Check if Crush is installed
run_test "Crush CLI installation" "command -v crush" "0"

# Test 2: Check Crush help command
run_test_with_output "Crush help command" "crush --help" "Terminal-based AI assistant"

# Test 3: Check Crush version command
run_test "Crush version command" "crush --version" "0"

# Test 4: Check if Git is installed
run_test "Git installation" "command -v git" "0"

# Test 5: Check Git version
run_test_with_output "Git version" "git --version" "git version"

# Test 6: Check if Go is installed
run_test "Go installation" "command -v go" "0"

# Test 7: Check Go version
run_test_with_output "Go version" "go version" "go version"

# Test 8: Check if Vim is installed
run_test "Vim installation" "command -v vim" "0"

# Test 9: Check if Neovim is installed
run_test "Neovim installation" "command -v nvim" "0"

# Test 10: Check configuration directories
run_test "Configuration directory creation" "test -d \$HOME/.config/crush" "0"

# Test 11: Check data directories
run_test "Data directory creation" "test -d \$HOME/.local/share/crush" "0"

# Test 12: Check config file exists
run_test "Configuration file creation" "test -f \$HOME/.config/crush/config.json" "0"

# Test 13: Test basic Crush functionality
run_test "Basic Crush functionality" "echo '2+2' | crush run 'calculate' >/dev/null 2>&1" "0"

# Test 14: Test directory listing command
run_test_with_output "Directory listing" "crush dirs" "config"

# Test 15: Test package manager access
run_test_with_output "Package manager access" "pkg --version" "pkg"

echo ""
echo "Test Summary"
echo "============"
echo "Total tests: $TEST_COUNT"
echo -e "Passed: ${GREEN}$PASS_COUNT${NC}"
echo -e "Failed: ${RED}$FAIL_COUNT${NC}"

if [ $FAIL_COUNT -eq 0 ]; then
    echo ""
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo ""
    echo -e "${RED}Some tests failed. Please review the output above.${NC}"
    exit 1
fi