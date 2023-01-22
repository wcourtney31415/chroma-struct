module Main exposing (main)

import Browser
import Color
import ColorList exposing (..)
import Colors exposing (..)
import Element exposing (Element, fill, focusStyle, height, layoutWith, rgb255, spacing, width)
import Element.Background as Background
import GlobalAttributes exposing (..)
import Html exposing (Html)
import LeftColumn exposing (leftColumn)
import Menubar exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model)
import ScalesArea exposing (..)
import Subscriptions exposing (subscriptions)
import Update exposing (update)


view : Model -> Html Msg
view model =
    layoutWith
        { options =
            [ focusStyle
                { borderColor = Maybe.Nothing
                , backgroundColor = Maybe.Nothing
                , shadow = Maybe.Nothing
                }
            ]
        }
        [ Background.color <| rgb255 0 33 51
        ]
    <|
        Element.column
            [ width fill
            , height fill
            , spacing 2
            ]
            [ menuBar
            , body model
            ]


body : Model -> Element Msg
body model =
    Element.row
        [ height fill
        , width fill
        ]
        [ leftColumn model model.selectedColor
        , colorList model.palette
        , rightColumn
        ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( { selectedColor = Color.fromRgb255 { red = 0, green = 255, blue = 0 }
      , palette =
            []
      }
    , Cmd.none
    )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
