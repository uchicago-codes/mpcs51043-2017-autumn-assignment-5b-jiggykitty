import Foundation

public struct MorseCoder {
  var codeDictionary: [Character : String] = [:]
  var letterDictionary: [String : Character] = [:]
  var supportedCharacters: [Character] = []

  public init(codeTablePath: String) throws {
    do {
      let rawCodeDictionary = try String(contentsOfFile: codeTablePath)
      for line in rawCodeDictionary.components(separatedBy: CharacterSet.newlines) {
        if line.count > 0 {
          let char = line[line.startIndex]
          let codeRange = line.index(line.startIndex, offsetBy: 4)..<line.index(before:line.endIndex)
          let code = line[codeRange]
          self.codeDictionary[char] = String(code)
          if ![".", "-", " ", "/"].contains(char) {
            self.supportedCharacters.append(char)
          }
        }
      }
      for pair in codeDictionary {
        self.letterDictionary[pair.value] = pair.key
      }
    }
    catch {
      print("Invalid File")
      throw error
    }
  }

  public func encode(word: String) -> String {
    var output: String = ""
    for character in word {
      if let code = self.codeDictionary[character] {
        output.append("\(code) ")
      }
      else {
        return "Invalid Input"
      }
    }
    return output
  }

  public func decode(code: String) -> String {
    var output: String = ""
    for code in code.components(separatedBy: CharacterSet.whitespaces) {
      if let letter = self.letterDictionary[code] {
        output.append("\(letter)")
      }
      else {
        return "Invalid Input"
      }
    }
    return output
  }

  public func isEnglish(input: String) -> Bool {
    if input.contains(where: {supportedCharacters.contains($0)}) {
      return true
    }
    else {
      return false
    }
  }
}
