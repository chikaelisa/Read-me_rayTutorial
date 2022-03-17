import UIKit

class LibraryViewController: UITableViewController {

    @IBSegueAction func showDetailView(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow
            else {fatalError("Nothing selected")}
        let book = Library.books[indexPath.row]
        
        return DetailViewController(coder: coder, book: book)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK:- Delegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Read Me!" : nil
    }
    // MARK:- Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //is setion equal 0? Than returns 1, otherwise, returns library.book.count
        return section == 0 ? 1 : Library.books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
        else {fatalError("Could not create BooCell")}
        let book = Library.books[indexPath.row]
        
        cell.titleLabel .text = book.title
        cell.authorLabel.text = book.author
        cell.bookThumbnail.image = book.image
        cell.bookThumbnail.layer.cornerRadius = 12
        
        cell.isAccessibilityElement = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Library.books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


