module Tests exposing (suite)

import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Dummy Test Suite"
        [ test "has no effect on a palindrome" <|
            \_ ->
                let
                    palindrome : String
                    palindrome =
                        "hannah"
                in
                Expect.equal palindrome (String.reverse palindrome)
        ]
