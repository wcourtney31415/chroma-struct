module ColorList exposing (..)

import Color
import Color.Colors exposing (..)
import Color.Types exposing (RawColor)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import GlobalAttributes exposing (..)
import Messages exposing (Msg(..))


colorList : List RawColor -> Element Msg
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


colorListItem : ( Int, RawColor ) -> Element Msg
colorListItem ( index, color ) =
    let
        cRecord =
            Color.toRgba255 color
    in
    Element.row
        [ centerX
        , width fill
        , Border.widthXY 0 1
        , Border.color black
        ]
        [ Input.button
            [ Background.color <|
                rgb255
                    cRecord.red
                    cRecord.green
                    cRecord.blue
            , width <| px 32
            , Border.width 1
            , Border.color black
            , height fill
            ]
            { label = text ""
            , onPress = Just <| ChangeColor color
            }
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
