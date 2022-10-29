module Messages exposing (..)

import ColorRecord exposing (..)
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import String exposing (toInt)


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette ColorRecord
