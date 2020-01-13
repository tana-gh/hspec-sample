module HspecSample.App where

import HspecSample.MonadApp
import HspecSample.MonadAsk
import HspecSample.MonadPrint

app :: MonadApp m => m ()
app = mapM_ print' =<< asks' (concat :: [String] -> String)
