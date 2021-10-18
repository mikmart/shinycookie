#' Set up a Shiny app to use shinycookie
#'
#' Call this at least once in your UI code to make the JavaScript work. See
#' [cookies] for the enabled functionality.
#'
#' @importFrom htmltools htmlDependency
#' @export
useShinycookie <- function() {
  singleton(
    tagList(
      htmlDependency(
        name = "js-cookie",
        version = "3.0.1",
        src = c(href = "https://cdn.jsdelivr.net/npm/js-cookie@3.0.1/dist/"),
        script = "js.cookie.min.js"
      ),
      htmlDependency(
        name = "shinycookie",
        version = "0.1.0",
        package = "shinycookie",
        src = "js",
        script = "shinycookie.js"
      )
    )
  )
}


#' JavaScript cookies with Shiny
#'
#' Get, set and remove JavaScript cookies from your Shiny server function.
#' Make sure to call `useShinycookie()` in your UI to make the functions work.
#'
#' @param inputId The Shiny input id to be populated with the cookie value.
#' @param cookie The name of the cookie to access. If left `NULL` in
#'   `cookies_get()`, the input receives a named list of all current cookies.
#' @param value A string value to set the specified cookie to.
#' @param options A list of
#'   [attributes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies) to
#'   set when creating a cookie, e.g. `Secure` or `SameSite`. When removing a
#'   cookie, the attributes must match those that were used when it was created.
#' @param session The current [shiny::session] object.
#'
#' @seealso [JavaScript Cookie](https://github.com/js-cookie/js-cookie), the
#'   library that powers the JavaScript side of this package.
#'
#' @name cookies
NULL

#' @rdname cookies
#' @export
cookies_get <- function(inputId, cookie = NULL, session = getDefaultReactiveDomain()) {
  message <- list(inputId = inputId, cookie = cookie)
  session$sendCustomMessage("shinycookie:get", message)
}

#' @rdname cookies
#' @export
cookies_set <- function(cookie, value, options = list(), session = getDefaultReactiveDomain()) {
  message <- list(cookie = cookie, value = value, options = options)
  session$sendCustomMessage("shinycookie:set", message)
}

#' @rdname cookies
#' @export
cookies_remove <- function(cookie, options = list(), session = getDefaultReactiveDomain()) {
  message <- list(cookie = cookie, options = options)
  session$sendCustomMessage("shinycookie:remove", message)
}
