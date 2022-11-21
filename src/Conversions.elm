module Conversions exposing (dropperStringToColorRecord)

import Array
import ColorRecord exposing (ColorRecord)


dropperStringToColorRecord : String -> ColorRecord
dropperStringToColorRecord str =
    if String.startsWith "rgb(" str then
        rgbToColor str

    else
        hexToColor str


hexToColor : String -> ColorRecord
hexToColor hex =
    let
        characterToHex char =
            case char of
                "a" ->
                    10

                "b" ->
                    11

                "c" ->
                    12

                "d" ->
                    13

                "e" ->
                    14

                "f" ->
                    15

                _ ->
                    Maybe.withDefault -1000 <| String.toInt char

        charAt i str =
            String.slice i (i + 1) str

        ra =
            characterToHex <| charAt 1 hex

        rb =
            characterToHex <| charAt 2 hex

        ga =
            characterToHex <| charAt 3 hex

        gb =
            characterToHex <| charAt 4 hex

        ba =
            characterToHex <| charAt 5 hex

        bb =
            characterToHex <| charAt 6 hex

        myRed =
            ra
                * 16
                + rb

        myGreen =
            ga
                * 16
                + gb

        myBlue =
            ba
                * 16
                + bb
    in
    { red = myRed
    , green = myGreen
    , blue = myBlue
    }


rgbToColor : String -> ColorRecord
rgbToColor rgb =
    let
        commaDelimitedList =
            String.split "," rgb

        stripAlphaChars t =
            String.filter Char.isDigit t

        rgbArray =
            Array.fromList <| List.map stripAlphaChars commaDelimitedList

        getAtIndex i arr =
            Maybe.withDefault 0 (String.toInt <| Maybe.withDefault "" (Array.get i arr))

        red =
            getAtIndex 0 rgbArray

        green =
            getAtIndex 1 rgbArray

        blue =
            getAtIndex 2 rgbArray
    in
    { red = red
    , green = green
    , blue = blue
    }
