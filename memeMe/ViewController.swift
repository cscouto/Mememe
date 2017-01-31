//
//  ViewController.swift
//  memeMe
//
//  Created by Tiago henrique on 1/26/17.
//  Copyright © 2017 Tiago henrique. All rights reserved.
//

import UIKit

struct Meme{
    var textTop:String?
    var textBottom:String?
    var originalImage: UIImage!
    var memed: UIImage!
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var camBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        textBottom.delegate = self
        textTop.delegate = self
        
        textTop.text = "TOP"
        textBottom.text = "BOTTOM"
        
        let memeTextAtrs: [String:Any] = [NSStrokeColorAttributeName: UIColor.black,
                                          NSForegroundColorAttributeName: UIColor.white,
                                          NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
        
        
        textTop.defaultTextAttributes = memeTextAtrs
        textBottom.defaultTextAttributes = memeTextAtrs
        
        textTop.textAlignment = NSTextAlignment.center
        textBottom.textAlignment = NSTextAlignment.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unSubscribeToKeyboardNotifications()
    }
    
    func keyboardWillShow(_ notification:Notification){
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardsize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardsize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unSubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismiss(animated: true, completion: nil)
       return true
    }

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        
        let pickController = UIImagePickerController()
        
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        present(pickController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickFromCam(_ sender: UIBarButtonItem) {
        let pickController = UIImagePickerController()
        
        pickController.delegate = self
        pickController.sourceType = .camera
        present(pickController, animated: true, completion: nil)
    }
    
    @IBAction func shareBtnPressed(_ sender: UIBarButtonItem) {
        
        let activityVC = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: save)
    }
    func save() {
        // Create the meme
        let meme = Meme(textTop: textTop.text!, textBottom: textBottom.text!, originalImage: imageView.image!, memed: generateMemedImage())
        
        
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        return memedImage
    }
    
}

