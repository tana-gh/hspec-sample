{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}

module HspecSample.Spec.Mock where

import Control.Monad.State
import HspecSample.Config
import HspecSample.MonadApp
import HspecSample.MonadAsk
import HspecSample.MonadPrint

newtype Mock s m a = Mock
    { runMock :: StateT s m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    , MonadState s
    )

data MockState = MockState
    { asksState  :: [String]
    , printState :: [String]
    }

initialMockState :: MockState
initialMockState = MockState [] []

config :: Config
config = ["config1", "config2"]

asksCalled :: String
asksCalled = "asks called"

instance Monad m => MonadAsk Config (Mock MockState m) where
    asks' f = do
        modify $ \s -> s { asksState = asksCalled : asksState s }
        return $ f config

instance Monad m => MonadPrint (Mock MockState m) where
    print' a = modify $ \s -> s { printState = show a : printState s }

instance Monad m => MonadApp Config (Mock MockState m)
