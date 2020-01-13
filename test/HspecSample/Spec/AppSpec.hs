module HspecSample.Spec.AppSpec where

import Control.Monad.State
import HspecSample.App
import HspecSample.Spec.Mock
import Test.Hspec

spec :: Spec
spec =
    describe "askPrint" $
        it "asks and print are called correctly" $ do
            st <- (`execStateT` initialMockState ) . runMock $ app
            asksState  st `shouldBe` [asksCalled]
            printState st `shouldBe` [show $ concat config]
