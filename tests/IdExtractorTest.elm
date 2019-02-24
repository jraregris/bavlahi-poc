module IdExtractorTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Regex
import Test exposing (..)
import YouTube.IdExtractor as Extractor


suite : Test
suite =
    describe "extract video id"
        [ test "extract video id from video id" <|
            \_ ->
                let
                    input =
                        "Wc0-wSQd-LQ"

                    output =
                        Just "Wc0-wSQd-LQ"
                in
                Expect.equal (Extractor.extractVideoId input) output
        , test "extract video id from url" <|
            \_ ->
                let
                    input =
                        "https://www.youtube.com/watch?v=Wc0-wSQd-LQ"

                    output =
                        Just "Wc0-wSQd-LQ"
                in
                Expect.equal (Extractor.extractVideoId input) output
        , test "extract video id from url with junk at the end" <|
            \_ ->
                let
                    input =
                        "https://www.youtube.com/watch?v=Wc0-wSQd-LQ&feature=youtu.be"

                    output =
                        Just "Wc0-wSQd-LQ"
                in
                Expect.equal (Extractor.extractVideoId input) output
        ]
