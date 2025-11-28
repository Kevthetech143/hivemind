// Shared security utilities for Edge Functions
// Use across all functions to prevent code duplication

/**
 * Get real client IP with anti-spoofing logic
 * Priority: CF-Connecting-IP > X-Real-IP > X-Forwarded-For (first IP)
 *
 * SECURITY NOTE: X-Forwarded-For can be spoofed. Always prefer
 * CF-Connecting-IP (if behind Cloudflare) or X-Real-IP (if behind trusted proxy)
 */
export function getRealClientIP(req: Request): string {
  // Priority 1: Cloudflare's CF-Connecting-IP (trusted)
  const cfIP = req.headers.get('cf-connecting-ip')
  if (cfIP) return cfIP

  // Priority 2: X-Real-IP (if behind nginx/trusted proxy)
  const realIP = req.headers.get('x-real-ip')
  if (realIP) return realIP

  // Priority 3: First IP in X-Forwarded-For chain (can be spoofed)
  const forwardedFor = req.headers.get('x-forwarded-for')
  if (forwardedFor) {
    const firstIP = forwardedFor.split(',')[0].trim()
    if (firstIP) return firstIP
  }

  // Fallback
  return 'unknown'
}

/**
 * Log security event to audit trail
 * Non-blocking - failures are logged but don't affect request
 */
export async function logSecurityEvent(
  supabaseClient: any,
  eventType: string,
  ipAddress: string,
  endpoint: string,
  details?: Record<string, any>
) {
  try {
    await supabaseClient
      .from('security_audit_log')
      .insert({
        event_type: eventType,
        ip_address: ipAddress,
        endpoint,
        details: details || {}
      })
  } catch (error) {
    console.error('Security audit log failed:', error)
    // Don't throw - logging failure shouldn't break the request
  }
}

/**
 * Check if IP is banned before processing request
 * Returns true if IP is banned
 */
export async function isIPBanned(
  supabaseClient: any,
  ipAddress: string
): Promise<boolean> {
  try {
    const { data, error } = await supabaseClient
      .from('banned_ips')
      .select('ip_address, reason, expires_at')
      .eq('ip_address', ipAddress)
      .maybeSingle()

    if (error) {
      console.error('Ban check error:', error)
      return false // Fail open - don't block on DB errors
    }

    if (!data) return false

    // Check if ban has expired
    if (data.expires_at) {
      const expiryDate = new Date(data.expires_at)
      if (expiryDate < new Date()) {
        // Ban expired - remove it
        await supabaseClient
          .from('banned_ips')
          .delete()
          .eq('ip_address', ipAddress)
        return false
      }
    }

    return true // IP is banned
  } catch (error) {
    console.error('Ban check error:', error)
    return false // Fail open
  }
}
