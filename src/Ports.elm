port module Ports exposing (sendData,receiveData)


port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg
