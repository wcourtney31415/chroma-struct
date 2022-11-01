
module Subscriptions exposing (subscriptions)

import Messages exposing (Msg)
import Ports exposing ( receiveData)
import Model exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData Messages.ReceivedDataFromJS


