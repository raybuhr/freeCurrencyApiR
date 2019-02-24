#' Current Rate
#'
#' https://free.currencyconverterapi.com/
#' API v6
#' API only allows 8 days at a time for free version.
#' Rate limit for free version is 100 requests per hour.
#'
#' The Current Rate function returns a list of the exchange -- from currency and to currency --
#' and the current exchange rate as a numeric.
#'
#' @param currency_from The 3-letter ISO currency code
#' @param currency_to The 3-letter ISO currency code
#' @param compact The compactness of the output format. There are three options: y, n, ultra.
#' @examples
#' \dontrun{
#' free_currency_api_get_current("USD", "PHP", "ultra")
#' }
#' @export
free_currency_api_get_current <- function(
  currency_from, currency_to, compact="ultra"
) {
  try(if (is.na(Sys.getenv("FREE_CURRENCY_API_KEY")))
    stop("Need to first set environment variable FREE_CURRENCY_API_KEY.")
  )
  base_url = "https://free.currencyconverterapi.com/api/v6/convert"
  exchange = paste(currency_from, currency_to, sep = "_")
  req <- httr::GET(base_url, query = list(
    q = exchange, compact = compact,
    apiKey = Sys.getenv("FREE_CURRENCY_API_KEY")
  ))
  httr::stop_for_status(req)
  return(httr::content(req))
}

#' Historical Rates
#'
#' https://free.currencyconverterapi.com/
#' API v6
#' API only allows 8 days at a time for free version.
#' Rate limit for free version is 100 requests per hour.
#'
#' The Historical Rates function returns a data.frame with 4 variables:
#'   date -- R date objects
#'   from -- the base currency
#'   to -- the exchange currency
#'   rate -- numeric representing the exchange value at that date
#'
#' @param currency_from The 3-letter ISO currency code
#' @param currency_to The 3-letter ISO currency code
#' @param start_date YYYY-mm-dd formatted date
#' @param end_date YYYY-mm-dd formatted date
#' @examples
#' \dontrun{
#' free_currency_api_get_historical("USD", "PHP", "2018-07-04", "2018-07-11")
#' }
#' @export
free_currency_api_get_historical <- function(
  currency_from, currency_to, start_date, end_date
) {
  try(if (is.na(Sys.getenv("FREE_CURRENCY_API_KEY")))
    stop("Need to first set environment variable FREE_CURRENCY_API_KEY.")
  )
  base_url = "https://free.currencyconverterapi.com/api/v6/convert"
  exchange = paste(currency_from, currency_to, sep = "_")
  req <- httr::GET(base_url, query = list(
    q = exchange, date = start_date, endDate = end_date, compact = "n",
    apiKey = Sys.getenv("FREE_CURRENCY_API_KEY")
  ))
  httr::stop_for_status(req)
  resp <- httr::content(req)
  resp_data <- data.frame(
    date = seq(as.Date(resp$date), as.Date(resp$endDate), by = "day"),
    from = resp$results[[1]]$fr,
    to = resp$results[[1]]$to,
    rate = unlist(resp$results[[1]]$val),
    stringsAsFactors = FALSE,
    row.names = NULL
  )
  return(resp_data)
}

#' List Currencies
#'
#' https://free.currencyconverterapi.com/api/v6/currencies
#'
#' List Currencies returns a list of all the three letter ISO codes for currencies available,
#' along with their more human readable name.
#'
#' @export
free_currency_api_list_currencies <- function() {
  try(if (is.na(Sys.getenv("FREE_CURRENCY_API_KEY")))
    stop("Need to first set environment variable FREE_CURRENCY_API_KEY.")
  )
  req <- httr::GET("https://free.currencyconverterapi.com/api/v6/currencies",
                   query = list(apiKey = Sys.getenv("FREE_CURRENCY_API_KEY")))
  httr::stop_for_status(req)
  return(httr::content(req))
}

#' List Countries
#'
#' https://free.currencyconverterapi.com/api/v6/countries
#'
#' List Currencies returns a list of all the two and three letter ISO codes for countries available,
#' along with the human readable versions of country and currency name, as well as the currency symbol.
#'
#' @export
free_currency_api_list_countries <- function() {
  try(if (is.na(Sys.getenv("FREE_CURRENCY_API_KEY")))
    stop("Need to first set environment variable FREE_CURRENCY_API_KEY.")
  )
  req <- httr::GET("https://free.currencyconverterapi.com/api/v6/countries",
                   query = list(apiKey = Sys.getenv("FREE_CURRENCY_API_KEY")))
  httr::stop_for_status(req)
  return(httr::content(req))
}
