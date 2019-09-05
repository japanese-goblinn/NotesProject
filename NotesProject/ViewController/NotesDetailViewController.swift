//
//  NotesDetailViewController.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/30/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstColor: PaletteView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var lastColorChoosed: PaletteView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateStartStates()
        activateKeyboardHandler()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        lastColorChoosed.setNeedsDisplay()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func chooseFirstColor(_ sender: UITapGestureRecognizer) {
        chooseColor(sender)
    }
    
    @IBAction func chooseSecondColor(_ sender: UITapGestureRecognizer) {
        chooseColor(sender)
    }
    
    @IBAction func chooseThirdColor(_ sender: UITapGestureRecognizer) {
        chooseColor(sender)
    }
    
    @IBAction func chooseCustomColor(_ sender: UITapGestureRecognizer) {
        chooseColor(sender)
        let colorPickerVC = ColorPickerViewController()
        present(colorPickerVC, animated: true)
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        titleTextField.endEditing(true)
        contentTextView.endEditing(true)
    }
    
    @IBAction func enableSwitch(_ sender: UISwitch) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.pickerContainerView.isHidden = !sender.isOn
                self.datePicker.isHidden = !sender.isOn
            },
            completion: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    private func activateKeyboardHandler() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    private func activateStartStates() {
        lastColorChoosed = firstColor
        
        titleTextField.delegate = self
    }
    
    private func chooseColor(_ sender: UITapGestureRecognizer) {
        guard let sender = sender.view as? PaletteView else {
            return
        }
        lastColorChoosed.isChosen = false
        sender.isChosen = true
        sender.setNeedsDisplay()
        lastColorChoosed.setNeedsDisplay()
        lastColorChoosed = sender
    }
}

extension NotesDetailViewController: UITextFieldDelegate {
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.endEditing(true)
        return false
    }
    
}
