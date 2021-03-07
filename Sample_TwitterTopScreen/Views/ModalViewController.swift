//
//  ModalViewController.swift
//  Sample_TwitterTopScreen
//
//  Created by LylaArakawa on 23/02/21.
//

import UIKit

protocol ModalViewControllerDelegate {
    func modalDidFinish(comment: String, imageView: UIImage?)
}

class ModalViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var imageView: UIImageView!
    
    var delegate: ModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        //キーボード上部にDoneボタンを追加
        makeToolBar()
        //キーボード外を押したらキーボードを閉じる
        dismissKeyboardTouchingOutside()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //以前に選択された画像は消しておく
        imageView.image = nil
        //キーボードを開いておく
        textView.becomeFirstResponder()
    }

    //キーボード上部にDoneボタンを追加
    func makeToolBar() {
        //Toolbarを作成
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        //スタイルを設定
        toolBar.barStyle = .default
        //画面幅に合わせてサイズを変更
        toolBar.sizeToFit()
        //閉じるボタンを右に配置するためのスペース
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        //閉じるボタン
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        //スペース・閉じるボタンを配置
        toolBar.items = [spacer, doneButton]
        //textViewのキーボードにToolbarを配置
        textView.inputAccessoryView = toolBar
    }

    //キーボードを閉じるアクション
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //キーボード外を押したらキーボードを閉じる
    func dismissKeyboardTouchingOutside() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(recognizer)
    }
    
    
    //投稿ボタンを押したらModalを閉じてデータをTableviewへ渡す
    @IBAction func addtweetButton(_ sender: Any) {
            
        let pickedImage = imageView.image
        
        guard let comment = textView.text, !textView.text!.isEmpty else { return  }
        delegate?.modalDidFinish(comment: comment,  imageView: pickedImage)
        textView.text = ""
    }
    
    //キャンセルボタンが押されたらModalを閉じる
    @IBAction func cancelButton(_ sender: Any) {
        textView.text = ""
        self.dismiss(animated: true, completion: nil)
    }
    
}
    //写真を選択する
extension ModalViewController: UIImagePickerControllerDelegate {
    @IBAction func addPhotoButton(_ sender: Any) {
    //アルバムを開く処理を呼び出す
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if let selectedImage = info[.originalImage] as? UIImage {
            //imageViewにカメラロールから選んだ画像を表示する
            imageView.image = selectedImage
            imageView.contentMode = .scaleAspectFill
            //選択した画像の角を丸くする
            imageView.layer.cornerRadius = imageView.bounds.size.height / 4
        }
        //画像をImageViewに表示したらアルバムを閉じる
        self.dismiss(animated: true)
        dismissKeyboard()
    }
}
