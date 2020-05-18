//
//  AddSeperatorAsTypingClass.swift
//  Dado_App
//
//  Created by Manu Puthoor on 18/05/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

public class AddSeperatorAsTypingClass: NSObject {
    
    public static let shared = AddSeperatorAsTypingClass()
    public var seperatorChar: Character = Character("-")
    public var maxChar: Int = 16
    public var chunkSize: Int = 4
    
    public override init() {}
    
    public init(seperatorChar: Character = "-", maxChar: Int = 16, chunkSize: Int = 4) {
       self.seperatorChar = seperatorChar
       self.maxChar = maxChar
       self.chunkSize = chunkSize
    }
    

    public func addCharsWithSeperator(in textField: UITextField, with range: NSRange, and string: String) -> Bool {
        //MARK: Here the string.count will always be 1 upon entering the text and 0 upon deleting the text. Every time you delete the string.count will be 0 and vice versa.
        
        guard string.compactMap({ Int(String($0)) }).count == string.count else { return false }
        let text = textField.text ?? ""

        if string.count == 0 {
           textField.text = String(text.dropLast()).chunkFormatted(withChunkSize: chunkSize, withSeparator: seperatorChar)
        } else {
           //MARK: This code below removes the "-" character to get the exact character count with out the seperator and limits the character update to the "maxNumberOfCharacters" variable value. ".prefix" doest the limiting function.
            
           let newText = String((text + string).filter({ $0 != seperatorChar }).prefix(maxChar))
           textField.text = newText.chunkFormatted(withChunkSize: chunkSize, withSeparator: seperatorChar)
        }

        return false
    }
    
    
}

public extension String {
    //MARK:3) This func sets the chunkSize size and what kind of string character need to be used as a seperator.
    func chunkFormatted(withChunkSize chunkSize: Int = 4, withSeparator separator: Character = "-") -> String {
        return filter { $0 != separator }.chunk(n: chunkSize).map{ String($0) }.joined(separator: String(separator))
    }
}


public extension Collection {
    
    //MARK:1) this func creates an array of string from the main string .ie "55555555" becomes ["5555", 5555] if the n = 4
    func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
    
}
