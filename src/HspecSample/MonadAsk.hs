{-# LANGUAGE MultiParamTypeClasses #-}

module HspecSample.MonadAsk where

class Monad m => MonadAsk s m where
    asks' :: (s -> a) -> m a
