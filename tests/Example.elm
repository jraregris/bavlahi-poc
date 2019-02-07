module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "extract video id"
        [ test "extract video id from video id" <|
            \_ ->
                let
                    input =
                        "Wc0-wSQd-LQ"

                    output =
                        "Wc0-wSQd-LQ"
                in
                Expect.equal (extractVideoId input) output
        ]
