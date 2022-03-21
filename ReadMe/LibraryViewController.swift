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
        Library.sort()
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "deletar") { (action, view, completionHandler) in
            Library.books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        let pin = UIContextualAction(style: .normal, title: Library.books[indexPath.row].isPinned ? "desafixar" : "fixar") { (action, view, completionHandler) in
            Library.books[indexPath.row].isPinned.toggle()
            Library.sort()
            tableView.reloadData()
        }
        
        pin.image = UIImage(systemName: "pin.fill")
        pin.backgroundColor = .orange
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, pin])
        return swipe
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
        if book.isPinned {
            cell.backgroundColor = UIColor.blue.withAlphaComponent(0.05)
        }
        else {
            cell.backgroundColor  = nil
        }
        
        cell.delegate?.configureAccessibility()
        cell.delegate = self
        return cell
    }
    
    @objc func didTouchDeleteCellAction() -> Bool {
        guard let indexPath = tableView.indexPathForSelectedRow else { return false }
        Library.books.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        return true
    }
    
    @objc func didTouchPinCellAction() -> Bool {
        guard let indexPath = tableView.indexPathForSelectedRow else { return false }
        Library.books[indexPath.row].isPinned.toggle()
        Library.sort()
        tableView.reloadData()
        return true
    }
}

extension LibraryViewController: CustomActionsDelegate {
    func configureAccessibility() {
        isAccessibilityElement = true
        let deleteAction = UIAccessibilityCustomAction(
            name: "Deletar",
            target: self,
            selector: #selector(didTouchDeleteCellAction))
        
        let pinAction = UIAccessibilityCustomAction(
            name: "Fixar",
            target: self,
            selector: #selector(didTouchPinCellAction))
        
        accessibilityCustomActions =
        [
            deleteAction,
            pinAction
        ]
    }
}


