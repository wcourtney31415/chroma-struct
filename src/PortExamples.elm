port module PortExamples exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


type alias Model =
    { selectedColor : String
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
                [ leftColumn model.selectedColor
                , colorList
                ]
            ]


menuBar : Element Msg
menuBar =
    Element.row
        [ width fill
        , Background.color <| rgb255 0 136 204
        , Background.gradient { angle = pi, steps = [ rgb255 0 136 204, rgb255 0 102 153 ] }
        , paddingXY 0 5
        , Font.size 15
        , Font.color <| rgb 1 1 1
        ]
        [ Element.el [ paddingXY 5 0 ] <| text "File"
        , Element.el [ paddingXY 5 0 ] <| text "Edit"
        , Element.el [ paddingXY 5 0 ] <| text "View"
        ]


colorList : Element Msg
colorList =
    Element.column
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
        [ colorListItem "rgb255 0 133 204"
        , colorListItem "rgb255 0 133 204"
        , colorListItem "rgb255 0 133 204"
        , colorListItem "rgb255 0 133 204"
        ]

colorListItem : String -> Element Msg
colorListItem myText =
    Element.row
        [ width fill ]
        [ Element.el
            [ Background.color <| rgb 1 0 0
            , width <| px 32
            , height fill
            ]
          <|
            text ""
        , Element.el
            [ Font.color <| rgb 1 1 1
            , Background.color <| rgb255 0 133 204
            , Font.bold

            -- , Background.gradient
            --     { angle = pi
            --     , steps =
            --         [ rgb255 0 166 255
            --         , rgb255 0 133 204
            --         , rgb255 0 133 204
            --         , rgb255 0 133 204
            --         ]
            --     }
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
                text myText
        ]

leftColumn : String -> Element Msg
leftColumn color =
    Element.column
        [ padding 25
        , height fill
        , Background.color <| rgb255 0 66 102
        ]
        [ Element.column
            [ spacing 20 ]
            [ colorSelectDisplay color
            , addColorButton "Add Color"
            , addColorButton "Remove Color"
            , addColorButton "Add to Pallet"
            ]
        ]


addColorButton : String -> Element Msg
addColorButton myText =
    Element.row
        [ centerX ]
        [ Element.el
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
        ]


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


colorSelectDisplay : String -> Element Msg
colorSelectDisplay color =
    let
        squareSize =
            256

        colorRecord =
            hexToColor color

        bkgColor =
            rgb255
                colorRecord.red
                colorRecord.green
                colorRecord.blue

        myRgb =
            "rgb255 "
                ++ String.fromInt colorRecord.red
                ++ " "
                ++ String.fromInt colorRecord.green
                ++ " "
                ++ String.fromInt colorRecord.blue
                ++ " "
    in
    Input.button
        [ Background.color bkgColor
        , width <| px squareSize
        , alignTop
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )

        ReceivedDataFromJS data ->
            ( { model | selectedColor = data }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceivedDataFromJS


port sendData : String -> Cmd msg


port receiveData : (String -> msg) -> Sub msg


init : () -> ( Model, Cmd Msg )
init _ =
    ( { selectedColor = "", palette = [] }, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
