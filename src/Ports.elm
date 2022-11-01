port module Ports exposing (receiveData, sendData)


port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg
