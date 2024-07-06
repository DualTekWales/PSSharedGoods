﻿function ConvertFrom-LanguageCode {
    <#
    .SYNOPSIS
    Converts a language code to its corresponding language name.

    .DESCRIPTION
    This function takes a language code as input and returns the corresponding language name.

    .PARAMETER LanguageCode
    The language code to convert to a language name.

    .EXAMPLE
    ConvertFrom-LanguageCode -LanguageCode 1033
    Returns: "English (United States)"

    .EXAMPLE
    ConvertFrom-LanguageCode -LanguageCode 1041
    Returns: "Japanese"
    #>
    [cmdletBinding()]
    param(
        [string] $LanguageCode
    )
    $LanguageCodeDictionary = @{
        '1'     = "Arabic"
        '4'     = "Chinese (Simplified)?? China"
        '9'     = "English"
        '1025'  = "Arabic (Saudi Arabia)"
        '1026'  = "Bulgarian"
        '1027'  = "Catalan"
        '1028'  = "Chinese (Traditional) Taiwan"
        '1029'  = "Czech"
        '1030'  = "Danish"
        '1031'  = "German (Germany)"
        '1032'  = "Greek"
        '1033'  = "English (United States)"
        '1034'  = "Spanish (Traditional Sort)"
        '1035'  = "Finnish"
        '1036'  = "French (France)"
        '1037'  = "Hebrew"
        '1038'  = "Hungarian"
        '1039'  = "Icelandic"
        '1040'  = "Italian (Italy)"
        '1041'  = "Japanese"
        '1042'  = "Korean"
        '1043'  = "Dutch (Netherlands)"
        '1044'  = "Norwegian (Bokmal)"
        '1045'  = "Polish"
        '1046'  = "Portuguese (Brazil)"
        '1047'  = "Rhaeto-Romanic"
        '1048'  = "Romanian"
        '1049'  = "Russian"
        '1050'  = "Croatian"
        '1051'  = "Slovak"
        '1052'  = "Albanian"
        '1053'  = "Swedish"
        '1054'  = "Thai"
        '1055'  = "Turkish"
        '1056'  = "Urdu"
        '1057'  = "Indonesian"
        '1058'  = "Ukrainian"
        '1059'  = "Belarusian"
        '1060'  = "Slovenian"
        '1061'  = "Estonian"
        '1062'  = "Latvian"
        '1063'  = "Lithuanian"
        '1065'  = "Persian"
        '1066'  = "Vietnamese"
        '1069'  = "Basque (Basque)"
        '1070'  = "Serbian"
        '1071'  = "Macedonian (FYROM)"
        '1072'  = "Sutu"
        '1073'  = "Tsonga"
        '1074'  = "Tswana"
        '1076'  = "Xhosa"
        '1077'  = "Zulu"
        '1078'  = "Afrikaans"
        '1080'  = "Faeroese"
        '1081'  = "Hindi"
        '1082'  = "Maltese"
        '1084'  = "Scottish Gaelic (United Kingdom)"
        '1085'  = "Yiddish"
        '1086'  = "Malay (Malaysia)"
        '2049'  = "Arabic (Iraq)"
        '2052'  = "Chinese (Simplified) PRC"
        '2055'  = "German (Switzerland)"
        '2057'  = "English (United Kingdom)"
        '2058'  = "Spanish (Mexico)"
        '2060'  = "French (Belgium)"
        '2064'  = "Italian (Switzerland)"
        '2067'  = "Dutch (Belgium)"
        '2068'  = "Norwegian (Nynorsk)"
        '2070'  = "Portuguese (Portugal)"
        '2072'  = "Romanian (Moldova)"
        '2073'  = "Russian (Moldova)"
        '2074'  = "Serbian (Latin)"
        '2077'  = "Swedish (Finland)"
        '3073'  = "Arabic (Egypt)"
        '3076'  = "Chinese Traditional (Hong Kong SAR)"
        '3079'  = "German (Austria)"
        '3081'  = "English (Australia)"
        '3082'  = "Spanish (International Sort)"
        '3084'  = "French (Canada)"
        '3098'  = "Serbian (Cyrillic)"
        '4097'  = "Arabic (Libya)"
        '4100'  = "Chinese Simplified (Singapore)"
        '4103'  = "German (Luxembourg)"
        '4105'  = "English (Canada)"
        '4106'  = "Spanish (Guatemala)"
        '4108'  = "French (Switzerland)"
        '5121'  = "Arabic (Algeria)"
        '5127'  = "German (Liechtenstein)"
        '5129'  = "English (New Zealand)"
        '5130'  = "Spanish (Costa Rica)"
        '5132'  = "French (Luxembourg)"
        '6145'  = "Arabic (Morocco)"
        '6153'  = "English (Ireland)"
        '6154'  = "Spanish (Panama)"
        '7169'  = "Arabic (Tunisia)"
        '7177'  = "English (South Africa)"
        '7178'  = "Spanish (Dominican Republic)"
        '8193'  = "Arabic (Oman)"
        '8201'  = "English (Jamaica)"
        '8202'  = "Spanish (Venezuela)"
        '9217'  = "Arabic (Yemen)"
        '9226'  = "Spanish (Colombia)"
        '10241' = "Arabic (Syria)"
        '10249' = "English (Belize)"
        '10250' = "Spanish (Peru)"
        '11265' = "Arabic (Jordan)"
        '11273' = "English (Trinidad)"
        '11274' = "Spanish (Argentina)"
        '12289' = "Arabic (Lebanon)"
        '12298' = "Spanish (Ecuador)"
        '13313' = "Arabic (Kuwait)"
        '13322' = "Spanish (Chile)"
        '14337' = "Arabic (U.A.E.)"
        '14346' = "Spanish (Uruguay)"
        '15361' = "Arabic (Bahrain)"
        '15370' = "Spanish (Paraguay)"
        '16385' = "Arabic (Qatar)"
        '16394' = "Spanish (Bolivia)"
        '17418' = "Spanish (El Salvador)"
        '18442' = "Spanish (Honduras)"
        '19466' = "Spanish (Nicaragua)"
        '20490' = "Spanish (Puerto Rico)"
    }
    $Output = $LanguageCodeDictionary[$LanguageCode]
    if ($Output) {
        $Output
    } else {
        "Unknown (Undocumented)"
    }
}