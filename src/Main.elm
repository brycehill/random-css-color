module Main exposing (main)

import Colors exposing (Color, getRandomColor)
import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Browser exposing (Document)
import Html.Attributes exposing (style)


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    Maybe Color



-- Msg


type Msg
    = ChangeColor
    | NewColor (Maybe Color)


init : () -> ( Maybe Color, Cmd Msg )
init () =
    ( Nothing, getRandomColor NewColor )



-- UPDATE


update : Msg -> Maybe Color -> ( Maybe Color, Cmd Msg )
update msg model =
    case msg of
        ChangeColor ->
            ( model, getRandomColor NewColor )

        NewColor color ->
            ( color, Cmd.none )



-- VIEW


view : Maybe Color -> Document Msg
view mc =
    { title = ""
    , body =
        [ case mc of
            Just color ->
                div
                    [ style "backgroundColor" color
                    , style "height" "100vh"
                    , style "width" "100vw"
                    , style "display" "flex"
                    , style "justify-content" "center"
                    , style "align-items" "center"
                    , style "text-align" "center"
                    , style "font-size" "40px"
                    , style "color" "white"
                    , onClick ChangeColor
                    ]
                    [ div [] [ text color ] ]

            Nothing ->
                div [] [ div [ onClick ChangeColor ] [ text "No" ] ]
        ]
    }
