{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances  #-}

module HspecSample.MonadPrint where

import Control.Monad.IO.Class

class (Monad m, Show a) => MonadPrint m a where
    print' :: a -> m ()

instance (Monad m, MonadIO m, Show a) => MonadPrint m a where
    print' = liftIO . print
