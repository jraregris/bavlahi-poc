module Main exposing (main)

import Browser
import Html exposing (Html)
import Json.Decode as D
import Json.Encode exposing (Value)
import YouTube
import YouTube.API as API
import YouTube.Status as Status exposing (Status(..))
import YouTube.VideoData exposing (VideoData)


main : Program () YouTube.Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


view : YouTube.Model -> Html msg
view model =
    Html.div []
        [ renderTitle model.videoData
        , Html.text (Status.toString model.status)
        ]


renderTitle : Maybe VideoData -> Html msg
renderTitle mdata =
    case mdata of
        Nothing ->
            Html.text ""

        Just data ->
            Html.h2 [] [ Html.text data.title ]


init : flags -> ( YouTube.Model, Cmd msg )
init _ =
    ( YouTube.init, Cmd.none )


update : Msg -> YouTube.Model -> ( YouTube.Model, Cmd Msg )
update msg model =
    case msg of
        PlayerStateChange n ->
            let
                maybeStatus =
                    Status.fromInt n
            in
            case maybeStatus of
                Just status ->
                    ( { model | status = status }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        PlayerReady v ->
            let
                dataResult =
                    D.decodeValue API.videoDataDecoder v
            in
            case dataResult of
                Ok data ->
                    ( { model | videoData = Just data }, Cmd.none )

                Err _ ->
                    ( { model | videoData = Nothing }, Cmd.none )


subscriptions : model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ API.onPlayerStateChange PlayerStateChange
        , API.onPlayerReady PlayerReady
        ]


type Msg
    = PlayerStateChange Int
    | PlayerReady Value
