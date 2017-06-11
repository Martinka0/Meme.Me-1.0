
//  ViewController.swift
//  Imagepicker
//
//  Created by Martina Klimova on 11/05/2017.
//  Copyright © 2017 Martina Klimova. All rights reserved.
//
import UIKit

var memes = [Meme]()

struct Meme {
	var top: String = ""
	var bottom: String = ""
	var image: UIImage?
	var memedImage: UIImage?
}

class ViewController: UIViewController {
	
	@IBOutlet weak var navigationBar: UINavigationBar!
	
	@IBOutlet weak var CancelButton: UIBarButtonItem!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	@IBOutlet weak var imagePickerView: UIImageView!
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var cameraButton: UIBarButtonItem!
	@IBOutlet weak var albumButton: UIBarButtonItem!
	@IBOutlet weak var pickToolbar: UIToolbar!
	
	let memeTextAttributes:[String:Any] = [
		//Outline Colour
		NSStrokeColorAttributeName: UIColor.black,
		//Text Colour
		NSForegroundColorAttributeName : UIColor.white,
		NSFontAttributeName : UIFont(name: "Impact", size: 30)!,
		NSStrokeWidthAttributeName : -4.0
		] as [String : Any]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		
		func textFieldsSetup(textField: UITextField) {
		textField.defaultTextAttributes = memeTextAttributes
		topTextField.text = "TOP"
		bottomTextField.text = "BOTTOM"
		textField.textAlignment = .center
		textField.delegate = self
		}
		textFieldsSetup(textField: topTextField)
		textFieldsSetup(textField: bottomTextField)

	}
	
	override func viewWillAppear(_ animated: Bool) {
		cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
		super.viewWillAppear(animated)
		subscribeToKeyboardNotifications()
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
		
		super.viewWillDisappear(animated)
		unsubscribeFromKeyboardNotifications()
	}
	
// Methods for keyboards and view shifting when editing the bottom text field
	
	func keyboardWillShow(_ notification:Notification) {
	
		view.frame.origin.y -= getKeyboardHeight(notification)
		
		
	}
	
	func keyboardWillHide(_ notification:Notification) {
		
		view.frame.origin.y += getKeyboardHeight(notification)
		
	}


	
	func getKeyboardHeight(_ notification:Notification) -> CGFloat {
		
		let userInfo = notification.userInfo
		let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
		return keyboardSize.cgRectValue.height
	}

	func subscribeToKeyboardNotifications() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
	}

	
	func unsubscribeFromKeyboardNotifications() {
		
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
	
		//  unsubscribe from keyboard will hide
		
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
	}
	
// End of methods for keyboards and view shifting when editing the bottom text field
	

	func generateMemedImage() -> UIImage {
		
		navigationBar.isHidden = true
		pickToolbar.isHidden = true
	
		UIGraphicsBeginImageContext(self.view.frame.size)
		view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
		let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		navigationBar.isHidden = false
		pickToolbar.isHidden = false
		
		return memedImage
	}
	
// Methods for sharing Memed image
	
	func save() {
		
		let memedImage = generateMemedImage()
		_ = Meme(top: topTextField.text!, bottom: bottomTextField.text!, image: imagePickerView.image, memedImage:memedImage)
		
		
	}

	@IBAction func shareButtonAction(_ sender: Any) {
		let memedImage = generateMemedImage()
		let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
		activityController.completionWithItemsHandler = { activity, success, items, error in
			self.save()
			self.dismiss(animated: true, completion: nil)
		}
		
		present(activityController, animated: true, completion: nil)
		
	}
	
// End of methods for sharing Memed image
	
	@IBAction func cancelAction(_ sender: Any) {
	
		topTextField.text = "GET"
		bottomTextField.text = "CREATIVE"
		self.imagePickerView.image = nil
	}


	
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	// Methods for ImagePickerController Delegate
	
	func pickAnImageFromSource(source: UIImagePickerControllerSourceType) {
		let pickerImage = UIImagePickerController()
		pickerImage.delegate = self
		pickerImage.sourceType = source
		present(pickerImage, animated: true, completion: nil)
	}
	
	
	@IBAction func photoAlbumAction(_ sender: Any) {
		pickAnImageFromSource(source: .photoLibrary)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		imagePickerView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func cameraButtonAction(_ sender: Any) {
		if cameraButton.isEnabled == UIImagePickerController.isSourceTypeAvailable(.camera) {
			pickAnImageFromSource(source: .camera)
		}
	}
	
	// End of Methods for ImagePickerController Delegate

}

extension ViewController:  UITextFieldDelegate {
	
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField.tag == 1 {
		unsubscribeFromKeyboardNotifications()
		}
		//  unsubriscribe from Notifications if editing the top text field (textField.tag == 1)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
		if textField.tag == 1 {
			 subscribeToKeyboardNotifications()
		}
		//  subcribe to Notifications after editing the top text field (textField.tag == 1)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
