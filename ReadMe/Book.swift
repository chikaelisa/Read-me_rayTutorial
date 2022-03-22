import UIKit

struct Book {
    let title: String
    let author: String
    var review: String?
    var isPinned: Bool = false
    var image: UIImage {
        Library.loadImage(forBook: self) ??
        LibrarySymbol.letterSquare(letter: title.first).image
    }
}
