module Main exposing (main)

import Browser
import Html exposing (Html)


main : Program flags model msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


view : model -> Html msg
view =
    Debug.todo


init : flags -> ( model, Cmd msg )
init =
    Debug.todo


update : msg -> model -> ( model, Cmd msg )
update =
    Debug.todo


subscriptions : model -> Sub msg
subscriptions =
    Debug.todo
