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
    
    var lastColorChoosed: PaletteView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateStartStates()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        lastColorChoosed.setNeedsDisplay()
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
    
    @IBAction func enableSwitch(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                            self.pickerContainerView.isHidden = !sender.isOn
                            self.datePicker.isHidden = !sender.isOn
                        },
                       completion: nil
        )
    }
    
    private func activateStartStates() {
        lastColorChoosed = firstColor
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
