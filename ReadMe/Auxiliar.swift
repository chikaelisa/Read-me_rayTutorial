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


