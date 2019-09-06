//
//  ColorPickerViewController.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/31/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var currentColorPaletteView: PaletteView!
    @IBOutlet weak var colorPicker: ColorPickerView!
    @IBOutlet weak var slider: UISlider!
    
    private lazy var lastTappedPoint: CGPoint = CGPoint.zero
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        colorPicker.valueOfDimming = sender.value
        updateCurrentPaletteColor()
    }
    
    @IBAction func pickerTapped(_ sender: UITapGestureRecognizer) {
        lastTappedPoint = sender.location(in: colorPicker)
        updateCurrentPaletteColor()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.valueOfDimming = slider.value
        updateCurrentPaletteColor()
    }
    
    private func updateCurrentPaletteColor() {
        let color = colorPicker.getColor(in: lastTappedPoint)
        currentColorPaletteView.backgroundColor = color
    }
}
