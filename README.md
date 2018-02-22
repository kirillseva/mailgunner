# Send emails from R using mailgun.

## How to use

1. Create an account with [Mailgun](https://www.mailgun.com/).
2. Obtain your API key and domain name from mailgun. Follow [official documentation](https://documentation.mailgun.com/en/latest/quickstart-sending.html#send-with-smtp-or-api).
3. Set `MAILGUNNER_DOMAIN_NAME` and `MAILGUNNER_API_KEY` environment variables.
4. Enjoy!

```r
emails <- c(
  "tim.cook@apple.com",
  "bill.gates@microsoft.com",
  "elon.musk@tesla.com",
  "masayoshi.son@softbank.jp"
)

params <- list(
  from    = c("Kirill Sevastyanenko", "kirillseva"),
  subject = paste("An exciting investment opportunity"),
  text    = paste0(
    "This email was sent to you from R. If you are not excited yet - you should be!\n",
    "Contact me at https://github.com/kirillseva for investment opportunities."
  ),
  tag     = "investment",
  to      = emails
)
do.call(mailgunner::send_email, params)
```
