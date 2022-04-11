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
        let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { (action, view, completionHandler) in
            Library.books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipe
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let book = Library.books[indexPath.row]
    
        let readAction = UIContextualAction(style: .normal, title: book.readed ? "Não lido" : "Lido") { (action, view, completionHandler) in
            Library.books[indexPath.row].readed.toggle()
            Library.sort()
            tableView.reloadData()
            completionHandler(true)
        }
        readAction.accessibilityHint = ""
        readAction.image = UIImage(systemName: "message.fill")
        readAction.backgroundColor = .orange
    
        let favoriteAction = UIContextualAction(style: .normal, title: book.isFavorite ? "Desfavoritar" : "Favoritar") { (action, view, completionHandler) in
            Library.books[indexPath.row].isFavorite.toggle()
            completionHandler(true)
        }
        favoriteAction.image = UIImage(systemName: book.isFavorite ? "star.slash.fill" : "star.fill")
        favoriteAction.backgroundColor = .blue
    
        let swipe = UISwipeActionsConfiguration(actions: [readAction, favoriteAction])
        return swipe
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath == IndexPath(row: 0, section: 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookCell.self)", for: indexPath) as? BookCell
        else {fatalError("Could not create BookCell")}
        let book = Library.books[indexPath.row]
        cell.titleLabel .text = book.title
        cell.authorLabel.text = book.author
        cell.bookThumbnail.image = book.image
        cell.bookThumbnail.layer.cornerRadius = 12
        cell.backgroundColor = book.readed ? UIColor.blue.withAlphaComponent(0.05) : nil
        cell.isAccessibilityElement = true
        cell.accessibilityHint = "Deslize para cima ou para baixo para ações personalizadas"
        return cell
    }
}




