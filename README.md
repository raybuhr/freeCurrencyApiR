freeCurrencyApiR
================

freeCurrencyApiR provides functions for getting current and historical currency exchange rates. Please refer to The Free Currency Converter API <https://free.currencyconverterapi.com> for all endpoints available and rate limits.

From the website:

    Rate Limits of the Free API
    Conversion Pairs per Request: 2
    Number of Requests per Hour: 100
    Date Range in History: 8 Days
    Allowed Back in History: 1 Year(s)

    Currency values are updated every 60 minutes. 
    If you need a realtime web service or a service that updates more frequently, 
    you may checkout the premium service at CurrencyConverterAPI.com.

Install
-------

``` r
devtools::install_github("raybuhr/freeCurrencyApiR")
```

Examples
--------

Get lists of the countries and currencies available:

``` r
currencies <- free_currency_api_list_currencies()
currencies$results[[1]]
```

    ## $currencyName
    ## [1] "Albanian Lek"
    ## 
    ## $currencySymbol
    ## [1] "Lek"
    ## 
    ## $id
    ## [1] "ALL"

``` r
countries <- free_currency_api_list_countries()
countries$results[[1]]
```

    ## $alpha3
    ## [1] "AFG"
    ## 
    ## $currencyId
    ## [1] "AFN"
    ## 
    ## $currencyName
    ## [1] "Afghan afghani"
    ## 
    ## $currencySymbol
    ## [1] "\u060b"
    ## 
    ## $id
    ## [1] "AF"
    ## 
    ## $name
    ## [1] "Afghanistan"

Get the current exchange rate between two currencies (based on a 60 minute refresh cache):

``` r
free_currency_api_get_current(currency_from = "USD", currency_to = "CNY", compact = "ultra")
```

    ## $USD_CNY
    ## [1] 6.890499

Get a `data.frame` of daily historical exchange rates between two currencies (No idea when the daily rate snapshot is taken):

``` r
free_currency_api_get_historical(
  currency_from = "USD", currency_to = "INR", 
  start_date = "2018-04-01", end_date = "2018-04-08"
)
```

    ##         date from  to   rate
    ## 1 2018-04-01  USD INR 65.110
    ## 2 2018-04-02  USD INR 65.120
    ## 3 2018-04-03  USD INR 64.989
    ## 4 2018-04-04  USD INR 65.039
    ## 5 2018-04-05  USD INR 64.880
    ## 6 2018-04-06  USD INR 64.920
    ## 7 2018-04-07  USD INR 64.920
    ## 8 2018-04-08  USD INR 64.920

Bugs/Issues
-----------

Report at <https://github.com/raybuhr/freeCurrencyApiR/issues>

Contributing
------------

Feel free to provide pull requests!
