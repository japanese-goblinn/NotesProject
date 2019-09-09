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
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var firstColor: PaletteView!
    @IBOutlet var secondColor: PaletteView!
    @IBOutlet var thirdColorView: PaletteView!
    @IBOutlet var customColor: PaletteView!
    var lastColorChoosedView: PaletteView!
    
    weak var delegate: Noteable?
    
    var note: Note?
    var pickerCoordinates: CGPoint = .zero
    var brightnessValue: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateStartStates()
        activateKeyboardHandler()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        lastColorChoosedView.setNeedsDisplay()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func chooseFirstColor(_ sender: UITapGestureRecognizer) {
        chooseColor(for: sender.view as? PaletteView)
    }
    
    @IBAction func chooseSecondColor(_ sender: UITapGestureRecognizer) {
        chooseColor(for: sender.view as? PaletteView)
    }
    
    @IBAction func chooseThirdColor(_ sender: UITapGestureRecognizer) {
        chooseColor(for: sender.view as? PaletteView)
    }
    
    @IBAction func chooseCustomColor(_ sender: UITapGestureRecognizer) {
        chooseColor(for: sender.view as? PaletteView)
        let colorPickerVC = ColorPickerViewController()
        if !lastColorChoosedView.isGradient {
            colorPickerVC.passedFromLastVC = true
            colorPickerVC.lastInteractedPoint = pickerCoordinates
            colorPickerVC.brightnessValue = brightnessValue
        }
        present(colorPickerVC, animated: true)
        colorPickerVC.delegate = self
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        titleTextField.endEditing(true)
        contentTextView.endEditing(true)
        saveNote()
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
    
    private func saveNote() {
        note = Note(
            title: titleTextField.text ?? " ",
            content: contentTextView.text,
            date: nil,
            uid: UUID().uuidString,
            color: lastColorChoosedView.backgroundColor ?? .white,
            priority: .general
        )
        if let note = note {
            delegate?.passNote(note)
        }
    }
    
    private func activateStartStates() {
        lastColorChoosedView = firstColor
        titleTextField.delegate = self
        guard let note = note else { return }
        titleTextField.text = note.title
        title = note.title
        contentTextView.text = note.content
        matchColor(for: note)
    }
    
    private func matchColor(for note: Note) {
        switch note.color {
        case .white:
            chooseColor(for: firstColor)
        case .red:
            chooseColor(for: secondColor)
        case .green:
            chooseColor(for: thirdColorView)
        default:
            customColor.isGradient = false
            chooseColor(for: customColor)
        }
    }
    
    private func chooseColor(for view: PaletteView?) {
        guard let view = view else { return }
        lastColorChoosedView.isChosen = false
        view.isChosen = true
        view.setNeedsDisplay()
        lastColorChoosedView.setNeedsDisplay()
        lastColorChoosedView = view
    }
}

extension NotesDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.endEditing(true)
        return false
    }
    
}

extension NotesDetailViewController: Colorable {
    
    func passValue(of coordinates: CGPoint, and brightness: Float) {
        pickerCoordinates = coordinates
        brightnessValue = brightness
    }
    
    func passValue(of color: UIColor) {
        lastColorChoosedView.backgroundColor = color
        lastColorChoosedView.isGradient = false
    }
    
}

