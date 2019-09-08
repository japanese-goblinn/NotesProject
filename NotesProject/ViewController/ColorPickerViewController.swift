//
//  ColorPickerViewController.swift
//  NotesProject
//
//  Created by Kirill Gorbachyonok on 8/31/19.
//  Copyright © 2019 saisuicied. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var hexValueLabel: UILabel!
    @IBOutlet weak var currentColorPaletteView: PaletteView!
    @IBOutlet weak var colorPicker: ColorPickerView!
    @IBOutlet weak var slider: UISlider!
    
    weak var delegate: Colorable?
    
    var passedFromLastVC = false
    lazy var lastTappedPoint: CGPoint = CGPoint.zero
    var brightnessValue: Float = 0.0
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        colorPicker.valueOfDimming = sender.value
        updateCurrentPaletteColor(for: lastTappedPoint)
    }
    
    @IBAction func pickerDragged(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view as? ColorPickerView else { return }
        let translation = sender.translation(in: colorPicker)
        let point = sender.location(in: colorPicker)
        if view.point(inside: point, with: nil) {
            let (x, y) = view.pickerPosition
            lastTappedPoint = CGPoint(
                x: x + translation.x,
                y: y + translation.y
            )
            view.pickerPosition = (lastTappedPoint.x, lastTappedPoint.y)
            updateCurrentPaletteColor(for: lastTappedPoint)
            sender.setTranslation(CGPoint.zero, in: colorPicker)
        }
    }
    
    @IBAction func pickerTapped(_ sender: UITapGestureRecognizer) {
        lastTappedPoint = sender.location(in: colorPicker)
        colorPicker.pickerPosition = (lastTappedPoint.x, lastTappedPoint.y)
        updateCurrentPaletteColor(for: lastTappedPoint)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if passedFromLastVC {
            slider.value = brightnessValue
        } else {
            lastTappedPoint = CGPoint(
                x: colorPicker.bounds.midX,
                y: colorPicker.bounds.midY
            )
        }
        colorPicker.pickerPosition = (lastTappedPoint.x, lastTappedPoint.y)
        colorPicker.valueOfDimming = slider.value
        updateCurrentPaletteColor(for: lastTappedPoint)
    }
    
    func updateCurrentPaletteColor(for point: CGPoint) {
        let color = colorPicker.getColor(in: point)
        currentColorPaletteView.backgroundColor = color
        hexValueLabel.text = currentColorPaletteView.backgroundColor?.hexValue
        delegate?.passValue(of: color)
        delegate?.passValue(of: lastTappedPoint, and: slider.value)
    }
}
