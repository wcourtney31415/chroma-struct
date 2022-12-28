module Main exposing (colorTest, main)

import Browser
import ColorRecord exposing (ColorRecord)
import Colors exposing (..)
import Conversions exposing (dropperStringToColorRecord)
import Element exposing (Element, alignTop, centerX, centerY, fill, focusStyle, height, layoutWith, maximum, minimum, mouseOver, padding, paddingXY, px, rgb, rgb255, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Html exposing (Html)
import LeftColumn exposing (leftColumn)
import Messages exposing (Msg(..))
import Model exposing (Model)
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
            [ colorTest
            , menuBar
            , body model
            ]


colorRecordAsString : ColorRecord -> String
colorRecordAsString x =
    "Red: "
        ++ String.fromInt x.red
        ++ " Green: "
        ++ String.fromInt x.green
        ++ " Blue: "
        ++ String.fromInt x.blue


colorTest : Element msg
colorTest =
    let
        colorString =
            "rgb(123,123,12)"

        myColorRecord =
            dropperStringToColorRecord colorString
    in
    Element.el
        [ Font.color <|
            rgb255 255 255 255
        ]
    <|
        text <|
            colorRecordAsString myColorRecord


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


rightColumn : Element msg
rightColumn =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color white
        , Border.color black
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
            , paddingXY 25 10
            ]
          <|
            Element.column
                [ padding 15
                , Border.rounded 15
                , Font.color white
                , Font.bold
                , spacing 15
                , Background.color <| rgb255 0 85 128
                , borderShadow
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
                    List.map (\x -> sampleColorBlock <| hslToRgb 200 1 x) <|
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


hslToRgb : Int -> Float -> Float -> ColorRecord
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


sampleColorBlock : ColorRecord -> Element msg
sampleColorBlock color =
    Element.el
        [ Background.color <| rgb255 color.red color.green color.blue
        , width <| px 200
        , height <| px 30
        , Border.width 1
        , Border.color black
        ]
    <|
        text " "


hoverHighlight : Element.Attribute msg
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
        , Font.color white
        ]
    <|
        List.map
            menuBarItem
            [ "File"
            , "Edit"
            , "View"
            ]


menuBarItem : String -> Element a
menuBarItem myText =
    Input.button
        [ hoverHighlight
        , paddingXY 5 5
        , height fill
        ]
        { label = text myText, onPress = Nothing }


colorList : List ColorRecord -> Element Msg
colorList palette =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color white
        ]
        [ Element.el
            [ centerX
            , padding 6
            , Font.size 16
            ]
          <|
            text "Palette"
        , Element.column
            [ Font.color white
            , height fill
            , Background.color <| rgb255 0 85 128
            , spacing 2
            , width
                (fill
                    |> maximum 375
                    |> minimum 375
                )
            ]
          <|
            List.map colorListItem <|
                List.indexedMap Tuple.pair palette
        ]


colorListItem : ( Int, ColorRecord ) -> Element Msg
colorListItem ( index, cRecord ) =
    Element.row
        [ centerX
        , width fill
        , Border.widthXY 0 1
        , Border.color black
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
            [ Font.color white
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
                        ++ " -> "
                        ++ String.fromInt index
        , Element.row
            [ spacing 3
            , height fill
            , padding 5
            , Background.color <| rgb255 0 133 204
            ]
            [ copyButton
            , selectForm
            , deleteButton index
            ]
        ]


copyButton : Element msg
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


deleteButton : Int -> Element Msg
deleteButton index =
    Element.el
        [ Background.color <| rgb255 58 106 167
        , height fill
        , Font.size 12
        , Border.rounded 3
        ]
    <|
        Input.button
            [ centerY
            , paddingXY 5 0
            ]
            { onPress = Just <| RemoveColor index
            , label = text "X"
            }


selectForm : Element msg
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
