module Update exposing (update)

import Model exposing (Model)
import Messages exposing (Msg(..))
import Ports exposing (sendData)
import Conversions exposing (hexToColor)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )

        ReceivedDataFromJS data ->
            ( { model | selectedColor = hexToColor data }, Cmd.none )

        AddColorToPalette color ->
            ( { model | palette = color :: model.palette }, Cmd.none )

