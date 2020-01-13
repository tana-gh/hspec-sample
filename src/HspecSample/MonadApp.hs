{-# LANGUAGE FlexibleContexts #-}

module HspecSample.MonadApp where

import HspecSample.Config
import HspecSample.MonadAsk
import HspecSample.MonadPrint

class (MonadAsk Config m, MonadPrint m) => MonadApp m
