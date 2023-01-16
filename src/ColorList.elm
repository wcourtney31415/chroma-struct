module ColorList exposing (..)

-- import Element exposing (centerX, fill, focused, padding, px, rgb, rgb255, spacing, text, width)

import ColorRecord exposing (ColorRecord)
import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (selected)
import Messages exposing (Msg(..))
import GlobalAttributes exposing (..)


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

