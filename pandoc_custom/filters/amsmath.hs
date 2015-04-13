#!/usr/bin/env runhaskell
-- amsmath.hs
import Text.Pandoc.JSON
import Text.Pandoc.Shared

main :: IO ()
main = toJSONFilter amsmath
  where amsmath (Para [Math DisplayMath xs]) | (take 6 xs) == "\\begin" = (RawBlock (Format "latex") xs)
        amsmath x = x

