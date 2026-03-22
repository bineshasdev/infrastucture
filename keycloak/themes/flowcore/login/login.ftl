<#--
  FlowCore — login page.
  Pre-fills the username field from login_hint (login.username).
  Uses our custom template.ftl (no PatternFly).
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout
    displayMessage=!messagesPerField.existsError('username','password')
    displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??;
    section>

  <#-- ── Login form ───────────────────────────────────────── -->
  <#if section = "form">
    <#if realm.password>
      <form id="kc-form-login" action="${url.loginAction}" method="post" novalidate>

        <#-- ── Username / email ─────────────────────────────── -->
        <#if !usernameHidden??>
          <div class="fc-field <#if messagesPerField.existsError('username','password')>fc-field--error</#if>">
            <label class="fc-label" for="username">
              <#if !realm.loginWithEmailAllowed>${msg("username")}
              <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
              <#else>${msg("email")}
              </#if>
            </label>
            <input
              id="username"
              name="username"
              type="text"
              class="fc-input"
              value="${(login.username!'')}"
              tabindex="1"
              autofocus
              autocomplete="username"
              <#if (login.username!'') != ''>readonly</#if>
              placeholder="<#if !realm.loginWithEmailAllowed>username<#elseif !realm.registrationEmailAsUsername>username or email<#else>you@company.com</#if>"
              aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
            <#-- Show a "change account" link when pre-filled -->
            <#if (login.username!'') != ''>
              <div class="fc-hint">
                Not you?
                <a href="${url.loginRestartFlowUrl}" class="fc-link" tabindex="-1">Use a different account</a>
              </div>
            </#if>
          </div>
        </#if>

        <#-- ── Password ──────────────────────────────────────── -->
        <div class="fc-field <#if messagesPerField.existsError('username','password')>fc-field--error</#if>">
          <div class="fc-label-row">
            <label class="fc-label" for="password">${msg("password")}</label>
            <#if realm.resetPasswordAllowed>
              <a class="fc-link fc-link--small" href="${url.loginResetCredentialsUrl}" tabindex="5">
                ${msg("doForgotPassword")}
              </a>
            </#if>
          </div>
          <div class="fc-input-group">
            <input
              id="password"
              name="password"
              type="password"
              class="fc-input fc-input--password"
              tabindex="2"
              autocomplete="current-password"
              placeholder="••••••••••••"
              aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
            <button
              class="fc-pw-toggle"
              type="button"
              tabindex="-1"
              aria-label="${msg('showPassword')}"
              onclick="togglePassword(this)">
              <svg class="fc-pw-icon fc-pw-icon--show" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="M10 12.5a2.5 2.5 0 100-5 2.5 2.5 0 000 5z"/>
                <path fill-rule="evenodd" d="M.664 10.59a1.651 1.651 0 010-1.186A10.004 10.004 0 0110 3c4.257 0 7.893 2.66 9.336 6.41.147.381.146.804 0 1.186A10.004 10.004 0 0110 17c-4.257 0-7.893-2.66-9.336-6.41zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd"/>
              </svg>
              <svg class="fc-pw-icon fc-pw-icon--hide" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" style="display:none">
                <path fill-rule="evenodd" d="M3.28 2.22a.75.75 0 00-1.06 1.06l14.5 14.5a.75.75 0 101.06-1.06l-1.745-1.745a10.029 10.029 0 003.3-4.38 1.651 1.651 0 000-1.185A10.004 10.004 0 009.999 3a9.956 9.956 0 00-4.744 1.194L3.28 2.22zM7.752 6.69l1.092 1.092a2.5 2.5 0 013.374 3.373l1.091 1.092a4 4 0 00-5.557-5.557z" clip-rule="evenodd"/>
                <path d="M10.748 13.93l2.523 2.524a9.987 9.987 0 01-3.27.547c-4.258 0-7.894-2.66-9.337-6.41a1.651 1.651 0 010-1.186A10.007 10.007 0 012.839 6.02L6.07 9.252a4 4 0 004.678 4.678z"/>
              </svg>
            </button>
          </div>
        </div>

        <#-- ── Field-level error ─────────────────────────────── -->
        <#if messagesPerField.existsError('username','password')>
          <p class="fc-error-msg" role="alert">
            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
          </p>
        </#if>

        <#-- ── Remember me ───────────────────────────────────── -->
        <#if realm.rememberMe && !usernameHidden??>
          <label class="fc-checkbox-label">
            <input
              id="rememberMe"
              name="rememberMe"
              type="checkbox"
              class="fc-checkbox"
              tabindex="3"
              <#if login.rememberMe??>checked</#if>>
            <span>${msg("rememberMe")}</span>
          </label>
        </#if>

        <#-- ── Submit ────────────────────────────────────────── -->
        <input type="hidden" id="id-hidden-input" name="credentialId"
               <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
        <button
          id="kc-login"
          type="submit"
          class="fc-btn fc-btn--primary"
          tabindex="4">
          ${msg("doLogIn")}
        </button>

        <#-- ── Social / identity providers ─────────────────── -->
        <#if social?? && social.providers?has_content>
          <div class="fc-divider">
            <span>${msg("identity-provider-login-label")!'or continue with'}</span>
          </div>
          <div class="fc-social-list">
            <#list social.providers as p>
              <a id="social-${p.alias}"
                 class="fc-btn fc-btn--social"
                 href="${p.loginUrl}">
                <#if p.iconClasses?has_content>
                  <i class="${p.iconClasses!}" aria-hidden="true"></i>
                </#if>
                ${p.displayName!}
              </a>
            </#list>
          </div>
        </#if>

      </form>
    </#if>

  <#-- ── Register link ─────────────────────────────────────── -->
  <#elseif section = "info">
    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <p class="fc-info-text">
        ${msg("noAccount")}
        <a class="fc-link" href="${url.registrationUrl}" tabindex="6">${msg("doRegister")}</a>
      </p>
    </#if>
  </#if>

</@layout.registrationLayout>

<script>
  function togglePassword(btn) {
    var input   = document.getElementById('password');
    var iconShow = btn.querySelector('.fc-pw-icon--show');
    var iconHide = btn.querySelector('.fc-pw-icon--hide');
    if (input.type === 'password') {
      input.type = 'text';
      iconShow.style.display = 'none';
      iconHide.style.display = '';
      btn.setAttribute('aria-label', '${msg("hidePassword")}');
    } else {
      input.type = 'password';
      iconShow.style.display = '';
      iconHide.style.display = 'none';
      btn.setAttribute('aria-label', '${msg("showPassword")}');
    }
  }
</script>
