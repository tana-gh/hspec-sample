{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances  #-}

module HspecSample.MonadAsk where

import Control.Monad.Reader

class Monad m => MonadAsk s m where
    asks' :: (s -> a) -> m (Maybe a)

instance (Monad m, MonadReader s m) => MonadAsk s m where
    asks' f = Just <$> asks f