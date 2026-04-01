<#--
  HashiFlow — forgot-password / reset-password request page.
  The user enters their email; Keycloak sends the reset link.
-->
<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>

  <#if section = "form">
    <h1 class="fc-card-title">${msg("emailForgotTitle")}</h1>
    <p class="fc-card-subtitle">${msg("emailInstruction")}</p>

    <form id="kc-reset-password-form" action="${url.loginAction}" method="post">

      <div class="fc-field <#if messagesPerField.existsError('username')>fc-field--error</#if>">
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
          value="${(auth.attemptedUsername!'')}"
          autofocus
          autocomplete="username"
          placeholder="you@company.com"
          aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
        <#if messagesPerField.existsError('username')>
          <p class="fc-error-msg" role="alert">
            ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
          </p>
        </#if>
      </div>

      <div class="fc-btn-group">
        <button type="submit" class="fc-btn fc-btn--primary">
          ${msg("doSubmit")}
        </button>
        <a href="${url.loginUrl}" class="fc-btn fc-btn--ghost">
          ${msg("backToLogin")}
        </a>
      </div>

    </form>

  <#elseif section = "info">
    <#-- intentionally empty — info slot not used here -->
  </#if>

</@layout.registrationLayout>
