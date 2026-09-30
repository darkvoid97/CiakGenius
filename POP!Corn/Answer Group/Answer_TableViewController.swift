//
//  Answer_TableViewController.swift
//  POP!Corn
//
//  Created by Luca Mastroianni and Giuseppe Tansella on 28/06/2019.
//  Copyright © 2019 unicampania.it. All rights reserved.
//

import UIKit

class Answer_TableViewController: UITableViewController {
    
    let question_controller = Fun_Questions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.isScrollEnabled = false
    }
    
    private func special_parent() -> ViewController? {
        if let pp = self.parent {
            return pp as? ViewController
        }
        return nil
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    func get_answers_tuple_key(indexPath: IndexPath) -> Answer {
        let ans = special_parent()!.current_question.1!
        switch indexPath.row {
        case 0:
            return ans.yes
        case 1:
            return ans.no
        case 2:
            return ans.maybe
        default:
            return ans.skip
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        // Configure the cell...
        let is_started = special_parent()!.is_question_started!
        if is_started < 0 || is_started > 1 {
            let str_arr = special_parent()!.current_question.0.components(separatedBy: "|")
            cell.textLabel?.text = str_arr[indexPath.row]
        }
        else if is_started == 0 {
            let ans = get_answers_tuple_key(indexPath: indexPath)
            cell.textLabel?.text = ans.ans;
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.parent?.performSegue(withIdentifier: "ShowMovie", sender: indexPath.row)
        let cell = tableView.cellForRow(at: indexPath);
        switch cell?.textLabel?.text?.lowercased() {
        case "show me my badges!":
            self.parent?.performSegue(withIdentifier: "Awards", sender: nil)
        case "let's see a new movie!":
            special_parent()?.is_question_started = 0;
            bubble_controller.draw_bubble_kun(text: "Perfect!! Let's find something to watch together", inc: true, ciaky_face: "ciaky_default")
            tableView.isUserInteractionEnabled = false;
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.special_parent()?.current_question = self.question_controller.get_random_question()
                let curr = self.special_parent()?.current_question;
                bubble_controller.draw_bubble_kun(text: curr!.0, inc: true, ciaky_face: "ciaky_default")
                self.tableView.reloadData()
            }
        default:
            // TODO: Handle all the answers; 
            let ans = get_answers_tuple_key(indexPath: tableView.indexPathForSelectedRow!)
            bubble_controller.draw_bubble_kun(text: ans.ans, inc: false, ciaky_face: nil)
            question_controller.quest_done.append(ans.ans);
            //ans.property!.count
            /*if let property = ans.property {
                for ind in 0..<property.count {
                    
                }
            }*/
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.special_parent()?.current_question = self.question_controller.get_random_question()
                let curr = self.special_parent()?.current_question;
                bubble_controller.draw_bubble_kun(text: curr!.0, inc: true, ciaky_face: "ciaky_default")
                self.tableView.reloadData()
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
