<#--
  HashiFlow — MFA / OTP verification page.
  Covers TOTP (authenticator app) and any other OTP credential type.
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>

  <#if section = "form">
    <h1 class="fc-card-title">${msg("loginOtpTitle")}</h1>
    <p class="fc-card-subtitle">${msg("loginOtpOneTime")!'Enter the code from your authenticator app'}</p>

    <form id="kc-otp-login-form" action="${url.loginAction}" method="post">

      <#-- ── OTP selector (when user has multiple devices) ─────── -->
      <#if otpLogin.userOtpCredentials?size gt 1>
        <div class="fc-field">
          <label class="fc-label">${msg("loginOtpSelectCredential")!'Select device'}</label>
          <div class="fc-otp-devices">
            <#list otpLogin.userOtpCredentials as otpCred>
              <label class="fc-otp-device <#if otpCred.id = otpLogin.selectedCredentialId>fc-otp-device--selected</#if>">
                <input
                  type="radio"
                  name="selectedCredentialId"
                  value="${otpCred.id}"
                  class="fc-otp-device-radio"
                  <#if otpCred.id = otpLogin.selectedCredentialId>checked</#if>/>
                <span class="fc-otp-device-name">${otpCred.userLabel!'Authenticator'}</span>
              </label>
            </#list>
          </div>
        </div>
      <#else>
        <#-- single credential — pass it as hidden so KC accepts the form -->
        <#if otpLogin.userOtpCredentials?size = 1>
          <input type="hidden" name="selectedCredentialId" value="${otpLogin.userOtpCredentials[0].id}"/>
        </#if>
      </#if>

      <#-- ── OTP code input ────────────────────────────────────── -->
      <div class="fc-field <#if messagesPerField.existsError('totp')>fc-field--error</#if>">
        <label class="fc-label" for="otp">${msg("loginOtpOneTime")!'One-time code'}</label>
        <input
          id="otp"
          name="otp"
          type="text"
          inputmode="numeric"
          pattern="[0-9 ]*"
          autocomplete="one-time-code"
          class="fc-input fc-input--otp"
          autofocus
          maxlength="8"
          placeholder="000 000"
          aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"/>
        <#if messagesPerField.existsError('totp')>
          <p class="fc-error-msg" role="alert">
            ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
          </p>
        </#if>
      </div>

      <button type="submit" id="kc-login" class="fc-btn fc-btn--primary">
        ${msg("doLogIn")}
      </button>

    </form>
  </#if>

</@layout.registrationLayout>
