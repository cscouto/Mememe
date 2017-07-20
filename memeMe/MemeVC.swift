//
//  ViewController.swift
//  memeMe
//
//  Created by Tiago henrique on 1/26/17.
//  Copyright © 2017 Tiago henrique. All rights reserved.
//

import UIKit

class MemeVC: UIViewController {
    
    //outlets
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var camBtn: UIBarButtonItem!
    @IBOutlet var btnShare: UIBarButtonItem!
    @IBOutlet var toolBar: UIToolbar!
    
    //life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        textBottom.delegate = self
        textTop.delegate = self
        
        textTop.text = "TOP"
        textBottom.text = "BOTTOM"
        btnShare.isEnabled = false
        
       /* let memeTextAtrs: [String:Any] = [NSStrokeColorAttributeName: UIColor.black,
                                          NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                          NSStrokeWidthAttributeName: 2.0]
        
        
        textTop.defaultTextAttributes = memeTextAtrs
        textBottom.defaultTextAttributes = memeTextAtrs*/
        
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
    
    //actions
    @IBAction func pickFromCam(_ sender: UIBarButtonItem) {
        let pickController = UIImagePickerController()

        pickController.delegate = self
        pickController.sourceType = .camera
        present(pickController, animated: true, completion: nil)
    }
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let pickController = UIImagePickerController()
        
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        present(pickController, animated: true, completion: nil)
    }
    @IBAction func shareBtnPressed(_ sender: UIBarButtonItem) {
        let activityVC = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {
            data in
            self.navigationController?.popToRootViewController(animated: true)
        }
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: save)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    
    //custom functions
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardsize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardsize.cgRectValue.height
    }
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func unSubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    func keyboardWillShow(_ notification:Notification){
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    func save() {
        
        // Create the meme
        let meme = Meme(textTop: textTop.text!, textBottom: textBottom.text!, originalImage: imageView.image!, memed: generateMemedImage())
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        self.navigationController?.navigationBar.isHidden =  true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        self.navigationController?.navigationBar.isHidden =  false
        
        return memedImage
    }
    
}


extension MemeVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


extension MemeVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            btnShare.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

