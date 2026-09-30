//
//  ViewController.swift
//  POP!Corn
//
//  Created by Luca Mastroianni and Giuseppe Tansella on 26/06/2019.
//  Copyright © 2019 unicampania.it. All rights reserved.
//

import UIKit
import AVFoundation

let player = Player()
var bubble_controller: Text_Bubble!
var bubble_container = [BubbleView]()

class ViewController: UIViewController, UITextFieldDelegate {

    //===============================
    // - OUTLET

    
    @IBOutlet var chat_table: UIScrollView!
    @IBOutlet var answer_table: UIView!
    @IBOutlet var tap_gesture: UITapGestureRecognizer!
    
    @IBAction func close_text_field(_ sender: Any) {
        if text_enter!.superview == nil {
            return;
        }
        textFieldShouldReturn(text_enter)
    }
    
    //===============================
    let movies = Movies_Database()
    let debugger = DEBUGGER()
    var current_question: (String, (yes: Answer, no: Answer, maybe: Answer, skip: Answer)?)!
    var is_question_started: Int!
    var text_enter: UITextField!
    
    //=============================
    // is_question_started può assumere
    // tre valori:
    // -1: Il test non è ancora cominciato; altre azioni;
    // 0: Il test è cominciato. Si tratta di film;
    // 1: Il test è cominciato. Si tratta di serie tv; 
    //=============================
    
    //bubble_controller.draw_bubble_kun(text: "Hello my name is Ciaky! Nice to meet you!", coord: (150.0, 200.0), inc: true)
    //bubble_controller.draw_bubble_kun(text: "Hey buddy, It's a pleasure!", coord: ((self.view.frame.width) - 150.0, 300.0), inc: false)
    override func viewDidLoad() {
        // DA TOGLIERE
        chat_table.contentSize = CGSize(width: 0, height: 1024)
        debugger.debug_callback(callback: clear_defaults)
        bubble_controller = Text_Bubble(cc: self)
        // QUESTION SYSTEM INITIALIZED
        is_question_started = -1;
        set_default_menu()
        //=========================
        super.viewDidLoad()
        //======================
        // REMOVE BAR
        chat_table.showsVerticalScrollIndicator = false;
        //=====================
        text_enter = UITextField(frame: CGRect(x: 0, y: self.view.frame.height/2 - (36/2), width: self.view.frame.width, height: 36))
        text_enter.placeholder = "Type your name..."
        text_enter.delegate = self;
        // Do any additional setup after loading the view.
        let has_name = UserDefaults.standard.value(forKey: "ciaky_knows_name");
        if (has_name == nil) {
            bubble_controller.draw_bubble_kun(text: "Hello! My name is Ciaky. I want to know your name to fuck Peppe.", inc: true, ciaky_face: "ciaky_default")
            self.view.addSubview(text_enter)
            text_enter.becomeFirstResponder()
        }
        else {
            player.set_name(your_name: UserDefaults.standard.string(forKey: "ciaky_knows_name")!);
            let message = "Hey! Nice to see you again, \(player.name)!"

        }
        print(children)
        //print(movies.get_random_movie_info(type: 1))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("HEY I JUST MET YOU AND THIS CRAZY!! BUT YOU CALLED ME AND I'M IN MEMORY!")
        if text_enter.superview == nil {return false;}
        view.endEditing(true)
        text_enter.resignFirstResponder();
        let tt = self.text_enter.text!
        if tt == "" {
            text_enter.becomeFirstResponder()
            return false;
        }
        player.set_name(your_name: tt)
        UserDefaults.standard.set(tt, forKey: "ciaky_knows_name")
        player.unlock_achievement(index: 0, controller: self)
        text_enter.text = ""
        text_enter.removeFromSuperview()
        bubble_controller.draw_bubble_kun(text: "Hello! My name is \(player.name)! Nice to meet you!", inc: false, ciaky_face: nil)
        tap_gesture.isEnabled = false;
        return false;
    }
    
    private func clear_defaults() {
        UserDefaults.standard.removeObject(forKey: "ciaky_knows_name")
    }
    
    private func set_default_menu() -> Void {
        current_question = ("Let's see a new movie!|Can you suggest me a series?|Let's handle notifications!|Show me my badges!", nil)
    }

}

/*
 
 let alertController = UIAlertController(title: "What's your name?", message: "", preferredStyle: .alert)
 alertController.addTextField { (textField : UITextField!) -> Void in
 textField.placeholder = "Type your name..."
 }
 let saveAction = UIAlertAction(title: "Nice to meet you!", style: .default, handler: { alert -> Void in
 let firstTextField = alertController.textFields![0] as UITextField
 UserDefaults.standard.set(firstTextField.text!, forKey: "ciaky_knows_name")
 self.player.set_name(your_name: firstTextField.text!)
 let message = "Hey, \(self.player.name)! Nice to meet you, too!"
 self.process_ciaky_message(message: message)
 //self.player.unlock_achievement(index: 0, controller: self)
 //self.debugger.clear_achievements()
 })
 
 alertController.addAction(saveAction)
 
 self.present(alertController, animated: true, completion: nil)
 
 */
