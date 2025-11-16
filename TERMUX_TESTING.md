# Testing Crush in Termux Environment

This document outlines the steps to test the Termux-compatible version of Crush.

## Prerequisites

1. Android device with Termux installed (preferably Android 15+)
2. Internet connection
3. API keys for at least one AI provider (e.g., Google Gemini)

## Test Environment Setup

### Installing Termux

1. Install Termux from F-Droid (recommended) or GitHub
2. Update packages:
   ```bash
   pkg update && pkg upgrade
   ```
3. Install dependencies:
   ```bash
   pkg install golang git
   ```

### Installing Crush

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/crush-termux.git
   cd crush-termux
   ```
2. Install Crush:
   ```bash
   go install .
   ```

### Setting Up API Keys

Set up at least one API key for testing:

```bash
# For Google Gemini
export GEMINI_API_KEY="your-api-key-here"

# For OpenAI
export OPENAI_API_KEY="your-api-key-here"
```

## Test Cases

### 1. Basic Installation Test

**Objective**: Verify Crush installs correctly in Termux

**Steps**:
1. Run `crush --help`
2. Verify the help text is displayed correctly

**Expected Result**: Crush should display help information without errors

### 2. Data Directory Creation Test

**Objective**: Verify Crush can create and access its data directory

**Steps**:
1. Run `crush dirs`
2. Check that both config and data directories are created in the correct locations
3. Verify the directories are accessible:
   ```bash
   ls -la ~/.config/crush/
   ls -la ~/.local/share/crush/
   ```

**Expected Result**: Both directories should be created and accessible

### 3. Configuration Test

**Objective**: Verify Crush can save and load configuration

**Steps**:
1. Run `crush` and enter an API key when prompted
2. Check that the configuration file is created:
   ```bash
   cat ~/.config/crush/crush.json
   ```
3. Run `crush` again and verify it loads the saved configuration

**Expected Result**: Configuration should be saved and loaded correctly

### 4. Basic AI Interaction Test

**Objective**: Verify Crush can communicate with an AI provider

**Steps**:
1. Run `crush`
2. Enter a simple prompt like "What is 2+2?"
3. Wait for the response

**Expected Result**: Crush should successfully communicate with the AI provider and display a response

### 5. File System Access Test

**Objective**: Verify Crush can access files in the Termux environment

**Steps**:
1. Create a test file:
   ```bash
   echo "This is a test file" > test.txt
   ```
2. Run `crush` and ask it to read the file:
   "Can you read the contents of test.txt?"
3. Verify it can access and read the file

**Expected Result**: Crush should be able to access and read local files

### 6. Shell Command Execution Test

**Objective**: Verify Crush can execute shell commands

**Steps**:
1. Run `crush`
2. Ask it to execute a simple command:
   "Run 'ls -la' and show me the results"
3. Verify it executes the command and shows the output

**Expected Result**: Crush should be able to execute shell commands and display results

### 7. Session Persistence Test

**Objective**: Verify Crush can save and restore conversation sessions

**Steps**:
1. Start a conversation with Crush
2. Ask a few questions
3. Exit Crush with Ctrl+C
4. Restart Crush
5. Check if the previous conversation is available

**Expected Result**: Previous conversation should be restored

### 8. Provider Update Test

**Objective**: Verify Crush can update provider information

**Steps**:
1. Run `crush update-providers`
2. Check that provider information is updated:
   ```bash
   cat ~/.local/share/crush/providers.json
   ```

**Expected Result**: Provider information should be successfully updated

## Troubleshooting Common Issues

### Issue: "command not found" when running crush

**Solution**: Make sure Go's bin directory is in your PATH:
```bash
export PATH=$PATH:~/go/bin
```

### Issue: Permission denied when creating directories

**Solution**: Check that Termux has the necessary permissions and that you're not trying to access restricted directories.

### Issue: API calls failing

**Solution**: 
1. Verify your API key is correct
2. Check your internet connection
3. Verify the API provider is working

### Issue: SQLite errors

**Solution**: This might indicate issues with file permissions or disk space. Check available storage and try reinstalling.

## Test Results Documentation

Document the results of each test case including:
- Test case name
- Pass/Fail status
- Any errors encountered
- Steps taken to resolve issues

## Performance Considerations

Note any performance issues such as:
- Slow response times
- High memory usage
- Battery drain

## Conclusion

After completing all test cases, you should have a good understanding of how well Crush works in the Termux environment and whether any additional modifications are needed.