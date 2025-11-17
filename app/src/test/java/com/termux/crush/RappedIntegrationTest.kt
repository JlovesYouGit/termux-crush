package com.termux.crush

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.MockitoAnnotations

class RappedIntegrationTest {

    @Mock
    private lateinit var context: Context

    @Mock
    private lateinit var packageManager: PackageManager

    private lateinit var rappedIntegration: RappedIntegration

    @Before
    fun setUp() {
        MockitoAnnotations.openMocks(this)
        `when`(context.packageManager).thenReturn(packageManager)
        rappedIntegration = RappedIntegration(context)
    }

    @Test
    fun `isRappedInstalled returns true when Rapped is installed`() {
        val intent = Intent()
        `when`(packageManager.getLaunchIntentForPackage("com.jlovesyougit.rapped")).thenReturn(intent)

        val result = rappedIntegration.isRappedInstalled()

        assertTrue(result)
    }

    @Test
    fun `isRappedInstalled returns false when Rapped is not installed`() {
        `when`(packageManager.getLaunchIntentForPackage("com.jlovesyougit.rapped")).thenReturn(null)

        val result = rappedIntegration.isRappedInstalled()

        assertFalse(result)
    }
}