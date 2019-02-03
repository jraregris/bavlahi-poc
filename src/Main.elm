module Main exposing (main)

import Browser
import Html exposing (Html)
import YouTube
import YouTube.API as API
import YouTube.Status as Status exposing (Status(..))


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
    Html.div [] [ Html.text (Status.toString model.status) ]


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


subscriptions : model -> Sub Msg
subscriptions _ =
    API.onPlayerStateChange PlayerStateChange


type Msg
    = PlayerStateChange Int
