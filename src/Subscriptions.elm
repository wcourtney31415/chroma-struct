module Subscriptions exposing (subscriptions)

import Color.Dropper
import Messages exposing (Msg(..))
import Model exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Color.Dropper.subscribe ChangeColor
