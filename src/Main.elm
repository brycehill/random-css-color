module Main exposing (main)

import Colors exposing (Color, getRandomColor)
import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Browser exposing (Document)
import Html.Attributes exposing (class, style)


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
    case mc of
        Just color ->
            { title = "CSS Color : " ++ color
            , body =
                [ div
                    [ class "root"
                    , style "backgroundColor" color
                    ]
                    [ div [ class "text", onClick ChangeColor ] [ text color ] ]
                ]
            }

        Nothing ->
            { title = "CSS Color"
            , body =
                [ div [] [ div [ onClick ChangeColor ] [] ]
                ]
            }
