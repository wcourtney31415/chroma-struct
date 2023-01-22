port module Ports exposing (onJsEyeDropperResult, openJsEyeDropper)

{-| It is recommended to keep all ports in a single Ports module so that
it is easy to see all the ways Elm will interact with JS for the entire app easily.
-}


{-| Port used to request that Javascript opens the Eye-Dropper tool.
-}
port openJsEyeDropper : () -> Cmd msg


{-| Port used to receive any results from the Eye-Dropper tool.
-}
port onJsEyeDropperResult : (String -> msg) -> Sub msg
