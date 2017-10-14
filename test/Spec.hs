{-# LANGUAGE OverloadedStrings #-}

import Test.HUnit
import Model

testToPhrasesEmptyList :: Test
testToPhrasesEmptyList = TestCase
    $ assertEqual "Should return empty list if no input"
        []
        (toPhrases response1)

testToPhrasesWithResponse :: Test
testToPhrasesWithResponse = TestCase
    $ assertEqual "Should return empty list if no input"
        ["[en] cat", "[en] dog"]
        (toPhrases response2)

main :: IO Counts
main = runTestTT $ TestList [testToPhrasesEmptyList, testToPhrasesWithResponse]

-- fake data

enPhrase1 = Phrase "cat" "en"
enPhrase2 = Phrase "dog" "en"

response1 = RestResponse "ok" ([]::[Translation])
response2 = RestResponse "ok" ([translation1, translation2])

translation1 = Translation (Just enPhrase1)
translation2 = Translation (Just enPhrase2)
