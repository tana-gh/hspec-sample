module HspecSample.Spec.AppSpec where

import Control.Monad.State
import HspecSample.MonadApp
import HspecSample.Spec.Mock
import Test.Hspec

spec :: Spec
spec =
    describe "askPrint" $
        it "asks and print are called correctly" $ do
            st <- (`execStateT` initialMockState ) . runMock . askPrint $ (const "" :: MockState -> String)
            asksState  st `shouldBe` [asksCalled]
            printState st `shouldBe` [asksCalled]
