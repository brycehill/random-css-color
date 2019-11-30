module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Colors exposing (Color, fromUrl, getRandomColor, isLightColor)
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Regex
import String
import Url



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



---- MODEL ----


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , color : Maybe Color
    }



---- Msg ----


type Msg
    = ChangeColor
    | NewColor (Maybe Color)
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url Nothing, getRandomColor NewColor )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeColor ->
            ( model, getRandomColor NewColor )

        NewColor color ->
            case color of
                Just c ->
                    ( { model | color = color }, Nav.pushUrl model.key c )

                Nothing ->
                    ( model, Cmd.none )

        UrlChanged url ->
            ( { model | url = url, color = Colors.fromUrl url }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    case model.color of
        Just color ->
            { title = "CSS Color : " ++ color
            , body =
                [ div
                    [ class "root"
                    , style "backgroundColor" color
                    , onClick ChangeColor
                    ]
                    [ span
                        [ class "text"
                        , class
                            (if isLightColor color then
                                "text--dark"

                             else
                                ""
                            )
                        ]
                        [ text (splitOnUpper color) ]
                    ]
                ]
            }

        Nothing ->
            { title = "CSS Color"
            , body =
                [ div [] [ div [ onClick ChangeColor ] [] ]
                ]
            }


upperCase : Regex.Regex
upperCase =
    Maybe.withDefault Regex.never <|
        Regex.fromString "[A-Z]+"



-- splitOnUpper
-- Take a color like "RoyalBlue" and make it "Royal Blue"


splitOnUpper : String -> String
splitOnUpper =
    Regex.replace upperCase (.match >> String.append " ")
