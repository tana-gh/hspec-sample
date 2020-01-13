module Main where

import Control.Monad.Reader
import HspecSample.App
import HspecSample.Impl

main :: IO ()
main = (`runReaderT` ["Hello, ", "world!"]) . runApp $ app
