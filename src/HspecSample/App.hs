{-# LANGUAGE FlexibleContexts #-}

module HspecSample.App where

import HspecSample.Config
import HspecSample.MonadApp
import HspecSample.MonadAsk
import HspecSample.MonadPrint

app :: MonadApp Config m => m ()
app = print' =<< asks' (concat :: [String] -> String)
