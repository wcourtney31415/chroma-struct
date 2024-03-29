module Update exposing (update)

import Color.Conversions exposing (dropperStringToColorRecord)
import Color.Dropper
import Messages exposing (Msg(..))
import Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, Color.Dropper.open )

        ReceivedDataFromJS data ->
            ( { model | selectedColor = dropperStringToColorRecord data }, Cmd.none )

        AddColorToPalette color ->
            ( { model | palette = color :: model.palette }, Cmd.none )

        ChangeColor myColor ->
            ( { model | selectedColor = myColor }, Cmd.none )

        RemoveColor index ->
            ( { model | palette = removeElement model.palette index }, Cmd.none )


removeElement : List a -> Int -> List a
removeElement list index =
    let
        beforeSeperation =
            List.take index list

        afterSeperation =
            List.drop (index + 1) list

        newList =
            List.append beforeSeperation afterSeperation
    in
    newList
