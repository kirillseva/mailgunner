#' Send email via mailgun.
#'
#' Must set \code{mailgunner.api_key} and \code{mailgunner.domain_name} options.
#' @seealso
#'   Official mailgun documentation
#'   \url{https://documentation.mailgun.com/quickstart-sending.html#send-via-api}
#' @param from character. Either \code{"someone" --> someone@domain.com} or
#'   \code{c("Somebody Amazing", "someone") --> "Somebody Amazing <someone@domain.com>"}
#' @param to character. Email addresses of recipients.
#' @param subject character. Email subject.
#' @param text character. Email text.
#' @param tag character. Mailgun tags (I still don't really know what this is but why not).
#' @param attach character. Filenames of your attachments.
#' @export
send_email <- function(from, to, subject, text, attach = NULL, tag = NULL) {
  if (length(from) == 1) {
    from <- paste0(from, "@", mailgun_domain_name())
  } else {
    from <- paste0(from[1], " <", from[2], "@", mailgun_domain_name(), ">")
  }
  payload <- list(from = from, subject = subject, text = text)
  payload <- append(payload, `names<-`(lapply(to, identity), rep("to", length(to))))
  if (!is.null(attach)) {
    payload <- append(payload, `names<-`(lapply(attach, httr::upload_file), rep("attachment", length(attach))))
  }
  if (!is.null(tag)) {
    payload <- append(payload, `names<-`(lapply(tag, identity), rep("o:tag", length(tag))))
  }
  POST(
    mailgun_url(),
    body = payload,
    authenticate("api", mailgun_api_key())
  )
}
