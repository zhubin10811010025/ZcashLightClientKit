//
//  GetTransparentTransactionsViewController.swift
//  ZcashLightClientSample
//
//  Created by Francisco Gindre on 8/12/20.
//  Copyright © 2020 Electric Coin Company. All rights reserved.
//

import UIKit
import ZcashLightClientKit
import KRProgressHUD
class GetTransparentTransactionsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    var synchronizer: Synchronizer!
    
    var areThereAnyResults = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         synchronizer = AppDelegate.shared.sharedSynchronizer
    }
    
    @IBAction func fetchTransactions(_ sender: Any) {
        guard Initializer.shared.isValidTransparentAddress(textView.text) else {
            return
        }
        KRProgressHUD.show()
        
        synchronizer.unspentTransactionOutputs(for: textView.text) { [weak self] (result) in
            KRProgressHUD.dismiss()
            switch result {
            case .success(let r):
                self?.areThereAnyResults = r
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
    
    func showError(_ error: Error)  {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        self.show(alert, sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
