module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import LeftColumn exposing (..)
import Update exposing (..)
import ColorRecord exposing (..)
import Messages exposing (..)
import Model exposing (..)
import Subscriptions exposing (..)


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


body model =
    Element.row
        [ height fill
        , width fill
        ]
        [ leftColumn model model.selectedColor
        , colorList model
        , rightColumn
        ]


rightColumn =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color <| rgb 1 1 1
        , Border.color <| rgb 0 0 0
        , width fill
        , Border.widthEach
            { top = 0
            , bottom = 0
            , left = 1
            , right = 1
            }
        ]
        [ Element.el
            [ centerX
            , padding 6
            , Font.size 16
            ]
          <|
            text "Color Variants"
        , Element.el
            [ width fill
            , Background.color <| rgb255 0 37 57
            , height fill
            , padding 25
            ]
          <|
            Element.column
                [ padding 15
                , Border.rounded 15
                , Font.color <| rgb 1 1 1
                , Font.bold
                , spacing 15
                , Background.color <| rgb255 0 85 128
                , attrShadow
                ]
                [ Element.el
                    [ centerX
                    ]
                  <|
                    text "Light to Dark"
                , Element.column
                    [ spacing 5
                    , alignTop
                    , centerX
                    ]
                  <|
                    List.map (\x -> sampleColorBlock <| hslToRgb 200 1 x)
                        [ 1
                        , 0.95
                        , 0.9
                        , 0.85
                        , 0.8
                        , 0.75
                        , 0.7
                        , 0.65
                        , 0.6
                        , 0.55
                        , 0.5
                        , 0.45
                        , 0.4
                        , 0.35
                        , 0.3
                        , 0.25
                        , 0.2
                        , 0.15
                        , 0.1
                        , 0
                        ]
                ]
        ]


hslToRgb : Int -> Float -> Float -> { blue : Int, green : Int, red : Int }
hslToRgb hue sat light =
    let
        h =
            toFloat hue / 60

        t2 =
            if light <= 0.5 then
                light * (sat + 1)

            else
                light + sat - (light * sat)

        t1 =
            light * 2 - t2

        hueToRgb tOne tTwo tHue =
            let
                hh =
                    if tHue < 0 then
                        tHue + 6

                    else if tHue >= 6 then
                        tHue - 6

                    else
                        tHue

                ret =
                    if hh < 1 then
                        (tTwo - tOne) * hh + tOne

                    else if hh < 3 then
                        tTwo

                    else if hh < 4 then
                        (tTwo - tOne) * (4 - hh) + tOne

                    else
                        tOne
            in
            ret

        r =
            hueToRgb t1 t2 (h + 2) * 255

        g =
            hueToRgb t1 t2 h * 255

        b =
            hueToRgb t1 t2 (h - 2) * 255
    in
    { red = round r, green = round g, blue = round b }


sampleColorBlock color =
    Element.el
        [ Background.color <| rgb255 color.red color.green color.blue
        , width <| px 100
        , height <| px 20
        ]
    <|
        text " "


hoverHighlight =
    mouseOver
        [ Background.gradient
            { angle = pi
            , steps = [ rgb255 84 130 186 ]
            }
        ]


menuBar : Element Msg
menuBar =
    Element.row
        [ width fill
        , Background.color <| rgb255 0 136 204
        , Background.gradient
            { angle = pi
            , steps =
                [ rgb255 0 136 204
                , rgb255 0 102 153
                ]
            }
        , Font.size 15
        , Font.color <| rgb 1 1 1
        ]
    <|
        List.map
            menuBarItem
            [ "File"
            , "Edit"
            , "View"
            ]


menuBarItem myText =
    Input.button
        [ hoverHighlight
        , paddingXY 5 5
        , height fill
        ]
        { label = text myText, onPress = Nothing }


colorList : Model -> Element Msg
colorList model =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color <| rgb 1 1 1
        ]
        [ Element.el
            [ centerX
            , padding 6
            , Font.size 16
            ]
          <|
            text "Palette"
        , Element.column
            [ Font.color <| rgb 1 1 1
            , height fill
            , Background.color <| rgb255 0 85 128
            , spacing 2
            , width
                (fill
                    |> maximum 300
                    |> minimum 300
                )
            ]
          <|
            List.map colorListItem model.palette
        ]


colorListItem : ColorRecord -> Element Msg
colorListItem cRecord =
    Element.row
        [ centerX
        , width fill
        , Border.widthXY 0 1
        , Border.color <| rgb 0 0 0
        ]
        [ Element.el
            [ Background.color <|
                rgb255
                    cRecord.red
                    cRecord.green
                    cRecord.blue
            , width <| px 32
            , height fill
            ]
          <|
            text ""
        , Element.el
            [ Font.color <| rgb 1 1 1
            , Background.color <| rgb255 0 133 204
            , Font.bold
            , paddingXY 0 8
            , Font.size 14
            , width fill
            ]
          <|
            Element.el
                [ centerY
                , paddingXY 10 0
                ]
            <|
                text <|
                    "rgb255 "
                        ++ String.fromInt cRecord.red
                        ++ " "
                        ++ String.fromInt cRecord.green
                        ++ " "
                        ++ String.fromInt cRecord.blue
        , Element.row
            [ spacing 3
            , height fill
            , padding 5
            , Background.color <| rgb255 0 133 204
            ]
            [ copyButton
            , selectForm
            ]
        ]


copyButton =
    Element.el
        [ Background.color <| rgb255 58 106 167
        , height fill
        , Font.size 12
        , Border.rounded 3
        ]
    <|
        Element.el
            [ centerY
            , paddingXY 5 0
            ]
        <|
            text "Copy"


selectForm =
    Element.el
        [ Background.color <| rgb255 58 106 167
        , height fill
        , Font.size 12
        , Border.rounded 3
        ]
    <|
        Element.el
            [ centerY
            , paddingXY 5 0
            ]
        <|
            text "Form"


attrShadow =
    Border.shadow
        { blur = 10
        , size = 1
        , color = rgb 0 0 0
        , offset = ( 4, 4 )
        }







init : () -> ( Model, Cmd Msg )
init _ =
    ( { selectedColor = { red = 0, green = 255, blue = 0 }
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
