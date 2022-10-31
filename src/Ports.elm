port module Ports exposing (sendData,receiveData)

import Element exposing (..)
import GlobalAttributes exposing (..)
import Messages exposing (..)




port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg
