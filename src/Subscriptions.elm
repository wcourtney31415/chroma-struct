
module Subscriptions exposing (subscriptions)

import Element exposing (..)
import Messages exposing (Msg)
import Ports exposing (..)
import Model exposing (..)


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData Messages.ReceivedDataFromJS


