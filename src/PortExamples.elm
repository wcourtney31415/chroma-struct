port module PortExamples exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias Model =
    { selectedColor : ColorRecord
    , palette : List ColorRecord
    }


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
            , Element.row
                [ height fill
                , width fill
                ]
                [ leftColumn model model.selectedColor
                , colorList model
                , rightColumn
                ]
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
                    [ sampleColorBlock { red = 255, green = 0, blue = 0 }
                    , sampleColorBlock { red = 235, green = 0, blue = 0 }
                    , sampleColorBlock { red = 215, green = 0, blue = 0 }
                    , sampleColorBlock { red = 195, green = 0, blue = 0 }
                    , sampleColorBlock { red = 175, green = 0, blue = 0 }
                    , sampleColorBlock { red = 155, green = 0, blue = 0 }
                    , sampleColorBlock { red = 135, green = 0, blue = 0 }
                    , sampleColorBlock { red = 115, green = 0, blue = 0 }
                    , sampleColorBlock { red = 95, green = 0, blue = 0 }
                    , sampleColorBlock { red = 75, green = 0, blue = 0 }
                    , sampleColorBlock { red = 55, green = 0, blue = 0 }
                    , sampleColorBlock { red = 35, green = 0, blue = 0 }
                    , sampleColorBlock { red = 15, green = 0, blue = 0 }
                    , sampleColorBlock { red = 0, green = 0, blue = 0 }
                    ]
                ]
        ]


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


leftColumn model color =
    Element.column
        [ height fill
        , Background.color <| rgb255 0 50 77
        , Font.color <| rgb 1 1 1
        , Border.color <| rgb 0 0 0
        , Border.widthEach
            { top = 0
            , bottom = 0
            , left = 0
            , right = 1
            }
        ]
        [ Element.el [ centerX, padding 6, Font.size 16 ] <| text "Color Selection"
        , Element.column
            [ paddingXY 20 5
            , height fill
            , Background.color <| rgb255 0 37 57

            -- , spaceEvenly
            , spacing 20

            -- , Element.explain Debug.todo
            ]
            [ colorSelectDisplay color
            , addColorButton model "Add to Pallet"
            , addColorButton model "Remove Color"
            ]
        ]


attrShadow =
    Border.shadow
        { blur = 10
        , size = 1
        , color = rgb 0 0 0
        , offset = ( 4, 4 )
        }


addColorButton model myText =
    Input.button
        [ centerX
        , hoverHighlight
        ]
        { onPress = Just <| AddColorToPalette model.selectedColor
        , label =
            Element.el
                [ Background.color <| rgb255 0 133 204
                , Font.color <| rgb 1 1 1
                , width <| px 220
                , Font.size 15
                , Font.bold
                , centerX
                , Background.gradient
                    { angle = pi
                    , steps =
                        [ rgb255 0 133 204
                        , rgb255 0 85 128
                        ]
                    }
                , Border.rounded 5
                , Border.shadow
                    { blur = 10
                    , size = 1
                    , color = rgb 0 0 0
                    , offset = ( 4, 4 )
                    }
                , padding 10
                ]
            <|
                Element.el [ centerX ] <|
                    text myText
        }


type alias ColorRecord =
    { red : Int
    , green : Int
    , blue : Int
    }


hexToColor : String -> ColorRecord
hexToColor hex =
    let
        characterToHex char =
            case char of
                "a" ->
                    10

                "b" ->
                    11

                "c" ->
                    12

                "d" ->
                    13

                "e" ->
                    14

                "f" ->
                    15

                _ ->
                    Maybe.withDefault -1000 <| String.toInt char

        charAt i str =
            String.slice i (i + 1) str

        ra =
            characterToHex <| charAt 1 hex

        rb =
            characterToHex <| charAt 2 hex

        ga =
            characterToHex <| charAt 3 hex

        gb =
            characterToHex <| charAt 4 hex

        ba =
            characterToHex <| charAt 5 hex

        bb =
            characterToHex <| charAt 6 hex

        myRed =
            ra
                * 16
                + rb

        myGreen =
            ga
                * 16
                + gb

        myBlue =
            ba
                * 16
                + bb
    in
    { red = myRed
    , green = myGreen
    , blue = myBlue
    }


colorSelectDisplay color =
    let
        squareSize =
            256

        bkgColor =
            rgb255
                color.red
                color.green
                color.blue

        myRgb =
            "rgb255 "
                ++ String.fromInt color.red
                ++ " "
                ++ String.fromInt color.green
                ++ " "
                ++ String.fromInt color.blue
                ++ " "
    in
    Input.button
        [ Background.color bkgColor
        , width <| px squareSize

        -- , alignTop
        , Border.shadow
            { blur = 10
            , size = 1
            , color = rgb 0 0 0
            , offset = ( 4, 4 )
            }
        , height <| px squareSize
        ]
        { label =
            Element.el
                [ centerX
                , centerY
                ]
            <|
                text <|
                    myRgb
        , onPress = Maybe.Just SendDataToJS
        }


type Msg
    = SendDataToJS
    | ReceivedDataFromJS String
    | AddColorToPalette ColorRecord


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )

        ReceivedDataFromJS data ->
            ( { model | selectedColor = hexToColor data }, Cmd.none )

        AddColorToPalette color ->
            ( { model | palette = color :: model.palette }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceivedDataFromJS


port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg


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
