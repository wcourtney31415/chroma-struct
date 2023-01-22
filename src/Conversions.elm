module Conversions exposing (colorToRgba255, dropperStringToColorRecord, rgba255ToColor)

import Array
import Color exposing (Color)
import ColorRecord exposing (Rgba255Record)


dropperStringToColorRecord : String -> Color
dropperStringToColorRecord str =
    if String.startsWith "rgb(" str then
        rgbToColor str

    else
        hexToColor str


hexToColor : String -> Color
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
    rgba255ToColor
        { red = myRed
        , green = myGreen
        , blue = myBlue
        , alpha = 255
        }


rgbToColor : String -> Color
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
    rgba255ToColor
        { red = red
        , green = green
        , blue = blue
        , alpha = 255
        }


colorToRgba255 : Color -> Rgba255Record
colorToRgba255 =
    Color.toRgba255


rgba255ToColor : Rgba255Record -> Color
rgba255ToColor { red, green, blue, alpha } =
    Color.fromRgb255 { red = red, green = green, blue = blue }
        |> Color.setAlpha (toFloat (alpha * 255))



-- convertRgbToHsv : (Int, Int, Int) -> (Float, Float, Float)
-- convertRgbToHsv (r, g, b) =
--   let
--     rprime = toFloat r / 255
--     gprime = toFloat g / 255
--     bprime = toFloat b / 255
--     h =
--       if rprime >= gprime && rprime >= bprime then
--         60 * ((gprime - bprime) / (rprime - min gprime bprime))
--       else if gprime >= rprime && gprime >= bprime then
--         60 * (2 + (bprime - rprime) / (gprime - min rprime bprime))
--       else
--         60 * (4 + (rprime - gprime) / (bprime - min rprime gprime))
--       |> toDegrees
--     s = 1 - (3 / (rprime + gprime + bprime)) * min rprime gprime bprime
--     v = max rprime gprime bprime
--   in
--     (h, s, v)
