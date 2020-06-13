# Currency-converter

This project uses https://currencylayer.com/ free API to convert currencies. 
Using **SwifUI Framework** (MV). It doesn't use any external libraries.

## APIs Used
  - live (to get live exchange rate)
  - list (to get the list of all the currencies)
  - convert (not for free user)

## Functionality
- [x] Exchange rates must be fetched from: https://currencylayer.com/documentation
- [x] Use free API Access Key for using the API
- [x] User can select a currency from a list of currencies provided by the API
- [x] User can enter desired amount for selected currency
- [x] User then see a list of exchange rates for the selected currency
- [x] Rates are persisted locally and refreshed every 30 minutes (to limit bandwidth usage)


## Preview
| Currency list | Conversion list | 
|---|---|
| Here you can select one of the available currencies. | Type and press enter or click convert button |
|| to see the conversion rates for the selected currency. |
| <img src="https://github.com/sarafurqan/Currency-converter/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20X%CA%80%20-%202020-06-12%20at%2023.17.35.png" height="400px"> | <img src="https://github.com/sarafurqan/Currency-converter/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20X%CA%80%20-%202020-06-12%20at%2023.17.29.png" height="400px"> |
