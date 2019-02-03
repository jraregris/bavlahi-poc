module Main exposing (main)

import Browser
import Html exposing (Html)


main : Program () model msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


view : model -> Html msg
view =
    Debug.todo "Make a view"


init : flags -> ( model, Cmd msg )
init =
    Debug.todo "Make an init"


update : msg -> model -> ( model, Cmd msg )
update =
    Debug.todo "Updateeee"


subscriptions : model -> Sub msg
subscriptions =
    Debug.todo "sub dub"
