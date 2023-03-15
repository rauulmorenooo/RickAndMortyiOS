//
//  RickAndMortyViewController.swift
//  R&M Characters
//
//  Created by Raul Moreno on 10/3/23.
//

import UIKit

class RickAndMortyViewController: UIViewController {

    private let PREVIOUS_TAG = 1
    private let NEXT_TAG = 2
    
    @IBOutlet weak var viewScrollView: UIScrollView!
    @IBOutlet weak var viewContentView: UIView!
    @IBOutlet weak var viewSearchTextFieldView: UITextField!
    @IBOutlet weak var viewTableView: UITableView!
    @IBOutlet weak var viewFooterButtonView: UIStackView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var characterList: [CharacterResult] = []
    
    private var previousUrl: String = ""
    private var nextUrl: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.previousButton.tag = PREVIOUS_TAG
        self.nextButton.tag = NEXT_TAG
        
        self.viewSearchTextFieldView.placeholder = "Type a character you want to filter"
        self.viewSearchTextFieldView.delegate = self
        
        self.viewTableView.delegate = self
        self.viewTableView.dataSource = self
        self.viewTableView.separatorStyle = .none
        
        self.viewTableView.register(UINib(nibName: "RMTablewViewCell", bundle: nil), forCellReuseIdentifier: "RMTablewViewCell")
        
        self.getRickAndMortyCharacterList(withUrl: Constants.RM_BASE_URL + Constants.RM_CHARACTER)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
            case PREVIOUS_TAG:
                if !self.previousUrl.isEmpty {
                    self.getRickAndMortyCharacterList(withUrl: self.previousUrl)
                }
            case NEXT_TAG:
                if !self.nextUrl.isEmpty {
                    self.getRickAndMortyCharacterList(withUrl: self.nextUrl)
                }
            default:
                break;
        }
    }
    
    private func getRickAndMortyCharacterList(withUrl url: String) {
        RMHttpClient.shared.getRickAndMortyCharacterList(withUrl: url) { result in
            self.previousUrl = result.prev ?? ""
            self.nextUrl = result.next ?? ""
            
            self.characterList = result.results
            
            DispatchQueue.main.async {
                self.viewTableView.reloadData()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.viewSearchTextFieldView.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}


extension RickAndMortyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.characterList.count > indexPath.row {
            let character = self.characterList[indexPath.row]
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterViewControllerId") as? CharacterViewController {
                vc.character = character
                vc.modalPresentationStyle = .custom
                vc.transitioningDelegate = self
                self.present(vc, animated: true)
                //self.navigationController?.pushViewController(vc, animated: true)
            }

        }
    }
}

extension RickAndMortyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.characterList.count > indexPath.row {
            if let cell = viewTableView.dequeueReusableCell(withIdentifier: "RMTablewViewCell") as? RMTablewViewCell {
                cell.selectedBackgroundView = UIView()
                let character = self.characterList[indexPath.row]
                RMHttpClient.shared.getImage(fromUrl: character.image) { image in
                    let cellModel = RMTablewViewCellModel(cellImage: image, cellLabelName: character.name, cellStatusString: character.status.rawValue, cellOriginName: character.origin.name)
                    cell.configure(withRMTableViewCellModel: cellModel)
                }
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension RickAndMortyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.viewSearchTextFieldView.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let search = textField.text {
            let url = Constants.RM_BASE_URL + Constants.RM_CHARACTER + "?" + Constants.RM_QUERY_NAME + search.replacingOccurrences(of: " ", with: "+")
            self.getRickAndMortyCharacterList(withUrl: url)
        }
    }
}

extension RickAndMortyViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        RMPresenterViewController(presentedViewController: presented, presenting: presenting)
    }
}
