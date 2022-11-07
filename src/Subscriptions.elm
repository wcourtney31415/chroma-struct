module Subscriptions exposing (subscriptions)

import Messages exposing (Msg)
import Model exposing (Model)
import Ports exposing (receiveData)


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData Messages.ReceivedDataFromJS
