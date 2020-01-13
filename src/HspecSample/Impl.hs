{-# OPTIONS_GHC -fno-warn-orphans #-}

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

newtype App m a = App
    { runApp :: ReaderT Config m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    , MonadIO
    , MonadReader Config
    )

instance MonadAsk Config (App IO) where
    asks' f = Just <$> asks f

instance MonadPrint (App IO) where
    print' = liftIO . print

instance MonadApp (App IO)
