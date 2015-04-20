#!/usr/bin/env runhaskell
-- skip_pause.hs
import Text.Pandoc.JSON

main :: IO ()
main = toJSONFilter skip_pause
  where skip_pause (Para [Str ".",Space,Str ".",Space,Str "."]) = (Para [])
        skip_pause x = x
