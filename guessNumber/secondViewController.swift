//
//  secondViewController.swift
//  guessNumber
//
//  Created by 楊昕蕾 on 2021/9/18.
//

import UIKit

class secondViewController: UIViewController {
    
    @IBOutlet weak var chanceLbl: UILabel!
    
    @IBOutlet weak var resultTextView0: UITextView!
    
    @IBOutlet weak var resultTextView1: UITextView!

    @IBOutlet weak var guessNum: UILabel!
    
    var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var answer = [0, 0, 0, 0]
    var guess = [0, 0, 0, 0]
    var chances = 10
    var a = 0
    var b = 0
    var round = 0
    var gameOver = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numbers.shuffle()
        
    }

    @IBAction func input(_ sender: UIButton) {
        
        if guessNum.text!.count < 4 && guessNum.text!.contains(String(sender.tag)) != true{
            guessNum.text! += String(sender.tag)
        }

    }
        
    
    @IBAction func guessBtn(_ sender: UIButton) {
        
        if guessNum.text!.count == 4 && gameOver == false{
            
            round += 1
            chances -= 1
            chanceLbl.text = "残り\(chances)回"

            let guessNumbers = Int(guessNum.text!)!
            guess[0] = guessNumbers / 1000
            guess[1] = guessNumbers / 100 % 10
            guess[2] = guessNumbers / 10 % 10
            guess[3] = guessNumbers % 10
            
            for i in 0...3{
                answer[i] = numbers[i]
                
                if guess[i] == answer[i]{
                    a += 1
            }
                else if guess.contains(answer[i]) == true{
                    b += 1
                }
            }
//            print(answer)
//            print(guessNumbers)
//            print("\(a)A\(b)B")
            
            gamePlay()
            showResult()
            a = 0
            b = 0
            guessNum.text = ""
            
        }
        

    }
    
    func showResult(){
        let guessNumbers = String(guessNum.text!)
        if round <= 5{
            resultTextView0.text = resultTextView0.text + guessNumbers + "　　\(a)A\(b)B\n"
        }
        else {
            resultTextView1.text = resultTextView1.text + guessNumbers + "　　\(a)A\(b)B\n"
        }
        

    }
    
    func gamePlay(){
        if a == 4{
            firstPrizeHint()
            gameOver = true
            
        }
        else if chances == 0{
            if a == 3 && guess[0] != answer[0]{
                sixthPrizeHint()
                gameOver = true
            }
            else{
                gameOverHint()
                gameOver = true
            }
        }

    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        
        if guessNum.text != ""{
            guessNum.text?.removeLast()
        }
        
    }
    
    
    @IBAction func restartBtn(_ sender: Any) {
        numbers.shuffle()
        guessNum.text = ""
        gameOver = false
        round = 0
        chances = 10
        chanceLbl.text = "残り\(chances)回"
        resultTextView0.text = ""
        resultTextView1.text = ""
        
    }
    
    
    func gameOverHint(){
        let alerController = UIAlertController(
            title: "GAME OVER",
            message: "沒中獎，老實點上班吧",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "再玩一次",
            style: .default,
            handler: (restartBtn(_:)))
        
        alerController.addAction(okAction)
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
    
    func firstPrizeHint(){
        let alerController = UIAlertController(
            title: "中頭獎啦～",
            message: "該不會這輩子運氣都用在這吧",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "再玩一次",
            style: .default,
            handler: (restartBtn(_:)))
        
        alerController.addAction(okAction)
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
    
    func sixthPrizeHint(){
        let alerController = UIAlertController(
            title: "只中200",
            message: "已經算是奇蹟了",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "再玩一次",
            style: .default,
            handler: (restartBtn(_:)))
        
        alerController.addAction(okAction)
        
        self.present(
            alerController,
            animated: true,
            completion: nil)

    }
}
