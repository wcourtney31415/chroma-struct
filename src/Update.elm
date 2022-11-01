module Update exposing (update)

import Conversions exposing (hexToColor)
import Messages exposing (Msg(..))
import Model exposing (Model)
import Ports exposing (sendData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )

        ReceivedDataFromJS data ->
            ( { model | selectedColor = hexToColor data }, Cmd.none )

        AddColorToPalette color ->
            ( { model | palette = color :: model.palette }, Cmd.none )
        ChangeColor myColor ->
            ({model | selectedColor = myColor }, Cmd.none)
