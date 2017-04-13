MoneyRails.configure do |config|
  config.default_currency = :eur
  config.default_format = {
    :no_cents_if_whole => true,
    :symbol => true,
    :sign_before_symbol => true,
    delimiter: CurrencyFormat.default_thousands_delimiter,
    separator: CurrencyFormat.default_decimal_separator
  }
end