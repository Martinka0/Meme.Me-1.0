<<<<<<< HEAD
//
//  ViewController.swift
//  Imagepicker
//
//  Created by Martina Klimova on 11/05/2017.
//  Copyright © 2017 Martina Klimova. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
	
	
	@IBOutlet weak var imagePicker: UIImageView!
	@IBOutlet weak var topTextField: UITextField!
	@IBOutlet weak var bottomTextField: UITextField!
	
	
	//let imagePicker = UIImagePickerController()
	

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		func textFieldsSetup(textFields: [UITextField?])
		{
			let defaultString : String = "GET CREATIVE"
			
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

	override func viewWillAppear(_ animated: Bool) {
		//cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
	@IBAction func pickAnImageFromCamera(_ sender: Any) {
		
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		present(imagePicker, animated: true, completion: nil)
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func pickAnImageFromAlbum(_ sender: Any) {
		
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)
		
	}

	func imagePickerControllerDidCancel(_: UIImagePickerController) {
		dismiss(animated: true, completion: nil)
	}

}

||||||| merged common ancestors
=======
//
//  ViewController.swift
//  Imagepicker
//
//  Created by Martina Klimova on 11/05/2017.
//  Copyright © 2017 Martina Klimova. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
	
	
	@IBOutlet weak var imagePicker: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	

		// Do any additional setup after loading the view, typically from a nib.
	}
	override func viewWillAppear(_ animated: Bool) {
		//cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
	@IBAction func pickAnImageFromCamera(_ sender: Any) {
		
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		present(imagePicker, animated: true, completion: nil)
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func pickAnImageFromAlbum(_ sender: Any) {
		
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)
		//dismiss(animated: true, completion: nil)
	}

	@IBAction func pickAnImage(_ sender: Any) {
		// cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
		

		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		present(imagePicker, animated: true, completion: nil)
	//	dismiss(animated: true, completion: nil)

	}
	@objc(imagePickerControllerDidCancel:) func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
		self.dismiss(animated: true, completion: nil)
	}

}

>>>>>>> d1b8e727e7f9f5a719cc6ea2d274580d7c0ac93d
