/**
 *  Copyright (C) 2010-2020 The Catrobat Team
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

extension SetLookByIndexBrick: CBInstructionProtocol {

    func instruction() -> CBInstruction {
        .action { context in SKAction.run(self.actionBlock(context.formulaInterpreter)) }
    }

    func actionBlock(_ formulaInterpreter: FormulaInterpreterProtocol) -> () -> Void {
        guard let object = self.script?.object,
            let spriteNode = object.spriteNode,
            let formula = self.lookIndex,
            let lookList = spriteNode.getLookList()
            else { fatalError("This should never happen!") }

        return {
            let lookCount = lookList.count
            let lookIndex = formulaInterpreter.interpretInteger(formula, for: object)
            if  lookIndex < 1 || lookIndex > lookCount {
                return
            }

            let cache = RuntimeImageCache.shared()
            let lookAtIndex = lookList.object(at: lookIndex - 1) as? Look
            var image = cache?.cachedImage(forPath: self.pathForLook(look: lookAtIndex))

            if image == nil {
                cache?.loadImageFromDisk(withPath: self.pathForLook(look: lookAtIndex))
                if let look = self.pathForLook(look: lookAtIndex) {
                    guard let imageFromDisk = UIImage(contentsOfFile: look) else { return }
                    image = imageFromDisk
                } else {
                    return
                }
            }
            spriteNode.currentLook = lookAtIndex
            spriteNode.executeFilter(image)
        }
    }
}
