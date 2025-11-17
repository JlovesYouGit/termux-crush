package com.termux.crush

import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast

/**
 * Helper class to handle integration with Rapped application
 * This class provides methods to communicate with Rapped for executing
 * Termux commands directly from the Crush app
 */
class RappedIntegration(private val context: Context) {
    
    companion object {
        private const val TAG = "RappedIntegration"
        private const val RAPPED_PACKAGE = "com.jlovesyougit.rapped"
        private const val RAPPED_EXECUTE_ACTION = "com.rapped.EXECUTE_COMMAND"
    }
    
    /**
     * Check if Rapped is installed on the device
     * @return true if Rapped is installed, false otherwise
     */
    fun isRappedInstalled(): Boolean {
        return try {
            val intent = context.packageManager.getLaunchIntentForPackage(RAPPED_PACKAGE)
            intent != null
        } catch (e: Exception) {
            Log.e(TAG, "Error checking if Rapped is installed", e)
            false
        }
    }
    
    /**
     * Execute a command in Termux through Rapped
     * @param command The command to execute
     * @param workingDirectory The working directory for the command (optional)
     * @return true if the command was sent successfully, false otherwise
     */
    fun executeCommandInTermux(command: String, workingDirectory: String? = null): Boolean {
        if (!isRappedInstalled()) {
            Toast.makeText(context, "Rapped is not installed", Toast.LENGTH_LONG).show()
            return false
        }
        
        return try {
            val intent = Intent().apply {
                action = RAPPED_EXECUTE_ACTION
                `package` = RAPPED_PACKAGE
                putExtra("command", command)
                workingDirectory?.let { putExtra("working_directory", it) }
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            
            context.startActivity(intent)
            Log.d(TAG, "Sent command to Rapped: $command")
            true
        } catch (e: Exception) {
            Log.e(TAG, "Error sending command to Rapped", e)
            Toast.makeText(context, "Failed to send command to Rapped", Toast.LENGTH_SHORT).show()
            false
        }
    }
    
    /**
     * Open Rapped application
     * @return true if Rapped was opened successfully, false otherwise
     */
    fun openRapped(): Boolean {
        if (!isRappedInstalled()) {
            Toast.makeText(context, "Rapped is not installed", Toast.LENGTH_LONG).show()
            return false
        }
        
        return try {
            val intent = context.packageManager.getLaunchIntentForPackage(RAPPED_PACKAGE)
            intent?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
            Log.d(TAG, "Opened Rapped application")
            true
        } catch (e: Exception) {
            Log.e(TAG, "Error opening Rapped", e)
            Toast.makeText(context, "Failed to open Rapped", Toast.LENGTH_SHORT).show()
            false
        }
    }
}