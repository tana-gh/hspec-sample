{-# LANGUAGE MultiParamTypeClasses #-}

module HspecSample.MonadApp where

import HspecSample.MonadAsk
import HspecSample.MonadPrint

class (MonadAsk s m, MonadPrint m) => MonadApp s m
