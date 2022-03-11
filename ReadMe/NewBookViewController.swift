import UIKit

class NewBookViewController: UITableViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var authorTextField: UITextField!
    @IBOutlet var bookImageView: UIImageView!
    
    @IBAction func updateImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera)
        ? .camera
        : .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.layer.cornerRadius = 16
    }
}

extension NewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage
        else { return }
        bookImageView.image = selectedImage
        dismiss(animated: true)
    }
}

extension NewBookViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            return authorTextField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
    /*
        - extensão para fazer que, ao clicar em um textField e subir o teclado, a tecla de retorno execute uma ação. Nesse caso, se clicar em Title, o retorno levará para Author senão, fechará o teclado.
     
        - é preciso associar os delegates dos textFields á classe NewBookViewController. Fiz isso através do sotoryBoard, mas é possível fazer isso no view did load com NomeDoMeuTextField.delegate = self
     
        - também é importante setar, em Text Input Traits, o Return Key para -Next-, em titleTextField e -Done- para authorTextField. Desse modo o botão return exibirá um nome apropriado. Isso também foi feito via storyboard aqui, mas pode ser feito com titleTextField.returnKeyType = .next
     
     */
}
