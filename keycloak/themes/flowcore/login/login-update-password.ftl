<#--
  HashiFlow — update-password page.
  Shown after the reset link is clicked, or when KC requires a password change.
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>

  <#if section = "form">
    <h1 class="fc-card-title">
      <#if isAppInitiatedAction??>
        ${msg("updatePasswordTitle")}
      <#else>
        Choose a new password
      </#if>
    </h1>

    <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
      <input type="text"     id="username"     name="username"     value="${username!''}" autocomplete="username"         style="display:none" readonly/>
      <input type="password" id="password-old" name="password-old"                       autocomplete="current-password" style="display:none"/>

      <#-- ── New password ──────────────────────────────────────── -->
      <div class="fc-field <#if messagesPerField.existsError('password')>fc-field--error</#if>">
        <label class="fc-label" for="password-new">${msg("passwordNew")}</label>
        <div class="fc-input-group">
          <input
            id="password-new"
            name="password-new"
            type="password"
            class="fc-input fc-input--password"
            autofocus
            autocomplete="new-password"
            placeholder="••••••••••••"
            aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"/>
          <button class="fc-pw-toggle" type="button" tabindex="-1"
                  aria-label="${msg('showPassword')}"
                  onclick="togglePassword(this,'password-new')">
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
        <#if messagesPerField.existsError('password')>
          <p class="fc-error-msg" role="alert">
            ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
          </p>
        </#if>
      </div>

      <#-- ── Confirm password ──────────────────────────────────── -->
      <div class="fc-field <#if messagesPerField.existsError('password-confirm')>fc-field--error</#if>">
        <label class="fc-label" for="password-confirm">${msg("passwordConfirm")}</label>
        <div class="fc-input-group">
          <input
            id="password-confirm"
            name="password-confirm"
            type="password"
            class="fc-input fc-input--password"
            autocomplete="new-password"
            placeholder="••••••••••••"
            aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"/>
          <button class="fc-pw-toggle" type="button" tabindex="-1"
                  aria-label="${msg('showPassword')}"
                  onclick="togglePassword(this,'password-confirm')">
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
        <#if messagesPerField.existsError('password-confirm')>
          <p class="fc-error-msg" role="alert">
            ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
          </p>
        </#if>
      </div>

      <div class="fc-btn-group">
        <#if isAppInitiatedAction??>
          <button type="submit" class="fc-btn fc-btn--primary" name="login-actions-reset-credentials">
            ${msg("doSubmit")}
          </button>
          <button type="submit" class="fc-btn fc-btn--ghost" name="cancel-aia" value="true">
            ${msg("doCancel")}
          </button>
        <#else>
          <button type="submit" class="fc-btn fc-btn--primary">
            ${msg("doSubmit")}
          </button>
        </#if>
      </div>

    </form>
  </#if>

</@layout.registrationLayout>

<script>
  function togglePassword(btn, fieldId) {
    var input    = document.getElementById(fieldId);
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
