//
//  Auxiliar.swift
//  ReadMe
//
//  Created by Luiz Gustavo Silva Aguiar on 21/03/22.
//
//
//import Foundation
//
//Criar protocolo
//protocol CustomActionsDelegate {
//    func configureAccessibility()
//}
//
//var delegate: CustomActionsDelegate?
//
//Criar custom actions
//extension LibraryViewController: CustomActionsDelegate {
//    func configureAccessibility() {
//        isAccessibilityElement = true
//        let deleteAction = UIAccessibilityCustomAction(
//            name: "Deletar",
//            target: self,
//            selector: #selector(didTouchDeleteCellAction))
//
//        let pinAction = UIAccessibilityCustomAction(
//            name: "Fixar",
//            target: self,
//            selector: #selector(didTouchPinCellAction))
//
//        accessibilityCustomActions =
//        [
//            deleteAction,
//            pinAction
//        ]
//    }
//}
//
//Criar seletores
//@objc func didTouchDeleteCellAction() -> Bool {
//    guard let indexPath = tableView.indexPathForSelectedRow else { return false }
//    Library.books.remove(at: indexPath.row)
//    tableView.deleteRows(at: [indexPath], with: .fade)
//    return true
//}
//
//@objc func didTouchPinCellAction() -> Bool {
//    guard let indexPath = tableView.indexPathForSelectedRow else { return false }
//    Library.books[indexPath.row].isPinned.toggle()
//    Library.sort()
//    tableView.reloadData()
//    return true
//}
//
//Configurar celula
//cell.delegate?.configureAccessibility()
//cell.delegate = self

//
//override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    let deleteAction = UIContextualAction(style: .destructive, title: "deletar") { (action, view, completionHandler) in
//        Library.books.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        completionHandler(true)
//    }
//    deleteAction.image = UIImage(systemName: "trash")
//    deleteAction.backgroundColor = .red
//
//    let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
//    return swipe
//}
//
//override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    let book = Library.books[indexPath.row]
//
//    let readAction = UIContextualAction(style: .normal, title: book.readed ? "Não lido" : "Lido") { (action, view, completionHandler) in
//        Library.books[indexPath.row].readed.toggle()
//        Library.sort()
//        tableView.reloadData()
//        completionHandler(true)
//    }
//    readAction.image = UIImage(systemName: "message.fill")
//    readAction.backgroundColor = .orange
//
//    let favoriteAction = UIContextualAction(style: .normal, title: book.isFavorite ? "Desfavoritar" : "Favoritar") { (action, view, completionHandler) in
//        completionHandler(true)
//    }
//    favoriteAction.image = UIImage(systemName: book.isFavorite ? "star.slash.fill" : "star.fill")
//    favoriteAction.backgroundColor = .blue
//
//    let swipe = UISwipeActionsConfiguration(actions: [readAction, favoriteAction])
//    return swipe
//}
