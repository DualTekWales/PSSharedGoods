﻿function Convert-CountryToContinent {
    <#
    .SYNOPSIS
    Convert country to continent

    .DESCRIPTION
    Convert country to continent or return a hashtable of countries and their corresponding continent.
    If the country is not found (for example empty), it will return "Unknown"

    .PARAMETER Country
    Country to convert

    .PARAMETER ReturnHashTable
    Return hashtable of countries and their corresponding continent

    .EXAMPLE
    Convert-CountryToContinent -Country "Poland"

    .EXAMPLE
    Convert-CountryToContinent -ReturnHashTable

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [string] $Country,
        [switch] $ReturnHashTable
    )
    $CountryToContinent = [ordered] @{
        "Afghanistan"                       = "Asia"
        "Albania"                           = "Europe"
        "Algeria"                           = "Africa"
        "Andorra"                           = "Europe"
        "Angola"                            = "Africa"
        "Antigua and Barbuda"               = "North America"
        "Argentina"                         = "South America"
        "Armenia"                           = "Asia"
        "Australia"                         = "Australia/Oceania"
        "Austria"                           = "Europe"
        "Azerbaijan"                        = "Asia"
        "Bahamas"                           = "North America"
        "Bahrain"                           = "Asia"
        "Bangladesh"                        = "Asia"
        "Barbados"                          = "North America"
        "Belarus"                           = "Europe"
        "Belgium"                           = "Europe"
        "Belize"                            = "North America"
        "Benin"                             = "Africa"
        "Bhutan"                            = "Asia"
        "Bolivia"                           = "South America"
        "Bosnia and Herzegovina"            = "Europe"
        "Botswana"                          = "Africa"
        "Brazil"                            = "South America"
        "Brunei"                            = "Asia"
        "Bulgaria"                          = "Europe"
        "Burkina Faso"                      = "Africa"
        "Burundi"                           = "Africa"
        "Cabo Verde"                        = "Africa"
        "Cambodia"                          = "Asia"
        "Cameroon"                          = "Africa"
        "Canada"                            = "North America"
        "Central African Republic"          = "Africa"
        "Chad"                              = "Africa"
        "Chile"                             = "South America"
        "China"                             = "Asia"
        "Colombia"                          = "South America"
        "Comoros"                           = "Africa"
        "Congo, Democratic Republic of the" = "Africa"
        "Congo, Republic of the"            = "Africa"
        "Costa Rica"                        = "North America"
        "Cote d'Ivoire"                     = "Africa"
        "Croatia"                           = "Europe"
        "Cuba"                              = "North America"
        "Cyprus"                            = "Asia"
        "Czechia"                           = "Europe"
        "Denmark"                           = "Europe"
        "Djibouti"                          = "Africa"
        "Dominica"                          = "North America"
        "Dominican Republic"                = "North America"
        "Ecuador"                           = "South America"
        "Egypt"                             = "Africa"
        "El Salvador"                       = "North America"
        "Equatorial Guinea"                 = "Africa"
        "Eritrea"                           = "Africa"
        "Estonia"                           = "Europe"
        "Eswatini"                          = "Africa"
        "Ethiopia"                          = "Africa"
        "Fiji"                              = "Australia/Oceania"
        "Finland"                           = "Europe"
        "France"                            = "Europe"
        "Gabon"                             = "Africa"
        "Gambia"                            = "Africa"
        "Georgia"                           = "Asia"
        "Germany"                           = "Europe"
        "Ghana"                             = "Africa"
        "Greece"                            = "Europe"
        "Grenada"                           = "North America"
        "Guatemala"                         = "North America"
        "Guinea"                            = "Africa"
        "Guinea-Bissau"                     = "Africa"
        "Guyana"                            = "South America"
        "Haiti"                             = "North America"
        "Honduras"                          = "North America"
        "Hungary"                           = "Europe"
        "Iceland"                           = "Europe"
        "India"                             = "Asia"
        "Indonesia"                         = "Asia"
        "Iran"                              = "Asia"
        "Iraq"                              = "Asia"
        "Ireland"                           = "Europe"
        "Israel"                            = "Asia"
        "Italy"                             = "Europe"
        "Jamaica"                           = "North America"
        "Japan"                             = "Asia"
        "Jordan"                            = "Asia"
        "Kazakhstan"                        = "Asia"
        "Kenya"                             = "Africa"
        "Kiribati"                          = "Australia/Oceania"
        "Kosovo"                            = "Europe"
        "Kuwait"                            = "Asia"
        "Kyrgyzstan"                        = "Asia"
        "Laos"                              = "Asia"
        "Latvia"                            = "Europe"
        "Lebanon"                           = "Asia"
        "Lesotho"                           = "Africa"
        "Liberia"                           = "Africa"
        "Libya"                             = "Africa"
        "Liechtenstein"                     = "Europe"
        "Lithuania"                         = "Europe"
        "Luxembourg"                        = "Europe"
        "Madagascar"                        = "Africa"
        "Malawi"                            = "Africa"
        "Malaysia"                          = "Asia"
        "Maldives"                          = "Asia"
        "Mali"                              = "Africa"
        "Malta"                             = "Europe"
        "Marshall Islands"                  = "Australia/Oceania"
        "Mauritania"                        = "Africa"
        "Mauritius"                         = "Africa"
        "Mexico"                            = "North America"
        "Micronesia"                        = "Australia/Oceania"
        "Moldova"                           = "Europe"
        "Monaco"                            = "Europe"
        "Mongolia"                          = "Asia"
        "Montenegro"                        = "Europe"
        "Morocco"                           = "Africa"
        "Mozambique"                        = "Africa"
        "Myanmar"                           = "Asia"
        "Namibia"                           = "Africa"
        "Nauru"                             = "Australia/Oceania"
        "Nepal"                             = "Asia"
        "Netherlands"                       = "Europe"
        "New Zealand"                       = "Australia/Oceania"
        "Nicaragua"                         = "North America"
        "Niger"                             = "Africa"
        "Nigeria"                           = "Africa"
        "North Korea"                       = "Asia"
        "North Macedonia"                   = "Europe"
        "Norway"                            = "Europe"
        "Oman"                              = "Asia"
        "Pakistan"                          = "Asia"
        "Palau"                             = "Australia/Oceania"
        "Panama"                            = "North America"
        "Papua New Guinea"                  = "Australia/Oceania"
        "Paraguay"                          = "South America"
        "Peru"                              = "South America"
        "Philippines"                       = "Asia"
        "Poland"                            = "Europe"
        "Portugal"                          = "Europe"
        "Qatar"                             = "Asia"
        "Romania"                           = "Europe"
        "Russia"                            = "Asia"
        "Rwanda"                            = "Africa"
        "Saint Kitts and Nevis"             = "North America"
        "Saint Lucia"                       = "North America"
        "Saint Vincent and the Grenadines"  = "North America"
        "Samoa"                             = "Australia/Oceania"
        "San Marino"                        = "Europe"
        "Sao Tome and Principe"             = "Africa"
        "Saudi Arabia"                      = "Asia"
        "Senegal"                           = "Africa"
        "Serbia"                            = "Europe"
        "Seychelles"                        = "Africa"
        "Sierra Leone"                      = "Africa"
        "Singapore"                         = "Asia"
        "Slovakia"                          = "Europe"
        "Slovenia"                          = "Europe"
        "Solomon Islands"                   = "Australia/Oceania"
        "Somalia"                           = "Africa"
        "South Africa"                      = "Africa"
        "South Korea"                       = "Asia"
        "South Sudan"                       = "Africa"
        "Spain"                             = "Europe"
        "Sri Lanka"                         = "Asia"
        "Sudan"                             = "Africa"
        "Suriname"                          = "South America"
        "Sweden"                            = "Europe"
        "Switzerland"                       = "Europe"
        "Syria"                             = "Asia"
        "Taiwan"                            = "Asia"
        "Tajikistan"                        = "Asia"
        "Tanzania"                          = "Africa"
        "Thailand"                          = "Asia"
        "Timor-Leste"                       = "Asia"
        "Togo"                              = "Africa"
        "Tonga"                             = "Australia/Oceania"
        "Trinidad and Tobago"               = "North America"
        "Tunisia"                           = "Africa"
        "Turkey"                            = "Asia"
        "Turkmenistan"                      = "Asia"
        "Tuvalu"                            = "Australia/Oceania"
        "Uganda"                            = "Africa"
        "Ukraine"                           = "Europe"
        "United Arab Emirates"              = "Asia"
        "United Kingdom"                    = "Europe"
        "United States of America"          = "North America"
        "Uruguay"                           = "South America"
        "Uzbekistan"                        = "Asia"
        "Vanuatu"                           = "Australia/Oceania"
        "Vatican City (Holy See)"           = "Europe"
        "Venezuela"                         = "South America"
        "Vietnam"                           = "Asia"
        "Yemen"                             = "Asia"
        "Zambia"                            = "Africa"
        "Zimbabwe"                          = "Africa"
    }
    if ($ReturnHashTable) {
        $CountryToContinent
    } else {
        if ($CountryToContinent[$Country]) {
            $CountryToContinent[$Country]
        } else {
            "Unknown"
        }
    }
}