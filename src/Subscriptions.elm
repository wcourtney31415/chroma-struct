
module Subscriptions exposing (..)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import String exposing (toInt)
import GlobalAttributes exposing (..)
import Messages exposing (..)
import Ports exposing (..)
import Model exposing (..)


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceivedDataFromJS


