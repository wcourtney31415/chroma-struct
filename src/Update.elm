module Update exposing (update)

import Model exposing (..)
import Messages exposing (..)
import Element exposing (..)
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

