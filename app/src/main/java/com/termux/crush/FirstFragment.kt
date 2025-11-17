package com.termux.crush

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.termux.crush.databinding.FragmentFirstBinding

/**
 * A simple [Fragment] subclass as the default destination in the navigation.
 * This fragment implements the main Crush functionality for AI-powered coding assistance.
 */
class FirstFragment : Fragment() {

    private var _binding: FragmentFirstBinding? = null
    private val binding get() = _binding!!
    private lateinit var rappedIntegration: RappedIntegration

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentFirstBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        // Initialize Rapped integration
        rappedIntegration = RappedIntegration(requireContext())

        // Set up the Ask Crush button
        binding.askButton.setOnClickListener {
            val question = binding.questionInput.text.toString()
            if (question.isNotEmpty()) {
                askCrush(question)
            } else {
                Toast.makeText(context, "Please enter a question", Toast.LENGTH_SHORT).show()
            }
        }

        // Set up the Run in Termux button
        binding.runInTermuxButton.setOnClickListener {
            val response = binding.responseText.text.toString()
            if (response != "Response will appear here..." && response.isNotEmpty()) {
                runInTermux(response)
            } else {
                Toast.makeText(context, "No response to run", Toast.LENGTH_SHORT).show()
            }
        }

        // Set up the Copy button
        binding.copyButton.setOnClickListener {
            val response = binding.responseText.text.toString()
            if (response != "Response will appear here..." && response.isNotEmpty()) {
                copyToClipboard(response)
            } else {
                Toast.makeText(context, "No response to copy", Toast.LENGTH_SHORT).show()
            }
        }
    }

    /**
     * Simulate asking Crush (AI assistant) a question
     * In a real implementation, this would connect to an AI service
     */
    private fun askCrush(question: String) {
        // Show that we're processing
        binding.responseText.text = "Thinking...\n\nQuestion: $question"
        
        // In a real app, this would make a network request to an AI service
        // For now, we'll simulate a response after a short delay
        view?.postDelayed({
            val response = when {
                question.contains("hello", ignoreCase = true) || question.contains("hi", ignoreCase = true) -> {
                    "Hello there! I'm Crush, your AI coding assistant. How can I help you with your code today?"
                }
                question.contains("python", ignoreCase = true) -> {
                    "Here's a simple Python script to get you started:\n\n" +
                            "```python\n" +
                            "def hello_world():\n" +
                            "    print('Hello, World!')\n\n" +
                            "if __name__ == '__main__':\n" +
                            "    hello_world()\n" +
                            "```\n\n" +
                            "Save this as hello.py and run it with `python hello.py` in Termux."
                }
                question.contains("git", ignoreCase = true) -> {
                    "Here are some useful Git commands for Termux:\n\n" +
                            "1. `git clone <url>` - Clone a repository\n" +
                            "2. `git add .` - Add all changes\n" +
                            "3. `git commit -m \"message\"` - Commit changes\n" +
                            "4. `git push` - Push to remote repository\n\n" +
                            "Make sure you have Git installed in Termux with `pkg install git`"
                }
                question.contains("install", ignoreCase = true) -> {
                    "To install packages in Termux, use:\n\n" +
                            "`pkg update && pkg upgrade` - Update package list\n" +
                            "`pkg install <package-name>` - Install a package\n\n" +
                            "For example: `pkg install python`"
                }
                else -> {
                    "I understand you're asking about: \"$question\"\n\n" +
                            "As your AI assistant, I can help with various coding tasks. " +
                            "Try asking specific questions about:\n" +
                            "- Programming languages (Python, JavaScript, etc.)\n" +
                            "- Command line tools in Termux\n" +
                            "- Git operations\n" +
                            "- Package installation\n\n" +
                            "For example, try asking \"How do I install Python in Termux?\""
                }
            }
            
            binding.responseText.text = response
        }, 1000) // Simulate network delay
    }

    /**
     * Run a command in Termux through Rapped integration
     */
    private fun runInTermux(command: String) {
        // Extract code blocks from the response
        val codeBlockRegex = Regex("```[a-z]*\n(.*?)```", RegexOption.DOT_MATCHES_ALL)
        val matchResult = codeBlockRegex.find(command)
        val codeToRun = if (matchResult != null) {
            matchResult.groupValues[1].trim()
        } else {
            // If no code block found, use the entire response
            command
        }
        
        // Try to execute through Rapped integration
        if (rappedIntegration.isRappedInstalled()) {
            rappedIntegration.executeCommandInTermux(codeToRun)
        } else {
            // Fallback: copy to clipboard and show instruction
            copyToClipboard(codeToRun)
            Toast.makeText(context, "Copied to clipboard. Please install Rapped for direct execution.", Toast.LENGTH_LONG).show()
        }
    }

    /**
     * Copy text to clipboard
     */
    private fun copyToClipboard(text: String) {
        val clipboard = context?.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
        val clip = ClipData.newPlainText("Crush Response", text)
        clipboard.setPrimaryClip(clip)
        Toast.makeText(context, "Copied to clipboard", Toast.LENGTH_SHORT).show()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }
}