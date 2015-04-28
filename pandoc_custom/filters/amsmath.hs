#!/usr/bin/env runhaskell
-- amsmath.hs
import Text.Pandoc.JSON
import Text.Pandoc.Shared

main :: IO ()
main = toJSONFilter amsmath
  where amsmath (RawBlock (Format "latex") xs) | (take 6 xs) == "\\begin" = (Plain [Space,Math DisplayMath xs])
        amsmath x = x

