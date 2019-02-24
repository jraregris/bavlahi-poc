module YouTube.IdExtractor exposing (extractVideoId)

import Regex


extractVideoId : String -> Maybe String
extractVideoId input =
    let
        regex =
            Regex.fromString "[0-9a-zA-Z-]{11}"

        matches =
            case regex of
                Just r ->
                    Regex.find r input |> List.map (\m -> m.match)

                Nothing ->
                    []
    in
    case matches of
        [ n ] ->
            Just n

        _ ->
            Nothing
