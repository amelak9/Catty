/**
 *  Copyright (C) 2010-2021 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import XCTest

@testable import Pocket_Code

final class BrickManagerTests: XCTestCase {
    
    func testSizeForBrick() {
        let brick = SetVariableBrick()
        let brickCell = brick.brickCell()
        
        let size = BrickManager.shared()?.size(forBrick: brick)
        XCTAssertEqual(UIScreen.main.bounds.size.width, size?.width)
        XCTAssertEqual(brickCell?.cellHeight(), size?.height)
    }
    
    func testRecentlyUsedBricks() {
        let script = Script()
        let setVariableBrick = SetVariableBrick()
        script.add(setVariableBrick, at: 0)
        let askBrick = AskBrick()
        script.add(askBrick, at: 1)
        let setBackgroundBrick = SetBackgroundBrick()
        script.add(setBackgroundBrick, at: 2)
        let nextLookBrick = NextLookBrick()
        script.add(nextLookBrick, at: 3)
        let previousLookBrick = PreviousLookBrick()
        script.add(previousLookBrick, at: 4)
        let setLookBrick = SetLookBrick()
        script.add(setLookBrick, at: 5)
        let penDownBrick = PenDownBrick()
        script.add(penDownBrick, at: 6)
        let penUpBrick = PenUpBrick()
        script.add(penUpBrick, at: 7)
        let setRotationStyleBrick = SetRotationStyleBrick()
        script.add(setRotationStyleBrick, at: 8)
        let stitchBrick = StitchBrick()
        script.add(stitchBrick, at: 9)
        let setLookByIndexBrick = SetLookByIndexBrick()
        script.add(setLookByIndexBrick, at: 10)
        
        if let favourites = BrickManager.shared()?.selectableBricks(for: kBrickCategoryType(rawValue: 0)!) {
            for favourite in favourites {
                //TODO: Make sure that the last 10 used bricks are in the array
            }
            
        }
    }
}
