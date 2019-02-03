port module YouTube.API exposing (onPlayerStateChange)


port onPlayerStateChange : (Int -> msg) -> Sub msg
