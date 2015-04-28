#!/usr/bin/env runhaskell
-- adaptHeaders.hs
import Text.Pandoc.JSON

-- transform h2 to new slide with text as header
-- transform h4 to new paragraph with strong text
main :: IO ()
main = toJSONFilter adaptHeaders
  where adaptHeaders (Header n _ xs) | n == 2 = (Header 3 ([], [], []) xs)
     	                               | n == 4 = (Para [Strong xs])
        adaptHeaders x = x
