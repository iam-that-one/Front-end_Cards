//
//  ViewController.swift
//  readMyServer
//
//  Created by Abdullah Alnutayfi on 07/02/2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var lbl : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
       return $0
    }(UILabel())
    
    lazy var btn : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("New card", for: .normal)
        $0.addTarget(self, action: #selector(newSeentenceBtnClicked), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    let server = "http://localhost:1001/cards"
    override func viewDidLoad() {
        super.viewDidLoad()
        readData()
        view.addSubview(lbl)
        view.addSubview(btn)
        lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lbl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        btn.topAnchor.constraint(equalTo: lbl.bottomAnchor,constant: 20).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func readData(){
        let task = URLSession.shared.dataTask(with: URL(string: server)!) { (data, response, error) in
            if let error = error {
                print("error",error)
                return
            }
            let decoder = JSONDecoder()
            if let data = data {
                var cards: String! = nil
                do {
                    cards = try decoder.decode(String.self,from: data)
                } catch let error {
                    print("Error:\( error)")
                    return
                }
                DispatchQueue.main.async {
                    self.lbl.text = cards
                }
            } else {
                print("no data was returned")
            }
        }
        task.resume()
    }
    
    @objc func newSeentenceBtnClicked(){
        readData()
    }
}

