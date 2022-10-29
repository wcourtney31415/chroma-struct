module Conversions exposing (..)


import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import String exposing (toInt)
import GlobalAttributes exposing (..)
import Messages exposing (..)
import ColorRecord exposing (..)



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

