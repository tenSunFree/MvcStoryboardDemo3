import UIKit

class HomeUIViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()
    private var model: [HomeModel] = []
    private var page = 1
    private var isLoading = false
    
    var serviceImpl = HomeServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        setupRefreshControl()
        getBeerList()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "HomeUITableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeUITableViewCell")
        tableView.rowHeight = 100
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(resetView), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func resetView() {
        serviceImpl.getBeerList(page: 1, completion: { [weak self] beers in
            self?.model = beers
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        })
    }
    
    private func getBeerList() {
        activityIndicator.startAnimating()
        serviceImpl.getBeerList(page: self.page, completion: { [weak self] beers in
            self?.model += beers
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        activityIndicator.stopAnimating()
    }
}

extension HomeUIViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUITableViewCell") as? HomeUITableViewCell else { return UITableViewCell() }
        cell.setupView(model: model[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY:Int = Int(scrollView.contentOffset.y)
        let contentHeight:Int = Int(scrollView.contentSize.height)
        let frameHeight:Int = Int(scrollView.frame.size.height)
        if contentOffsetY > contentHeight - frameHeight {
            if(!isLoading) {
                isLoading = true
                self.page += 1
                self.getBeerList()
            }
        } else {
            isLoading = false
        }
    }
}
