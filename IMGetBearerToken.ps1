# —————————————————————————————————————————————————————————
# Request a Bearer Token
# —————————————————————————————————————————————————————————

# Your existing variables
$username        = "sander.eek@eden-akers.com.api"
$password        = "uYHtRC$^30FSv%^P"
$subscriptionKey = "4e07e8d8c3aa470bab377c38dc2bde6f"
$marketplaceCode = "eu"
$tokenEndpoint   = "https://api.cloud.im/marketplace/eu/"    # Base URL from your YAML’s servers list

# Construct the full token URL
$tokenUrl = "$($tokenEndpoint.TrimEnd('/'))/token"

# Basic‑Auth header value
$basicAuth = [Convert]::ToBase64String(
    [Text.Encoding]::ASCII.GetBytes("${username}:${password}")
)

# Headers required by POST /token
$headers = @{
    "Authorization"      = "Basic $basicAuth"
    "X-Subscription-Key" = $subscriptionKey
    "Content-Type"       = "application/json"
}

# Body must contain only the marketplace code :contentReference[oaicite:0]{index=0}
$body = @{ marketplace = $marketplaceCode } | ConvertTo-Json

# Execute the request
$tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method Post -Headers $headers -Body $body

# Extract and display the token
$bearerToken = $tokenResponse.token
Write-Output "Bearer Token: $bearerToken"
Write-Output "Expires In : $($tokenResponse.expiresInSeconds) seconds"
