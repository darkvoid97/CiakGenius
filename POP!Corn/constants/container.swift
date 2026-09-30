//
//  container.swift
//  POP!Corn
//
//  Created by Luca Mastroianni and Giuseppe Tansella on 26/06/2019.
//  Copyright © 2019 unicampania.it. All rights reserved.
//
//  LICENSE: CC-YY-4.0

import Foundation
import UIKit
import AVFoundation

//=========================================
// La classe Bubble_Text crea un oggetto
// grafico simile alle bolle di messaggio
// dei vari servizi di messaggistica
// istantanea.
//=========================================

class Text_Bubble {
    
    var controller: ViewController?
    
    init(cc: ViewController?) {
        if let dd = cc {
            controller = dd
        }
    }
    
    /*func draw_bubble() {
        let width: CGFloat = 0.66 * (controller?.view.frame.width)!
        let height: CGFloat = width / 0.75
        
        let maskView = BubbleView()
        maskView.isIncoming = true
        maskView.backgroundColor = .clear
        maskView.frame.size = CGSize(width: width, height: height)
        
        let imageView = UIImageView(image: UIImage(named: "alpaca"))
        imageView.frame.size = CGSize(width: width, height: height)
        imageView.center = controller?.view.center
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.mask = maskView
        
        view.addSubview(imageView)
    }*/
    
    func draw_bubble_kun(text: String, inc: Bool, ciaky_face: String?) {
        let bubbleView = BubbleView()
        //let label =  UILabel()
        bubbleView.inner_label.numberOfLines = 0
        bubbleView.inner_label.font = UIFont.systemFont(ofSize: 18)
        bubbleView.inner_label.textColor = .white
        bubbleView.inner_label.text = text
        
        let constraintRect = CGSize(width: 0.66 * (controller?.view.frame.width)!,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: bubbleView.inner_label.font!],
                                            context: nil)
        bubbleView.inner_label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))
        
        let bubbleSize = CGSize(width: bubbleView.inner_label.frame.width + 20,
                                height: bubbleView.inner_label.frame.height + 20)
        
        bubbleView.isIncoming = inc
        var is_face = false;
        var coord: (CGFloat, CGFloat)
        if(bubble_container.count <= 0) {
            coord = (0,0)
        }
        else {
            let last_message = bubble_container.last!
            coord = (inc ? 0 : (controller?.chat_table.frame.width)! - bubbleSize.width,last_message.frame.origin.y + last_message.frame.height + bubbleSize.height/2)
        }
        if let face = ciaky_face {
            bubbleView.ciaky_face.image = UIImage(named: face)
            bubbleView.ciaky_face.frame = CGRect(x: coord.0, y: coord.1, width: 64, height: 64)
            bubbleView.ciaky_face.contentMode = .scaleAspectFill
            controller?.chat_table.addSubview(bubbleView.ciaky_face)
            is_face = true;
        }
        bubbleView.frame.size = bubbleSize
        bubbleView.backgroundColor = .clear
        let fix = is_face ? bubbleView.ciaky_face.frame.width : 0;
        bubbleView.frame = CGRect(x: coord.0 + fix, y: coord.1, width: bubbleView.frame.width, height: bubbleView.frame.height)
        bubbleView.inner_label.center = CGPoint(x: bubbleView.frame.width/2, y: bubbleView.frame.height/2)
        bubble_container.append(bubbleView)
        if bubble_container.count >= 50 {
            bubble_container[0].removeFromSuperview()
            bubble_container[0].ciaky_face.removeFromSuperview()
            bubble_container.remove(at: 0)
        }
        controller?.chat_table.addSubview(bubbleView)
        controller?.chat_table.addSubview(bubbleView.inner_label)
        if inc {
            AudioServicesPlayAlertSound(1016)
        }
        /*bubbleView.center = CGPoint(x: coord.0, y: coord.1)
        controller?.view.addSubview(bubbleView)
        
        label.center = CGPoint(x: coord.0, y: coord.1)
        controller?.view.addSubview(label)*/
    }
}


class BubbleView: UIView {
    
    var isIncoming = false
    
    var incomingColor = UIColor(white: 0.6, alpha: 1)
    var outgoingColor = UIColor(red: 1, green: 0.54, blue: 0.09, alpha: 1)
    
    var inner_label = UILabel()
    var ciaky_face = UIImageView(image: nil)
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let bezierPath = UIBezierPath()
        
        if isIncoming {
            bezierPath.move(to: CGPoint(x: 22, y: height))
            bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
            bezierPath.addLine(to: CGPoint(x: width, y: 17))
            bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
            bezierPath.addLine(to: CGPoint(x: 21, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
            bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
            bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
            bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
            
            incomingColor.setFill()
            
        } else {
            bezierPath.move(to: CGPoint(x: width - 22, y: height))
            bezierPath.addLine(to: CGPoint(x: 17, y: height))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
            bezierPath.addLine(to: CGPoint(x: 0, y: 17))
            bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
            bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
            bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
            bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
            bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
            
            outgoingColor.setFill()
        }
        
        bezierPath.close()
        bezierPath.fill()
        addSubview(inner_label)
    }
}

//=========================================
// La struttura "DEBUGGER" è un supporto
// per il debugging del codice dell'
// applicazione.
//=========================================

struct DEBUGGER {
    var active: Bool! = true;
    
    public func debug_callback(callback: () -> Void) -> Void {
        if(!active) {return;}
        callback()
    }
    
    public func clear_achievements() {
        debug_callback {
            UserDefaults.standard.removeObject(forKey: "ciaky_achievements")
        }
    }
}

//=========================================
// La classe "Achievements" gestisce
// i badges ottenuti dal giocatore
// nell'utilizzo dell'applicazione.
//=========================================

struct Achievement {
    let name: String;
    let description: String;
    let image: UIImage?
    let points: Int
}

class Player {
    var achievements: [Achievement]
    var achievements_got: [Int]
    var name = ""
    
    init() {
        achievements = []
        achievements_got = []
        if let ach_got = UserDefaults.standard.array(forKey: "ciaky_achievements") {
            achievements_got = ach_got as! [Int]
        }
        //Testing purposes
        debugUnlock(index: 1)
        //----------------
        
        // INDEX: 0
        achievements.append(Achievement(name: "Ciaky knows your name!", description: "Congratulations! You gained a new Buddy!", image: UIImage(named: "CiakyBadge"), points: 10))
        // INDEX: 1
        achievements.append(Achievement(name: "Debug Badge", description: "Testing purposes. Yay!", image: UIImage(named: "trophy"), points: 0))
    }
    
    public func set_name(your_name: String) {
        name = your_name
    }
    
    //Testing purposes
    func debugUnlock(index: Int) {
        if achievements_got.contains(index) {return;}
        achievements_got.append(index)
    }
    //----------------
    
    public func unlock_achievement(index: Int, controller: UIViewController?) {
        if achievements_got.contains(index) {return;}
        achievements_got.append(index)
        let badge = achievements[index]
        /*let alert = UIAlertController(title: badge.name, message: badge.description, preferredStyle: .alert);
        // TODO IMAGE
        // let image = UIImageView(image: UIImage(named: "trophy"))
        let close_action = UIAlertAction(title: "Amazing!", style: .default, handler: { alert -> Void in
            // TODO SOUND
            print("Achievement of ID \(index) got!")
        })
        alert.addAction(close_action)
        controller?.present(alert,animated: true, completion: nil)*/
        UserDefaults.standard.set(achievements_got, forKey: "ciaky_achievements")
    }
    
    public func is_unlocked_achievement(index: Int) -> Bool {
        return achievements_got.contains(index);
    }
}
//=========================================
// La classe "Database" contiene tutte le
// informazioni relative ai film e alle
// serie TV che possono essere richiamati
// all'esito del quiz.
//
// BASE DATI: TMDB - API
//=========================================

class Movies_Database {
    
    var movie_container: [[String: Any]]
    var series_container: [[String: Any]]
    
    init() {
        var json: [[String: Any]]?
        if let path = Bundle.main.path(forResource: "movies", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            } catch {
                // Handle error here
            }
        }
        movie_container = json!
        var new_json: [[String:Any]]?
        if let path = Bundle.main.path(forResource: "series", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                new_json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]]
            } catch {
                // Handle error here
            }
        }
        series_container = new_json!
    }
    
    //========================
    // DEBUG METHOD
    
    public func get_random_movie_info(type: Int) -> ([String:Any], String) {
        let data = type <= 0 ? movie_container : series_container;
        let mov = data[Int.random(in: 0...(data.count - 1))]
        let genres_id = Array(mov["genre_ids"] as! NSArray) as! [Int]
        var genre_str = "";
        if genres_id.count > 0 {
            for prop in genres_id {
                genre_str += get_genre_by_id(id: prop) + ","
            }
        }
        let result = (mov, genre_str)
        return result
    }
    
    public func get_genre_by_id(id: Int) -> String {
        switch id {
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Science Fiction"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        case 10759:
            return "Action & Adventure"
        case 10762:
            return "Kids"
        case 10763:
            return "News"
        case 10764:
            return "Reality"
        case 10765:
            return "Sci-Fi & Fantasy"
        case 10766:
            return "Soap"
        case 10767:
            return "Talk"
        case 10768:
            return "War & Politics"
        default:
            return "Nothing"
        }
    }
}

// 80, 18, 36



//=========================================
// La struttura "Answer" è stata creata per
// gestire le risposte alle domande
// divertenti. Specificamente:
// @property ans -> String:
// -- La stringa contenente la risposta;
// @property property -> (Any)?
// -- Tupla contenete i criteri di selezione dell'API
//=========================================

struct Answer {
    let ans: String
    let property: (Any)?
}

//=========================================
// La classe "Fun Questions" è stata creata per
// gestire l'intero sistema di domande.
// divertenti. Specificamente:
// @property quest_container -> [String:Object]:
// -- Dizionario avente come chiave una stringa e
// quale valore un oggetto complesso.
//=========================================


class Fun_Questions {
    var quest_container = [String:(yes: Answer, no: Answer, maybe: Answer, skip: Answer)]()
    var quest_done = [String]()
    var keywords_got = [String:Int]()
    
    init() {
        quest_done = []
        //====================================================================================
        quest_container["Yee-haw! Let's go ride to the sunset!"] = (
            yes: Answer(ans: "Oh yeah, cowboy!", property: (37, "horse", "indian", "sunset")),
            no: Answer(ans: "Do it yourself, \"Cowboy\"", property: (18, 53, "science", "crimes", "sad")),
            maybe: Answer(ans: "Maybe, when the sun is already gone...", property: (12, "hero", "dark", "night")),
            skip: Answer(ans: "What?", property: nil)
        )
        //=========================================================================================
        quest_container["What do you think about the \"Happy Ever After\""] = (
            yes: Answer(ans: "Aww... So Romantic!", property: ("love", 16, "family", "disney", "cartoon", "princess", "prince", "romantic", 10749)),
            no: Answer(ans: "BLEAH!", property: (18, 27, 10752, "rage", "sad", "unrequited", "bad")),
            maybe: Answer(ans: "Well, better than nothing.", property: (35, 16, "happy", "romantic", "lovers")),
            skip: Answer(ans: "Nothing to say about that.", property: nil)
        )
        //=========================================================================================
        quest_container["Do you like animals?"] = (
            yes: Answer(ans: "Sure!! They're so cute!!", property: (16, 35, 10751, "dog", "cat", "animal", "puppies", "dalmatians", "friends")),
            no: Answer(ans: "Nah... I prefer human beings.", property: (36, 99, 12, "piece", "literature", "hazard", "adventurous", "gamble", "staker")),
            maybe: Answer(ans: "Mmmh... ok, but out of my home.", property: (10770, 12, "dog", "venturer", "wildlife")),
            skip: Answer(ans: "I don't care at all.", property: nil)
        )
        //=========================================================================================
        quest_container["Wow! You have superpowers!"] = (
            yes: Answer(ans: "I'm going to fight a villain!", property: (28,12,16, "power", "villains", "heroes", "comic", "avenger", "supervillain")),
            no: Answer(ans: "What a childish thing...", property: (80, 18, 36, "melodrama", "mature", "adulthood", "serious")),
            maybe: Answer(ans: "I have to learn how to use them.", property: (28,12, "power", "logic", "mystery")),
            skip: Answer(ans: "My only \"Superpower\" is sleeping.", property: nil)
        )
        //=========================================================================================
        quest_container["This night we'll go to the disco!"] = (
            yes: Answer(ans: "\"You can dance... You can jive...\"", property: (16, 35, 16402, "music", "dancing", "disco", "fun", "fever", "80", "ideas")),
            no: Answer(ans: "I can't walk, let alone dancing.", property: (10770, 18, "annoying", "mystery", "slice of life", "morning")),
            maybe: Answer(ans: "At least I will clap my hands!", property: (35, "fun", "family", "dance")),
            skip: Answer(ans: "I think I will not go out this evening.", property: nil)
        )
    }
    
    // 80, 18, 36
    
    public func clear() {
        quest_done = []
        keywords_got.removeAll()
        
    }
    
    public func get_random_question() -> (String, (yes:Answer, no:Answer, maybe:Answer,skip:Answer)?) {
        let database = quest_container
        let keys = Array(database.keys)
        var key = keys[Int.random(in: 0...(keys.count - 1))]
        while(quest_done.contains(key)) {
            key = keys[Int.random(in: 0...(keys.count - 1))]
        }
        return (key, database[key])
    }
}

/*
 
 
 1)Are you happy?
 2)What do you do in your free time?
 4)Do you want to ender in a fantasy world?
 5)Do you want to run around the world?
 6)What feelings di you want to find? - fear-love-friendship
 7)Do you like animals?
 8)Do you discover your history?
 9)Where would you like to go?
 10)Do you like super heroes?
 11)Which are your favorite musical genre?-rock-pop-blus
 12)What type of person are you?-lazy-worker/active-i don’t know
 13)Do you like Jonny Deep?-I love him- I hate him-i don’t know
 14)Do you want to live aboard of ship?-I love adventure-i hate it-i don’t know

*/
