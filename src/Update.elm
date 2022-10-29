module Update exposing (..)

import Messages exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import String exposing (toInt)
import Ports exposing (..)
import Conversions exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )

        ReceivedDataFromJS data ->
            ( { model | selectedColor = hexToColor data }, Cmd.none )

        AddColorToPalette color ->
            ( { model | palette = color :: model.palette }, Cmd.none )

