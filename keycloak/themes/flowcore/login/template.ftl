<#--
  FlowCore — custom login layout template.
  Fully self-contained: no PatternFly / Bootstrap dependency.
  Parent = keycloak (for i18n messages only).
-->
<#macro registrationLayout
    bodyClass=""
    displayInfo=false
    displayMessage=true
    displayRequiredFields=false
    social={}>
<!DOCTYPE html>
<html lang="${locale!''}" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta name="robots" content="noindex, nofollow"/>
  <title>${msg("loginTitle",(realm.displayName!''))}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin=""/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,400;0,14..32,500;0,14..32,600;0,14..32,700;1,14..32,400&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="${url.resourcesPath}/css/styles.css"/>
</head>
<body>

<div class="fc-page">

  <#-- Background decorations -->
  <div class="fc-bg-glow fc-bg-glow--top" aria-hidden="true"></div>
  <div class="fc-bg-glow fc-bg-glow--bottom" aria-hidden="true"></div>

  <main class="fc-main" role="main">

    <#-- ── Brand ──────────────────────────────────────────── -->
    <div class="fc-brand" aria-label="${properties.flowcoreAppName!'FlowCore'}">
      <div class="fc-brand-logo">
        <svg width="44" height="44" viewBox="0 0 44 44" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
          <rect width="44" height="44" rx="12" fill="url(#fc-grad)"/>
          <path d="M14 23L22 15L30 23" stroke="white" stroke-width="2.8" stroke-linecap="round" stroke-linejoin="round"/>
          <path d="M14 30L22 22L30 30" stroke="white" stroke-width="2.8" stroke-linecap="round" stroke-linejoin="round" opacity="0.5"/>
          <defs>
            <linearGradient id="fc-grad" x1="0" y1="0" x2="44" y2="44" gradientUnits="userSpaceOnUse">
              <stop stop-color="#6366f1"/>
              <stop offset="1" stop-color="#4f8ef7"/>
            </linearGradient>
          </defs>
        </svg>
        <span class="fc-brand-name">${properties.flowcoreAppName!'FlowCore'}</span>
      </div>
      <p class="fc-brand-tagline">Sign in to your workspace</p>
    </div>

    <#-- ── Alert banner (shown above card) ────────────────── -->
    <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
      <div class="fc-alert fc-alert--${message.type!'info'}" role="alert" aria-live="polite">
        <#if message.type = 'error'>
          <svg class="fc-alert-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.28 7.22a.75.75 0 00-1.06 1.06L8.94 10l-1.72 1.72a.75.75 0 101.06 1.06L10 11.06l1.72 1.72a.75.75 0 101.06-1.06L11.06 10l1.72-1.72a.75.75 0 00-1.06-1.06L10 8.94 8.28 7.22z" clip-rule="evenodd"/>
          </svg>
        <#elseif message.type = 'warning'>
          <svg class="fc-alert-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M8.485 2.495c.673-1.167 2.357-1.167 3.03 0l6.28 10.875c.673 1.167-.17 2.625-1.516 2.625H3.72c-1.347 0-2.189-1.458-1.515-2.625L8.485 2.495zM10 5a.75.75 0 01.75.75v3.5a.75.75 0 01-1.5 0v-3.5A.75.75 0 0110 5zm0 9a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
          </svg>
        <#elseif message.type = 'success'>
          <svg class="fc-alert-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clip-rule="evenodd"/>
          </svg>
        </#if>
        <span>${kcSanitize(message.summary)?no_esc}</span>
      </div>
    </#if>

    <#-- ── Login card ──────────────────────────────────────── -->
    <div class="fc-card">
      <#nested "form">
    </div>

    <#-- ── Register / info link (below card) ──────────────── -->
    <#if displayInfo>
      <div class="fc-info">
        <#nested "info">
      </div>
    </#if>

  </main>
</div>

<#-- Keycloak auth-state element required for back-channel logout -->
<div id="kc-auth-state" style="display:none;"></div>

<#-- Inline scripts (back-channel logout, etc.) -->
<#if scripts??>
  <#list scripts as script>
    <script src="${script}" type="text/javascript"></script>
  </#list>
</#if>
<#if properties.scripts?has_content>
  <#list properties.scripts?split(' ') as script>
    <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
  </#list>
</#if>

</body>
</html>
</#macro>
