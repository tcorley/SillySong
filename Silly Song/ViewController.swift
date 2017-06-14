//
//  ViewController.swift
//  Silly Song
//
//  Created by Corley, Tyler on 6/14/17.
//  Copyright © 2017 Corley, Tyler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.returnKeyType = .done
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
    }

    @IBAction func capitalize(_ sender: Any) {
        nameField.text = nameField.text?.capitalized
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - Lyrics Generator
func indexOfFirstVowel(_ name: String) -> Int {
    let name = name.folding(options: .diacriticInsensitive, locale: .current)
    for (index, letter) in name.characters.enumerated() {
        if "aeiouy".characters.contains(letter) {
            return index
        }
    }
    return -1
}


func shortNameFromName(_ name: String) -> String {
    if !name.isEmpty {
        let name = name.lowercased()
        let index = name.index(name.startIndex, offsetBy: indexOfFirstVowel(name))
        return name.substring(from: index)
    } else {
        return ""
    }
}

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    return lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(fullName))
}

