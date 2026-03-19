<#import "template.ftl" as layout>

<@layout.registrationLayout
    displayMessage=!messagesPerField.existsError('username','password')
    displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??;
    section>

  <#-- ── Brand header ────────────────────────────────────────────── -->
  <#if section = "header">
    <div class="fc-brand">
      <div class="fc-brand-logo">
        <svg viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
          <rect width="36" height="36" rx="8" fill="#4f8ef7"/>
          <path d="M10 18 L18 10 L26 18 L18 26 Z" fill="white" opacity="0.9"/>
          <circle cx="18" cy="18" r="4" fill="#4f8ef7"/>
        </svg>
        <span class="fc-brand-name">FlowCore</span>
      </div>
      <span class="fc-brand-tagline">Sign in to your workspace</span>
    </div>

  <#-- ── Login form ───────────────────────────────────────────────── -->
  <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
          <form id="kc-form-login" action="${url.loginAction}" method="post" onsubmit="return true;">

            <#-- Username / email -->
            <#if !usernameHidden??>
              <div class="${properties.kcFormGroupClass!}">
                <label for="username" class="${properties.kcLabelClass!}">
                  <#if !realm.loginWithEmailAllowed>${msg("username")}
                  <#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}
                  <#else>${msg("email")}
                  </#if>
                </label>
                <input tabindex="1"
                       id="username"
                       class="${properties.kcInputClass!}"
                       name="username"
                       value="${(login.username!'')}"
                       type="text"
                       autofocus
                       autocomplete="username"
                       placeholder="<#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>"
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                <#if messagesPerField.existsError('username','password')>
                  <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                  </span>
                </#if>
              </div>
            </#if>

            <#-- Password -->
            <div class="${properties.kcFormGroupClass!}">
              <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
              <div class="${properties.kcInputGroup!}">
                <input tabindex="2"
                       id="password"
                       class="${properties.kcInputClass!}"
                       name="password"
                       type="password"
                       autocomplete="current-password"
                       placeholder="${msg('password')}"
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                <button class="${properties.kcFormPasswordVisibilityButtonClass!}"
                        type="button"
                        aria-label="${msg('showPassword')}"
                        aria-controls="password"
                        data-password-toggle
                        data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}"
                        data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                        data-label-show="${msg('showPassword')}"
                        data-label-hide="${msg('hidePassword')}">
                  <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                </button>
              </div>
            </div>

            <#-- Remember me + forgot password row -->
            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
              <div id="kc-form-options">
                <#if realm.rememberMe && !usernameHidden??>
                  <div class="checkbox">
                    <label>
                      <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                             <#if login.rememberMe??>checked</#if>>
                      ${msg("rememberMe")}
                    </label>
                  </div>
                </#if>
                <div class="${properties.kcFormOptionsWrapperClass!}">
                  <#if realm.resetPasswordAllowed>
                    <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                  </#if>
                </div>
              </div>
            </div>

            <#-- Submit -->
            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
              <input type="hidden" id="id-hidden-input" name="credentialId"
                     <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
              <input tabindex="4"
                     class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                     name="login" id="kc-login" type="submit" value="${msg('doLogIn')}"/>
            </div>

          </form>
        </#if>

        <#-- Social / identity providers -->
        <#if social?? && social.providers?has_content>
          <div class="fc-divider">or continue with</div>
          <div id="kc-social-providers">
            <ul>
              <#list social.providers as p>
                <li>
                  <a id="social-${p.alias}"
                     class="${properties.kcFormSocialAccountListLinkClass!}"
                     href="${p.loginUrl}"
                     type="button">
                    <#if p.iconClasses?has_content>
                      <i class="${p.iconClasses!}" aria-hidden="true"></i>
                    </#if>
                    ${p.displayName!}
                  </a>
                </li>
              </#list>
            </ul>
          </div>
        </#if>

      </div>
    </div>

  <#-- ── Register link ────────────────────────────────────────────── -->
  <#elseif section = "info">
    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <div id="kc-registration-container">
        <div id="kc-registration">
          <span>${msg("noAccount")}
            <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a>
          </span>
        </div>
      </div>
    </#if>
  </#if>

</@layout.registrationLayout>
