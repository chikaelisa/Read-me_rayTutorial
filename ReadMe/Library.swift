/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

// MARK:- Reusable SFSymbol Images
enum LibrarySymbol {
    case bookmark
    case bookmarkFill
    case book
    case letterSquare(letter: Character?)
    
    var image: UIImage {
        let imageName: String
        switch self {
        case .bookmark, .book:
            imageName = "\(self)"
        case .bookmarkFill:
            imageName = "bookmark.fill"
        case .letterSquare(let letter):
            guard
                let letter = letter?.lowercased(),
                let image = UIImage(systemName: "\(letter).square")
            else {
                imageName = "circle"
                break
            }
            return image
        }
        return UIImage(systemName: imageName)!
    }
}

// MARK:- Library
enum Library {
    static let review = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    static var books: [Book] = [
            Book(title: "A chegada", author: "Shaun Tan", review: Library.review),
            Book(title: "Bosch", author: "Laurinda Dixon", review: Library.review),
            Book(title: "A coragem de ser imperfeito", author: "Brené Brown", review: Library.review),
            Book(title: "Twilight", author: "Stephanie Meyer", review: Library.review),
            Book(title: "Clube da Luta", author: "Chuck Palahniuk", review: Library.review),
            Book(title: "It - A coisa", author: "Stephen King", review: Library.review),
            Book(title: "A vida e trabalho de Francisco Goya", author: "P. Gassier & J Wilson", review: Library.review),
            Book(title: "Fadas prensadas de Lady Cottington", author: "Lady Cottington", review: Library.review),
            Book(title: "Como desenhar gatos", author: "Janet Rancan", review: Library.review),
            Book(title: "Desenhando pessoas", author: "Barbara Bradley", review: Library.review),
            Book(title: "O que dizer quando você fala consigo mesmo", author: "Shad Helmstetter", review: Library.review)
        ]
    static func sort() {
        books.sort {
            if $0.isPinned == $1.isPinned {
                return $0.title < $1.title
            }
            return $0.isPinned
        }
    }
    static func saveImage(_ image: UIImage, forBook book: Book) {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
        if let jpgData = image.jpegData(compressionQuality: 0.7) {
            try? jpgData.write(to: imageURL, options: .atomicWrite)
        }
    }
    
    static func loadImage(forBook book: Book) -> UIImage? {
        let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
        return UIImage(contentsOfFile: imageURL.path)
    }
}


extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}



