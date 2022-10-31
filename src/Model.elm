module Model exposing (Model)

import Element exposing (..)
import GlobalAttributes exposing (..)
import Messages exposing (..)
import ColorRecord exposing (..)


type alias Model =
    { selectedColor : ColorRecord
    , palette : List ColorRecord
    }
