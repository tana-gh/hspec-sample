{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}

module HspecSample.Impl where

import Control.Monad.IO.Class
import Control.Monad.Reader
import HspecSample.Config
import HspecSample.MonadApp
import HspecSample.MonadAsk
import HspecSample.MonadPrint

newtype App s m a = App
    { runApp :: ReaderT s m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    , MonadReader s
    , MonadIO
    )

instance Monad m => MonadAsk s (App s m) where
    asks' = asks

instance MonadIO m => MonadPrint (App s m) where
    print' = liftIO . print

instance MonadIO m => MonadApp s (App s m)
