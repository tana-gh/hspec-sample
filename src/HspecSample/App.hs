module HspecSample.App where

import Control.Monad.Reader
import HspecSample.MonadApp

app :: IO ()
app = (`runReaderT` ["Hello, ", "world!"]) . runApp $
    askPrint concat
