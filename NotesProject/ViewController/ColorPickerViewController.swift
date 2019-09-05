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
    
    @IBAction func pickerTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let color = colorPicker.getColor(for: touch)
            currentColorPaletteView.backgroundColor = color
        }
    }

}
