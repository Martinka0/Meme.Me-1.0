
//  ViewController.swift
//  Imagepicker
//
//  Created by Martina Klimova on 11/05/2017.
//  Copyright © 2017 Martina Klimova. All rights reserved.
//
import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextFieldDelegate {
	
	
	@IBOutlet weak var imagePickerView: UIImageView!
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var bottomTextField: UITextField!
	@IBOutlet weak var cameraButton: UIBarButtonItem!
	@IBOutlet weak var albumButton: UIBarButtonItem!
	
	@IBOutlet weak var shareToolbar: UIToolbar!
	@IBOutlet weak var pickToolbar: UIToolbar!


	override func viewDidLoad() {
		super.viewDidLoad()
		let textField = [topTextField,bottomTextField]
		func textFieldsSetup(textFields: [UITextField?])
		{
			// let defaultString : String = "GET CREATIVE"
			
			let memeTextAttributes:[String:Any] = [
				//Outline Colour
				NSStrokeColorAttributeName: UIColor.black,
				//Text Colour
				NSForegroundColorAttributeName : UIColor.white,
				NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 60)!,
				NSStrokeWidthAttributeName : -4.0
				] as [String : Any]
			for textField in textFields
			{
				textField?.defaultTextAttributes = memeTextAttributes
				textField?.textAlignment = .center
				//			textField?.delegate = self
			}
		}
	}
	
	func cameraCheck()
	{
		cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		subscribeToKeyboardNotifications()
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
		
		super.viewWillDisappear(animated)
		unsubscribeFromKeyboardNotifications()
	}
	
	func keyboardWillShow(_ notification:Notification) {
		
		view.frame.origin.y = 0 - getKeyboardHeight(notification)
	}
	
	func getKeyboardHeight(_ notification:Notification) -> CGFloat {
		
		let userInfo = notification.userInfo
		let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
		return keyboardSize.cgRectValue.height
	}
	
	func subscribeToKeyboardNotifications() {
		
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
	}
	
	func unsubscribeFromKeyboardNotifications() {
		
		NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
	}
	
	func pickAnImageFromSource(source: UIImagePickerControllerSourceType) {
		let pickerImage = UIImagePickerController()
		
		pickerImage.delegate = self
		pickerImage.sourceType = source
		present(pickerImage, animated: true, completion: nil)
	}
	
	@IBAction func cameraButtonAction(_ sender: Any) {
		pickAnImageFromSource(source: .camera)
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
	
}
